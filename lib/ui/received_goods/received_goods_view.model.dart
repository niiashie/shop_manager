import 'dart:async';

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
  Stream<String>? stream;
  StreamSubscription<String>? streamSubscription;

  init() {
    getRequisitions(currentPage);
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
      if (appService.currentPage == "receivedGoods") {
        getRequisitions(1);
      }
    });
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
    debugPrint("getting requisitions");
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
