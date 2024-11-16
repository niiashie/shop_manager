import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:shop_manager/api/customer_api.dart';
import 'package:shop_manager/api/product_api.dart';
import 'package:shop_manager/app/locator.dart';
import 'package:shop_manager/models/api_response.dart';
import 'package:shop_manager/models/customer.dart';
import 'package:shop_manager/models/product.dart';
import 'package:shop_manager/services/app_service.dart';
import 'package:shop_manager/services/dialog.service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart' as pw;

class ShopViewModel extends BaseViewModel {
  List<Widget> productRows = [];
  List<String> transactionTypes = ['Cash', 'Credit'];
  Map<String, double> productPrices = {"Product A": 120, "Product B": 45};
  List<Map<String, dynamic>> productSelections = [];
  List<Product> allProducts = [];
  List<Customer> allCustomers = [];
  List<TextEditingController> productUnitPrices = [];
  List<TextEditingController> productQuantity = [];
  List<TextEditingController> productAmount = [];
  List<Product> productSelection = [];
  ProductApi productApi = ProductApi();
  CustomerApi customerApi = CustomerApi();
  bool getProductLoading = false, makeTransactionLoading = false;
  double total = 0;
  var appService = locator<AppService>();
  String? selectedTransactionType, selectedCustomer;
  TextEditingController? cusName, cusPhone;
  Stream<String>? stream;
  late StreamSubscription<String> streamSubscription;

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
    listenToBranchChangeEvents();
  }

  setSelectedTransactionType(String a) {
    selectedTransactionType = a;
    rebuildUi();
  }

  setSelectedCustomer(a) {
    selectedCustomer = a;
    rebuildUi();
  }

  getAllCustomers() async {
    try {
      ApiResponse getProductResponse = await customerApi.getAllCustomers();
      if (getProductResponse.ok) {
        List<dynamic> data = getProductResponse.body;
        allCustomers.clear();
        for (var obj in data) {
          allCustomers.add(Customer.fromJson(obj));
        }
      }
    } on DioException catch (e) {
      ApiResponse errorResponse = ApiResponse.parse(e.response);
      debugPrint(errorResponse.message);
      appService.showErrorFromApiRequest(message: errorResponse.message!);
    }
  }

  @override
  void dispose() {
    // Cancel the subscription and close the stream
    streamSubscription.cancel();
    super.dispose();
  }

  listenToBranchChangeEvents() {
    stream = appService.branchChangeListenerController.stream;
    streamSubscription = stream!.listen((event) {
      if (appService.currentPage == "shop") {
        getAllProducts();
      }
    });
  }

  getAllProducts() async {
    getProductLoading = true;
    rebuildUi();
    try {
      ApiResponse response = await productApi
          .getAllProducts(appService.selectedBranch!.id!.toString());
      if (response.ok) {
        List<dynamic> results = response.body;
        for (var obj in results) {
          allProducts.add(Product(
              id: obj['id'],
              name: obj['name'],
              sellingPrice: double.parse(
                  obj['branch'][0]['pivot']['selling_price'].toString()),
              location: obj['location'],
              quantity: obj['branch'][0]['pivot']['quantity'],
              costPrice: double.parse(obj['cost_price'].toString())));
          //allProducts.add(Product.fromJson(obj));
        }
        await getAllCustomers();
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

  setCreditCustomer(Customer customer) {
    selectedCustomer = customer.id.toString();

    rebuildUi();
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
    } else if (selectedTransactionType == null) {
      appService.showErrorFromApiRequest(
          title: "Invalid Entry",
          message: "Please select transaction type to proceed");
    } else if (productSelection.isEmpty) {
      appService.showErrorFromApiRequest(
          title: "Invalid Entry",
          message: "Please select products before submitting transaction");
    } else if (validateDuplicateProduct() == true) {
      appService.showErrorFromApiRequest(
          title: "Duplicate Entry",
          message: "Please check entries to avoid duplicate product selection");
    } else if (selectedTransactionType == "Credit" &&
        selectedCustomer == null) {
      appService.showErrorFromApiRequest(
          title: "Customer",
          message: "Select customer to proceed with credit sales");
    } else {
      Map<String, dynamic> data = {
        "customer_id": selectedCustomer,
        "user_id": appService.user!.id,
        "total": total,
        "type": selectedTransactionType!.toLowerCase(),
        "branch_id": appService.selectedBranch!.id,
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
