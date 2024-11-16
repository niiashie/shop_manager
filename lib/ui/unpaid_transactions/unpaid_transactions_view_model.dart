import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shop_manager/api/product_api.dart';
import 'package:shop_manager/app/locator.dart';
import 'package:shop_manager/models/api_response.dart';
import 'package:shop_manager/models/transaction.dart';
import 'package:shop_manager/services/app_service.dart';
import 'package:shop_manager/services/dialog.service.dart' as dialog;
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class UnpaidTransactionsViewModel extends BaseViewModel {
  bool getUnpaidInvoices = false, transactionLoading = false;
  List<Transaction> transactions = [];
  var appService = locator<AppService>();
  ProductApi productApi = ProductApi();
  double historyTotal = 0;
  List<bool> confirmTransactionLoaders = [];
  List<bool> reverseTransactionLoaders = [];
  Color receivedGoodsColor = Colors.grey[500]!;

  receivedGoodsOnHover(bool value) {
    if (value) {
      receivedGoodsColor = Colors.black;
    } else {
      receivedGoodsColor = Colors.grey[500]!;
    }
    rebuildUi();
  }

  getUnpaidTransactions() async {
    try {
      transactionLoading = true;
      transactions.clear();
      confirmTransactionLoaders.clear();
      reverseTransactionLoaders.clear();
      rebuildUi();

      ApiResponse transactionRequest = await productApi
          .getUnpaidTransactions(appService.selectedBranch!.id.toString());
      if (transactionRequest.ok) {
        List<dynamic> data = transactionRequest.body;
        historyTotal = 0;
        for (var obj in data) {
          historyTotal = historyTotal + Transaction.fromJson(obj).total!;

          transactions.add(Transaction.fromJson(obj));
          confirmTransactionLoaders.add(false);
          reverseTransactionLoaders.add(false);
        }
        transactionLoading = false;
        rebuildUi();
      }
    } on DioException catch (e) {
      transactionLoading = false;
      rebuildUi();
      ApiResponse errorResponse = ApiResponse.parse(e.response);
      debugPrint(errorResponse.message);
      appService.showErrorFromApiRequest(message: errorResponse.message!);
    }
  }

  validateCreditSale(int index, String type) {
    if (type == "approve") {
      locator<dialog.DialogService>().show(
          message: "Do you really want to approve this transaction",
          title: "Approve Transaction",
          cancelBtnText: "No",
          type: "warning",
          okayBtnText: "Yes",
          onCancelTap: () {
            Navigator.of(StackedService.navigatorKey!.currentContext!).pop();
          },
          onOkayTap: () {
            Navigator.of(StackedService.navigatorKey!.currentContext!).pop();
            approveCreditSaleRequest(index);
          });
    } else {
      locator<dialog.DialogService>().show(
          message:
              "Do you really want to reverse this transaction? It will be erased from the system.",
          title: "Reverse Transaction",
          cancelBtnText: "No",
          type: "warning",
          okayBtnText: "Yes",
          onCancelTap: () {
            Navigator.of(StackedService.navigatorKey!.currentContext!).pop();
          },
          onOkayTap: () {
            Navigator.of(StackedService.navigatorKey!.currentContext!).pop();
            reverseCreditSaleRequest(index);
          });
    }
  }

  approveCreditSaleRequest(index) async {
    try {
      confirmTransactionLoaders[index] = true;
      rebuildUi();

      ApiResponse response = await productApi.confirmUnpaidTransactions(
          {'transaction_id': transactions[index].id});

      if (response.ok) {
        locator<dialog.DialogService>().show(
            message: response.body['message'],
            title: "Success",
            okayBtnText: "Yes",
            onOkayTap: () {
              Navigator.of(StackedService.navigatorKey!.currentContext!).pop();
            });

        confirmTransactionLoaders[index] = false;
        rebuildUi();
        getUnpaidTransactions();
      }
    } on DioException catch (e) {
      confirmTransactionLoaders[index] = false;
      rebuildUi();
      ApiResponse errorResponse = ApiResponse.parse(e.response);
      debugPrint(errorResponse.message);
      appService.showErrorFromApiRequest(message: errorResponse.message!);
    }
  }

  reverseCreditSaleRequest(index) async {
    try {
      reverseTransactionLoaders[index] = true;
      rebuildUi();

      ApiResponse response = await productApi.reverseUnpaidTransactions(
          {'transaction_id': transactions[index].id});

      if (response.ok) {
        locator<dialog.DialogService>().show(
            message: response.body['message'],
            title: "Success",
            okayBtnText: "Yes",
            onOkayTap: () {
              Navigator.of(StackedService.navigatorKey!.currentContext!).pop();
            });

        reverseTransactionLoaders[index] = false;
        rebuildUi();
        getUnpaidTransactions();
      }
    } on DioException catch (e) {
      reverseTransactionLoaders[index] = false;
      rebuildUi();
      ApiResponse errorResponse = ApiResponse.parse(e.response);
      debugPrint(errorResponse.message);
      appService.showErrorFromApiRequest(message: errorResponse.message!);
    }
  }
}
