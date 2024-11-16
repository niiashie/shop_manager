import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shop_manager/api/product_api.dart';
import 'package:shop_manager/app/locator.dart';
import 'package:shop_manager/models/api_response.dart';
import 'package:shop_manager/models/transaction.dart';
import 'package:shop_manager/services/app_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart' as pw;

class StockViewModel extends BaseViewModel {
  TextEditingController? date, startDate, endDate;
  String selectedDate = "", startDateValue = "", endDateValue = "";
  double total = 0, historyTotal = 0;
  bool transactionLoading = false, showTransactionHistory = false;
  List<Transaction> transactions = [];
  ProductApi productApi = ProductApi();
  Stream? stream;
  var appService = locator<AppService>();
  init() {
    date =
        TextEditingController(text: DateFormat.yMMMd().format(DateTime.now()));
    startDate = TextEditingController(text: "");
    endDate = TextEditingController(text: "");
    getTransactions({
      "date": DateTime.now().toString().substring(0, 10),
      "branch_id": appService.selectedBranch!.id.toString()
    });
    listenToBranchChangeEvents();
    //debugPrint("Today is ${DateTime.now()}");
    //DateFormat.yMMMd().format(pickedDate)
  }

  showHistory() {
    showTransactionHistory = true;
    transactions.clear();
    rebuildUi();
  }

  showTodayTransaction() {
    showTransactionHistory = false;
    transactions.clear();
    date =
        TextEditingController(text: DateFormat.yMMMd().format(DateTime.now()));
    getTransactions({
      "date": DateTime.now().toString().substring(0, 10),
      "branch_id": appService.selectedBranch!.id.toString()
    });
  }

  filterTransactions() {
    if (endDate!.text.isEmpty) {
      appService.showErrorFromApiRequest(
          message: "End date is required please");
    } else if (startDate!.text.isEmpty) {
      appService.showErrorFromApiRequest(
          message: "Start date is required please");
    } else {
      getTransactions2({
        "start_date": startDateValue,
        "end_date": endDateValue,
        "branch_id": appService.selectedBranch!.id.toString()
      });
    }
  }

  listenToBranchChangeEvents() {
    stream = appService.branchChangeListenerController.stream;
    stream!.listen((event) {
      if (appService.currentPage == "stocks") {
        getTransactions({
          "date": DateTime.now().toString().substring(0, 10),
          "branch_id": appService.selectedBranch!.id.toString()
        });
      }
    });
  }

  getTransactions2(Map<String, dynamic> data) async {
    try {
      transactionLoading = true;
      transactions.clear();
      rebuildUi();

      ApiResponse transactionRequest =
          await productApi.getTransactionRange(data);
      if (transactionRequest.ok) {
        List<dynamic> data = transactionRequest.body;
        historyTotal = 0;
        for (var obj in data) {
          historyTotal = historyTotal + Transaction.fromJson(obj).total!;

          transactions.add(Transaction.fromJson(obj));
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

  getTransactions(Map<String, dynamic> data) async {
    debugPrint("getting transactions");
    try {
      transactionLoading = true;
      transactions.clear();
      rebuildUi();

      ApiResponse transactionRequest = await productApi.getTransactions(data);
      if (transactionRequest.ok) {
        List<dynamic> data = transactionRequest.body;
        total = 0;

        for (var obj in data) {
          total = total + Transaction.fromJson(obj).total!;
          transactions.add(Transaction.fromJson(obj));
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

  selectDate(TextEditingController controller) async {
    DateTime? pickedDate = await showDatePicker(
        context: pw.StackedService.navigatorKey!.currentContext!,
        initialDate: DateTime.now(),
        firstDate: DateTime(1950),
        lastDate: DateTime(2050));
    if (pickedDate != null) {
      if (controller == date) {
        selectedDate = pickedDate.toString().substring(0, 10);
      } else if (controller == startDate) {
        startDateValue = pickedDate.toString().substring(0, 10);
      } else if (controller == endDate) {
        endDateValue = pickedDate.toString().substring(0, 10);
      }

      //debugPrint("Selected date is : $selectedDate");
      controller.text = DateFormat.yMMMd().format(pickedDate);
    }
    rebuildUi();
  }
}
