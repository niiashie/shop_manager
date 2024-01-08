import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:shop_manager/api/product_api.dart';
import 'package:shop_manager/app/locator.dart';
import 'package:shop_manager/models/api_response.dart';
import 'package:shop_manager/models/product.dart';
import 'package:shop_manager/services/app_service.dart';
import 'package:shop_manager/services/dialog.service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart' as pw;

class ShopViewModel extends BaseViewModel {
  List<Widget> productRows = [];
  List<String> productList = ['Product A', 'Product B'];
  Map<String, double> productPrices = {"Product A": 120, "Product B": 45};
  List<Map<String, dynamic>> productSelections = [];
  List<Product> allProducts = [];
  List<TextEditingController> productUnitPrices = [];
  List<TextEditingController> productQuantity = [];
  List<TextEditingController> productAmount = [];
  List<Product> productSelection = [];
  ProductApi productApi = ProductApi();
  bool getProductLoading = false, makeTransactionLoading = false;
  double total = 0;
  var appService = locator<AppService>();
  TextEditingController? cusName, cusPhone;

  addProductRow() {
    productSelection.add(allProducts[0]);
    productUnitPrices.add(TextEditingController(text: ""));
    productQuantity.add(TextEditingController(text: ""));
    productAmount.add(TextEditingController(text: ""));

    rebuildUi();
  }

  init() {
    cusName = TextEditingController(text: "");
    cusPhone = TextEditingController(text: "");
    getAllProducts();
  }

  getAllProducts() async {
    getProductLoading = true;
    rebuildUi();
    try {
      ApiResponse response = await productApi.getAllProducts();
      if (response.ok) {
        List<dynamic> results = response.body;
        for (var obj in results) {
          allProducts.add(Product.fromJson(obj));
        }
        getProductLoading = false;
        rebuildUi();
      }
    } on DioException catch (e) {
      getProductLoading = false;
      rebuildUi();
      ApiResponse errorResponse = ApiResponse.parse(e.response);
      debugPrint(errorResponse.message);
      appService.showErrorFromApiRequest(message: errorResponse.message!);
    }
  }

  computeTotal() {
    total = 0;
    for (var obj in productAmount) {
      if (obj.text.isEmpty) {
        total = total + 0;
      } else {
        total = total + double.parse(obj.text);
      }
    }
  }

  setProduct(Product product, index) {
    productSelection[index] = product;
    productUnitPrices[index].text = product.sellingPrice.toString();
    productQuantity[index].text = "";
    productAmount[index].text = "";
    computeTotal();
    rebuildUi();
  }

  clearProductSelection() {
    productSelection.clear();
    productUnitPrices.clear();
    productQuantity.clear();
    productAmount.clear();
    computeTotal();
    rebuildUi();
  }

  onQuantityChanged(String a, int index) {
    int productQuantity2 = productSelection[index].quantity!;
    if (int.parse(a) <= productQuantity2) {
      double amount =
          double.parse(a) * double.parse(productUnitPrices[index].text);
      productAmount[index].text = amount.toString();

      computeTotal();
    } else {
      appService.showErrorFromApiRequest(
          title: "Invalid Input",
          message: "Available quantity of the product is $productQuantity2");
      productQuantity[index].text = "";
    }
    rebuildUi();
  }

  resetQuantity(int index) {
    productQuantity[index].text = "";
    productAmount[index].text = "";
    computeTotal();
    rebuildUi();
  }

  bool validateEntry() {
    int errorCounter = 0;
    for (var i = 0; i < productSelection.length; i++) {
      if (productQuantity[i].text.isEmpty) {
        errorCounter++;
      } else if (productQuantity[i].text == "0") {
        errorCounter++;
      }
    }
    if (errorCounter > 0) {
      return true;
    } else {
      return false;
    }
  }

  bool validateDuplicateProduct() {
    int errorCount = 0;
    List<Product> subProducts = [];
    for (var obj in productSelection) {
      if (subProducts.contains(
          productSelection.where((element) => element.id == obj.id).first)) {
        errorCount++;
      } else {
        subProducts.add(obj);
      }
    }
    if (errorCount > 0) {
      return true;
    } else {
      return false;
    }
  }

  List<Map<String, dynamic>> formatProduct() {
    List<Map<String, dynamic>> items = [];
    for (int i = 0; i < productSelection.length; i++) {
      items.add({
        "product_id": productSelection[i].id,
        "quantity": productQuantity[i].text,
        "amount": productAmount[i].text
      });
    }

    return items;
  }

  removeProduct(int index) {
    productSelection.removeAt(index);
    productUnitPrices.removeAt(index);
    productQuantity.removeAt(index);
    productAmount.removeAt(index);
    computeTotal();
    rebuildUi();
  }

  submitTransaction() async {
    if (validateEntry() == true) {
      appService.showErrorFromApiRequest(
          title: "Invalid Entry",
          message: "Please ensure all fileds are filled");
    } else if (productSelection.isEmpty) {
      appService.showErrorFromApiRequest(
          title: "Invalid Entry",
          message: "Please select products before submitting transaction");
    } else if (validateDuplicateProduct() == true) {
      appService.showErrorFromApiRequest(
          title: "Duplicate Entry",
          message: "Please check entries to avoid duplicate product selection");
    } else {
      Map<String, dynamic> data = {
        "customer": "${cusName!.text} ${cusPhone!.text}",
        "user_id": appService.user!.id,
        "total": total,
        "products": formatProduct()
      };
      debugPrint("Sent data is : $data");
      try {
        makeTransactionLoading = true;
        rebuildUi();
        ApiResponse response = await productApi.makeTransaction(data);
        if (response.ok) {
          Map<String, dynamic> data = response.body;
          // pendingRequisitions.add(Requisition.fromJson(data['requisition']));
          locator<DialogService>().show(
              type: "success",
              title: "Success",
              message: data['message'],
              showCancelBtn: false,
              onOkayTap: () {
                Navigator.of(pw.StackedService.navigatorKey!.currentContext!)
                    .pop();
              });
          clearProductSelection();
          cusName!.text = "";
          cusPhone!.text = "";
          makeTransactionLoading = false;
          rebuildUi();
        }
      } on DioException catch (e) {
        makeTransactionLoading = false;
        rebuildUi();
        ApiResponse errorResponse = ApiResponse.parse(e.response);
        debugPrint(errorResponse.message);
        appService.showErrorFromApiRequest(message: errorResponse.message!);
      }
    }
  }
}
