import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shop_manager/api/product_api.dart';
import 'package:shop_manager/app/locator.dart';
import 'package:shop_manager/models/api_response.dart';
import 'package:shop_manager/models/requisition.dart';
import 'package:shop_manager/services/app_service.dart';
import 'package:stacked/stacked.dart';

class ReceivedGoodsViewModel extends BaseViewModel {
  List<Requisition> requisitions = [];
  Requisition? selectedRequisition;
  bool isLoading = false, showDetails = false;
  int currentPage = 1, totalPages = 1;
  ProductApi productApi = ProductApi();
  var appService = locator<AppService>();

  init() {
    getRequisitions(currentPage);
  }

  closeRequisitionDetail() {
    showDetails = false;
    rebuildUi();
  }

  viewRequisitionDetail(Requisition requisition) {
    selectedRequisition = requisition;
    showDetails = true;
    rebuildUi();
  }

  getRequisitions(int page) async {
    requisitions.clear();
    try {
      isLoading = true;
      rebuildUi();
      ApiResponse response = await productApi.getAllRequisitions(
          page, appService.selectedBranch!.id!.toString());
      if (response.ok) {
        //debugPrint("result: ${response.data}");
        requisitions = Requisition().addAll(response.data);
        totalPages = response.body['last_page'];
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

  changePage(int p) {
    currentPage = p;
    getRequisitions(p);
  }
}
