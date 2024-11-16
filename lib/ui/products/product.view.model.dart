import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:shop_manager/api/product_api.dart';
import 'package:shop_manager/app/locator.dart';
import 'package:shop_manager/models/api_response.dart';
import 'package:shop_manager/models/product.dart';
import 'package:shop_manager/services/app_service.dart';
import 'package:shop_manager/services/dialog.service.dart';
import 'package:shop_manager/ui/products/widgets/product_update.view.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart' as pw;

class ProductViewModel extends BaseViewModel {
  bool showAddProduct = false, isLoading = false, productsLoading = false;
  TextEditingController? name, costPrice, sellingPrice, search, location;
  final GlobalKey<FormState> productAdditionFormKey = GlobalKey<FormState>();
  List<Product> products = [];
  var appService = locator<AppService>();
  ProductApi productApi = ProductApi();
  int currentPage = 1, totalPages = 1;
  Stream<String>? stream;
  StreamSubscription<String>? streamSubscription;

  init() {
    name = TextEditingController(text: "");
    costPrice = TextEditingController(text: "");
    sellingPrice = TextEditingController(text: "");
    search = TextEditingController(text: "");
    location = TextEditingController(text: "N/A");
    getProducts(1);
    listenToBranchChangeEvents();
  }

  @override
  void dispose() {
    // Cancel the subscription and close the stream
    streamSubscription!.cancel();
    super.dispose();
  }

  listenToBranchChangeEvents() {
    stream = appService.branchChangeListenerController.stream;
    streamSubscription = stream!.listen((event) {
      if (appService.currentPage == "products") {
        getProducts(1);
      }
    });
  }

  getProducts(int page) async {
    debugPrint("getting products");
    products.clear();
    try {
      productsLoading = true;
      rebuildUi();
      ApiResponse getProductResponse = await productApi
          .getProducts(appService.selectedBranch!.id.toString(), page: page);
      if (getProductResponse.ok) {
        List<dynamic> data = getProductResponse.data;
        totalPages = getProductResponse.body['last_page'];

        for (var obj in data) {
          products.add(Product(
              id: obj['id'],
              name: obj['name'],
              sellingPrice: double.parse(
                  obj['branch'][0]['pivot']['selling_price'].toString()),
              location: obj['location'],
              quantity: obj['branch'][0]['pivot']['quantity'],
              costPrice: double.parse(obj['cost_price'].toString())));
        }
        productsLoading = false;
        rebuildUi();
      }
    } on DioException catch (e) {
      productsLoading = false;
      rebuildUi();
      ApiResponse errorResponse = ApiResponse.parse(e.response);
      debugPrint(errorResponse.message);
      //appService.showErrorFromApiRequest(message: errorResponse.message!);
    }
  }

  onSearchProduct() async {
    if (search!.text.isEmpty == false) {
      products.clear();
      try {
        productsLoading = true;
        rebuildUi();
        ApiResponse searchResponse = await productApi.searchProduct({
          "keyword": search!.text,
          "branch_id": appService.user!.branches![0].id
        });
        if (searchResponse.ok) {
          List<dynamic> data2 = searchResponse.body;
          for (var obj2 in data2) {
            products.add(Product(
                id: obj2['id'],
                name: obj2['name'],
                sellingPrice: double.parse(
                    obj2['branch'][0]['pivot']['selling_price'].toString()),
                location: obj2['location'],
                quantity: obj2['branch'][0]['pivot']['quantity'],
                costPrice: double.parse(obj2['cost_price'].toString())));
          }
          productsLoading = false;
          rebuildUi();
        }
      } on DioException catch (e) {
        ApiResponse errorResponse = ApiResponse.parse(e.response);
        debugPrint(errorResponse.message);
        appService.showErrorFromApiRequest(message: errorResponse.message!);
      }
    } else {
      appService.showErrorFromApiRequest(
          message: "Please enter product to search", title: "Empty Product");
    }
  }

  changePage(a) {
    currentPage = a;
    getProducts(a);
  }

  editProduct(index) {
    locator<DialogService>().show(
        type: "custom",
        title: "Success",
        customWidget: ProductUpdate(
          product: products[index],
          onProductUpdated: (p) {
            products[index] = p;
            rebuildUi();
          },
        ));
  }

  addProductRequest() async {
    if (appService.user!.role == "manager" ||
        appService.user!.role == "admin") {
      if (productAdditionFormKey.currentState!.validate()) {
        Map<String, dynamic> data = {
          'name': name!.text,
          'cost_price': costPrice!.text,
          'location': location!.text,
          'branch_id': appService.user!.branches![0].id
        };

        try {
          isLoading = true;
          rebuildUi();

          ApiResponse response = await productApi.addProduct(data);
          if (response.ok) {
            Map<String, dynamic> data = response.body;
            debugPrint("body: $data");
            Map<String, dynamic> obj = data['product'][0];
            locator<DialogService>().show(
                type: "success",
                title: "Success",
                message: data['message'],
                showCancelBtn: false,
                onOkayTap: () {
                  Navigator.of(pw.StackedService.navigatorKey!.currentContext!)
                      .pop();
                });
            resetValues();
            products.insert(
                0,
                Product(
                    id: obj['id'],
                    name: obj['name'],
                    sellingPrice: double.parse(
                        obj['branch'][0]['pivot']['selling_price'].toString()),
                    location: obj['location'],
                    quantity: obj['branch'][0]['pivot']['quantity'],
                    costPrice: double.parse(obj['cost_price'].toString())));
            isLoading = false;
            rebuildUi();
          }
        } on DioException catch (e) {
          isLoading = false;
          rebuildUi();
          ApiResponse errorResponse = ApiResponse.parse(e.response);
          debugPrint(errorResponse.message);
          appService.showErrorFromApiRequest(message: errorResponse.message!);
        }
      }
    } else {
      appService.showErrorFromApiRequest(
          message: "Staff not allowed to add products",
          title: "Unauthorized access");
    }
  }

  resetValues() {
    name!.text = "";
    costPrice!.text = "";
    sellingPrice!.text = "";
    location!.text = "N/A";
  }

  addProductTapped() {
    showAddProduct = true;
    rebuildUi();
  }

  closeAddProduct() {
    showAddProduct = false;
    rebuildUi();
  }
}
