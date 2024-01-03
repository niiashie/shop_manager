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
  String registeredProducts = "", productsValue = "", salesToday = "";
  bool isLoading = false;
  List<Product> products = [];
  Map<String, double> mapDdata = {};
  List<String> days = [DateTime.now().toString().substring(0, 10)];
  List<double> daySales = [0];
  var appService = locator<AppService>();
  getDashboardValues() async {
    try {
      isLoading = true;
      rebuildUi();
      ApiResponse response = await productApi.getDashboardValues(
          {"date": DateTime.now().toString().substring(0, 10)});
      if (response.ok) {
        Map<String, dynamic> data = response.body;
        registeredProducts = data['products'].toString();
        productsValue = data['products_value'].toString();
        salesToday = data['sales_today'].toString();
        List<dynamic> p = data['acsending'];
        for (var obj in p) {
          products.add(Product.fromJson(obj));
        }

        //get sale plotting
        if (data['sale'] is Map<String, dynamic>) {
          Map<String, dynamic> sale = data['sale'];
          for (var ob in sale.keys) {
            List<dynamic> saleItems = sale[ob];
            double total = 0;
            days.add(ob);
            for (var o in saleItems) {
              total = total + double.parse(o['total'].toString());
              debugPrint("Total: ${o['total']}");
            }
            mapDdata[ob] = total;
            daySales.add(total);
          }
          days.removeAt(0);
          daySales.removeAt(0);
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
}
