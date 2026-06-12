import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shop_manager/api/product_api.dart';
import 'package:shop_manager/app/locator.dart';
import 'package:shop_manager/models/api_response.dart';
import 'package:shop_manager/models/product.dart';
import 'package:shop_manager/models/stock_history.dart';
import 'package:shop_manager/services/app_service.dart';
import 'package:stacked/stacked.dart';

class ProductHistoryViewModel extends BaseViewModel {
  final Product product;

  ProductHistoryViewModel({required this.product});

  ProductApi productApi = ProductApi();
  var appService = locator<AppService>();

  List<StockHistory> history = [];
  Map<String, dynamic>? currentStock;
  int currentPage = 1;
  int totalPages = 1;
  bool loading = false;

  init() {
    loadHistory(1);
  }

  loadHistory(int page) async {
    loading = true;
    rebuildUi();
    try {
      ApiResponse response = await productApi.getStockHistory(
        appService.selectedBranch!.id!.toString(),
        product.id!.toString(),
        page: page,
      );
      if (response.ok) {
        currentStock =
            Map<String, dynamic>.from(response.body['current_stock']);
        final historyMap =
            Map<String, dynamic>.from(response.body['history']);
        totalPages = historyMap['last_page'] ?? 1;
        currentPage = historyMap['current_page'] ?? 1;
        history = (historyMap['data'] as List)
            .map((e) => StockHistory.fromJson(e))
            .toList();
      }
    } on DioException catch (e) {
      ApiResponse errorResponse = ApiResponse.parse(e.response);
      debugPrint(errorResponse.message);
      appService.showErrorFromApiRequest(message: errorResponse.message!);
    }
    loading = false;
    rebuildUi();
  }

  changePage(int page) {
    currentPage = page;
    loadHistory(page);
  }
}
