// ignore_for_file: prefer_const_constructors, sort_child_properties_last, prefer_if_null_operators

import 'package:flutter/material.dart';
import 'package:shop_manager/ui/shared/dialogs/error.dialog.dart';
import 'package:shop_manager/ui/shared/dialogs/success.dialog.dart';
import 'package:shop_manager/ui/shared/dialogs/warning.dialog.dart';
import 'package:stacked_services/stacked_services.dart';

class DialogService {
  Future show(
      {String? message,
      String? title,
      String okayBtnText = "Okay",
      String cancelBtnText = "Cancel",
      VoidCallback? onOkayTap,
      VoidCallback? onCancelTap,
      bool barrierDismissible = true,
      bool autoClose = true,
      double? height = 130,
      bool showCancelBtn = true,
      String? notice,
      double? width = 350,
      String type = "success",
      Widget? customWidget}) {
    return showDialog(
      context: StackedService.navigatorKey!.currentContext!,
      barrierDismissible: barrierDismissible,
      builder: (BuildContext context) {
        Widget dialog;
        switch (type) {
          case 'success':
            dialog = SucessDialog(
                okayText: okayBtnText,
                cancelText: cancelBtnText,
                title: title,
                message: message,
                hasCancel: showCancelBtn,
                onCancelTapped: () {
                  onCancelTap!();
                },
                onOkayTapped: () {
                  onOkayTap!();
                });
            break;
          case 'error':
            dialog = ErrorDialog(
                okayText: okayBtnText,
                cancelText: cancelBtnText,
                title: title,
                message: message,
                hasCancel: showCancelBtn,
                onCancelTapped: () {
                  onCancelTap!();
                },
                onOkayTapped: () {
                  onOkayTap!();
                });
          case 'warning':
            dialog = WarningDialog(
                okayText: okayBtnText,
                cancelText: cancelBtnText,
                title: title,
                message: message,
                hasCancel: showCancelBtn,
                onCancelTapped: () {
                  onCancelTap!();
                },
                onOkayTapped: () {
                  onOkayTap!();
                });
          case 'custom':
            dialog = Dialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
              child: customWidget,
            );
          default:
            dialog = SucessDialog(
                okayText: okayBtnText,
                cancelText: cancelBtnText,
                title: title,
                hasCancel: showCancelBtn,
                message: message,
                onCancelTapped: () {
                  onCancelTap!();
                },
                onOkayTapped: () {
                  onOkayTap!();
                });
            break;
        }

        return dialog;
      },
    );
  }
}
