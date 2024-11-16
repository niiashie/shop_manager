import 'dart:async';

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

class ProfitViewModel extends BaseViewModel {
  var appService = locator<AppService>();
  TextEditingController? startDate, endDate;
  bool transactionLoading = false;
  List<Transaction> transactions = [];
  DateTime? startDateTime, endDateTime;
  ProductApi productApi = ProductApi();
  String startDateValue = "", endDateValue = "";
  double total = 0;
  Stream<String>? stream;
  StreamSubscription<String>? streamSubscription;

  init() {
    startDate =
        TextEditingController(text: DateFormat.yMMMd().format(DateTime.now()));
    endDate =
        TextEditingController(text: DateFormat.yMMMd().format(DateTime.now()));
    startDateValue = DateTime.now().toString().substring(0, 10);
    endDateValue = DateTime.now().toString().substring(0, 10);
    startDateTime = DateTime.now();
    endDateTime = DateTime.now();
    getTransactions({
      "start_date": DateTime.now().toString().substring(0, 10),
      "end_date": DateTime.now().toString().substring(0, 10),
      "branch_id": appService.selectedBranch!.id.toString()
    });
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
      if (appService.currentPage == "profile") {
        getTransactions({
          "start_date": DateTime.now().toString().substring(0, 10),
          "end_date": DateTime.now().toString().substring(0, 10),
          "branch_id": appService.selectedBranch!.id.toString()
        });
      }
    });
  }

  onFilterTapped() {
    if (startDateValue.isEmpty) {
      appService.showErrorFromApiRequest(
          message: "Start date required", title: "Invalid Entry");
    } else if (endDateValue.isEmpty) {
      appService.showErrorFromApiRequest(
          message: "End date required", title: "Invalid Entry");
    } else if (endDateTime!.difference(startDateTime!).inDays < 0) {
      appService.showErrorFromApiRequest(
          message: "End date must be ahead of start date",
          title: "Invalid Entry");
    } else {
      getTransactions({
        "start_date": startDateValue,
        "end_date": endDateValue,
        "branch_id": appService.selectedBranch!.id.toString()
      });
    }
  }

  String getTotalProfit(Transaction t) {
    double totalProfit = 0;
    for (var obj in t.transactionProducts!) {
      double profit = obj.amount! - (obj.costPrice! * obj.quantity!);

      totalProfit = totalProfit + profit;
    }

    return totalProfit.toStringAsFixed(2);
  }

  getTransactions(Map<String, dynamic> data) async {
    debugPrint("Getting profits");
    try {
      transactionLoading = true;
      transactions.clear();
      rebuildUi();

      ApiResponse transactionRequest =
          await productApi.getTransactionRange(data);
      if (transactionRequest.ok) {
        List<dynamic> data = transactionRequest.body;
        total = 0;
        for (var obj in data) {
          total =
              total + double.parse(getTotalProfit(Transaction.fromJson(obj)));

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
      if (controller == startDate) {
        startDateTime = pickedDate;
        startDateValue = pickedDate.toString().substring(0, 10);
      } else {
        endDateTime = pickedDate;
        endDateValue = pickedDate.toString().substring(0, 10);
      }

      //debugPrint("Selected date is : $selectedDate");
      controller.text = DateFormat.yMMMd().format(pickedDate);
    }
    rebuildUi();
  }
}
