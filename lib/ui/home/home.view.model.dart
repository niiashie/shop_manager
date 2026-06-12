import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shop_manager/api/product_api.dart';
import 'package:shop_manager/app/locator.dart';
import 'package:shop_manager/models/api_response.dart';
import 'package:shop_manager/models/product.dart';
import 'package:shop_manager/services/app_service.dart';
import 'package:stacked/stacked.dart';

class HomeViewModel extends BaseViewModel {
  ProductApi productApi = ProductApi();
  String registeredProducts = "",
      productsValue = "",
      salesToday = "",
      unpaidSales = "";
  bool isLoading = false;
  List<Product> products = [];
  Map<String, double> mapDdata = {};
  List<String> days = [];
  List<double> daySales = [];
  List<String> topProductNames = [];
  List<double> topProductUnits = [];
  int cashCount = 0;
  int creditCount = 0;
  var appService = locator<AppService>();
  Stream<String>? stream;
  StreamSubscription<String>? streamSubscription;

  init() {
    getDashboardValues();
    listenToBranchChangeEvents();
  }

  @override
  void dispose() {
    // Cancel the subscription and close the stream
    streamSubscription!.cancel();
    super.dispose();
  }

  getDashboardValues() async {
    cashCount = 0;
    creditCount = 0;
    try {
      isLoading = true;
      rebuildUi();
      ApiResponse response = await productApi.getDashboardValues({
        "date": DateTime.now().toString().substring(0, 10),
        "branch_id": appService.selectedBranch!.id
      });

      if (response.ok) {
        Map<String, dynamic> data = response.body;
        registeredProducts = data['products'].toString();
        productsValue =
            double.parse(data['products_value'].toString()).toStringAsFixed(2);
        salesToday = data['sales_today'].toString();
        unpaidSales = data['unpaid_sales'].toString();
        List<dynamic> p = data['acsending'];
        products.clear();

        for (var obj in p) {
          products.add(Product(
              id: obj['product']['id'],
              name: obj['product']['name'],
              costPrice: double.parse(obj['product']['cost_price'].toString()),
              sellingPrice: double.parse(obj['selling_price'].toString()),
              location: obj['product']['location'],
              quantity: int.parse(obj['quantity'].toString())));
          // products.add(Product.fromJson(obj['product']));
        }

        //get sale plotting
        if (data['sale'] is Map<String, dynamic>) {
          Map<String, dynamic> sale = data['sale'];
          days.clear();
          daySales.clear();
          for (var ob in sale.keys) {
            List<dynamic> saleItems = sale[ob];
            double total = 0;
            days.add(ob);
            for (var o in saleItems) {
              total = total + double.parse(o['total'].toString());
              if (o['type'] == 'cash') {
                cashCount++;
              } else if (o['type'] == 'credit') {
                creditCount++;
              }
            }
            mapDdata[ob] = total;
            daySales.add(total);
          }
        }

        topProductNames.clear();
        topProductUnits.clear();
        List<dynamic> topP = data['top_products'] ?? [];
        for (var obj in topP) {
          topProductNames.add(obj['product']['name']);
          topProductUnits
              .add(double.parse(obj['total_units'].toString()));
        }

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

  listenToBranchChangeEvents() {
    stream = appService.branchChangeListenerController.stream;
    streamSubscription = stream!.listen((event) {
      getDashboardValues();
    });
  }
}
