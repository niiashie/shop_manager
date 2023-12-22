import 'package:flutter/material.dart';
import 'package:shop_manager/app/locator.dart';
import 'package:shop_manager/models/user.dart';
import 'package:stacked_services/stacked_services.dart' as pw;
import 'package:shop_manager/services/dialog.service.dart';

class AppService {
  User? user;

  showErrorFromApiRequest({String? message, String? title = "Whoops!!!"}) {
    locator<DialogService>().show(
        type: "error",
        title: title,
        message: message,
        showCancelBtn: false,
        onOkayTap: () {
          Navigator.of(pw.StackedService.navigatorKey!.currentContext!).pop();
        });
  }
}
