import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shop_manager/api/product_api.dart';
import 'package:shop_manager/app/locator.dart';
import 'package:shop_manager/models/api_response.dart';
import 'package:shop_manager/models/product.dart';
import 'package:shop_manager/models/requisition.dart';
import 'package:shop_manager/services/app_service.dart';
import 'package:shop_manager/services/dialog.service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart' as pw;

class RequisitionViewModel extends BaseViewModel {
  TextEditingController? description;
  var appService = locator<AppService>();
  List<Product> productSelection = [];
  List<TextEditingController> productUnitPrice = [];
  List<TextEditingController> productQuantity = [];
  List<TextEditingController> productAmount = [];
  List<Product> allProducts = [];
  ProductApi productApi = ProductApi();
  bool getProductLoading = false,
      submitRequisitionLoading = false,
      showPendingRequisition = false,
      acceptRequisitionLoading = false,
      rejectRequisitionLoading = false;
  double total = 0;
  Product? selectedProduct;
  List<Requisition> pendingRequisitions = [];
  List<dynamic> pendingRequisitionProducts = [];

  init() {
    description = TextEditingController(text: "");
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
        getPendingRequisition();
      }
    } on DioException catch (e) {
      getProductLoading = false;
      rebuildUi();
      ApiResponse errorResponse = ApiResponse.parse(e.response);
      debugPrint(errorResponse.message);
      appService.showErrorFromApiRequest(message: errorResponse.message!);
    }
  }

  closePendingRequisitions() {
    showPendingRequisition = false;
    rebuildUi();
  }

  showPendingRequisitions() {
    showPendingRequisition = true;
    rebuildUi();
  }

  rejectRequisition() async {
    try {
      rejectRequisitionLoading = true;
      rebuildUi();

      ApiResponse rejectRequisitionResponse = await productApi
          .rejectRequisition(pendingRequisitions[0].id.toString());
      if (rejectRequisitionResponse.ok) {
        Map<String, dynamic> data = rejectRequisitionResponse.body;
        locator<DialogService>().show(
            type: "success",
            title: "Success",
            message: data['message'],
            showCancelBtn: false,
            onOkayTap: () {
              showPendingRequisition = false;
              Navigator.of(pw.StackedService.navigatorKey!.currentContext!)
                  .pop();
              init();
            });
      }
    } on DioException catch (e) {
      rejectRequisitionLoading = false;
      rebuildUi();
      ApiResponse errorResponse = ApiResponse.parse(e.response);
      debugPrint(errorResponse.message);
      appService.showErrorFromApiRequest(message: errorResponse.message!);
    }
  }

  acceptRequisition() async {
    try {
      acceptRequisitionLoading = true;
      rebuildUi();

      ApiResponse acceptRequisitionResponse = await productApi
          .acceptRequisition(pendingRequisitions[0].id.toString());
      if (acceptRequisitionResponse.ok) {
        Map<String, dynamic> data = acceptRequisitionResponse.body;
        locator<DialogService>().show(
            type: "success",
            title: "Success",
            message: data['message'],
            showCancelBtn: false,
            onOkayTap: () {
              showPendingRequisition = false;
              Navigator.of(pw.StackedService.navigatorKey!.currentContext!)
                  .pop();
              init();
            });
      }
    } on DioException catch (e) {
      acceptRequisitionLoading = false;
      rebuildUi();
      ApiResponse errorResponse = ApiResponse.parse(e.response);
      debugPrint(errorResponse.message);
      appService.showErrorFromApiRequest(message: errorResponse.message!);
    }
  }

  getPendingRequisition() async {
    pendingRequisitions.clear();
    try {
      ApiResponse response2 = await productApi.getPendingRequisition();
      if (response2.ok) {
        Map<String, dynamic> data2 = response2.body;
        if (data2['pending_requisition'] != "empty") {
          pendingRequisitions
              .add(Requisition.fromJson(data2['pending_requisition']));
          pendingRequisitionProducts = data2['products'];
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

  addBatch() {
    if (allProducts.isEmpty) {
      appService.showErrorFromApiRequest(
          title: "No Available Products",
          message: "Please add products to proceed");
    } else {
      productSelection.add(allProducts[0]);
      productUnitPrice.add(
          TextEditingController(text: allProducts[0].sellingPrice.toString()));
      productQuantity.add(TextEditingController(text: ""));
      productAmount.add(TextEditingController(text: ""));
      rebuildUi();
    }
  }

  setProduct(Product product, index) {
    productSelection[index] = product;
    productUnitPrice[index].text = product.sellingPrice.toString();
    rebuildUi();
  }

  invalidQuantity(index) {
    productQuantity[index].text = "";
    productAmount[index].text = "";
    rebuildUi();
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

  quantityOnChanged(index) {
    double unitPrice = double.parse(productUnitPrice[index].text);
    productAmount[index].text =
        (unitPrice * int.parse(productQuantity[index].text)).toString();
    computeTotal();
    rebuildUi();
  }

  removeProduct(index) {
    productSelection.removeAt(index);
    productUnitPrice.removeAt(index);
    productQuantity.removeAt(index);
    productAmount.removeAt(index);
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
        "quantity": productQuantity[i].text
      });
    }

    return items;
  }

  clearProductSelection() {
    productSelection.clear();
    productUnitPrice.clear();
    productQuantity.clear();
    productAmount.clear();
    computeTotal();
    rebuildUi();
  }

  submitRequisition() async {
    if (validateEntry() == true) {
      appService.showErrorFromApiRequest(
          title: "Invalid Entry",
          message: "Please ensure all fileds are filled");
    } else if (productSelection.isEmpty) {
      appService.showErrorFromApiRequest(
          title: "Invalid Entry",
          message: "Please select products before submitting requisition");
    } else if (validateDuplicateProduct() == true) {
      appService.showErrorFromApiRequest(
          title: "Duplicate Entry",
          message: "Please check entries to avoid duplicate product selection");
    } else if (description!.text.isEmpty) {
      appService.showErrorFromApiRequest(
          title: "Invalid Entry", message: "Please describe requisition");
    } else if (pendingRequisitions.isNotEmpty) {
      appService.showErrorFromApiRequest(
          title: "Pending Requisition",
          message:
              "Please contact manager to accept pending requisition to proceed");
    } else {
      Map<String, dynamic> data = {
        "description": description!.text,
        "user_id": appService.user!.id,
        "total": total,
        "products": formatProduct()
      };
      debugPrint("Sent data is : $data");
      try {
        submitRequisitionLoading = true;
        rebuildUi();
        ApiResponse response = await productApi.sendRequisition(data);
        if (response.ok) {
          Map<String, dynamic> data = response.body;
          pendingRequisitions.add(Requisition.fromJson(data['requisition']));
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
          submitRequisitionLoading = false;
          rebuildUi();
        }
      } on DioException catch (e) {
        submitRequisitionLoading = false;
        rebuildUi();
        ApiResponse errorResponse = ApiResponse.parse(e.response);
        debugPrint(errorResponse.message);
        appService.showErrorFromApiRequest(message: errorResponse.message!);
      }
    }
  }
}
