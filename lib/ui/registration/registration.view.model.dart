import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shop_manager/api/auth_api.dart';
import 'package:shop_manager/app/locator.dart';
import 'package:shop_manager/constants/routes.dart';
import 'package:shop_manager/models/api_response.dart';
import 'package:shop_manager/services/dialog.service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart' as pw;

import '../../services/app_service.dart';

class RegistrationViewModel extends BaseViewModel {
  TextEditingController? pinController,
      nameController,
      passwordController,
      phoneController,
      confirmPasswordController;
  final GlobalKey<FormState> registrationFormKey = GlobalKey<FormState>();
  var appService = locator<AppService>();
  List<Map<String, dynamic>> res = [];
  bool isLoading = false;
  AuthApi authApi = AuthApi();

  init() {
    pinController = TextEditingController(text: "");
    nameController = TextEditingController(text: "");
    passwordController = TextEditingController(text: "");
    phoneController = TextEditingController(text: "");
    confirmPasswordController = TextEditingController(text: "");
    getAllUsers();
  }

  getAllUsers() async {
    debugPrint("user list : ${res.length}");
  }

  register() async {
    if (registrationFormKey.currentState!.validate()) {
      if (passwordController!.text != confirmPasswordController!.text) {
        locator<DialogService>().show(
            type: "error",
            title: "Invalid Input",
            message: "Please ensure password and confirm password is same",
            showCancelBtn: false,
            onOkayTap: () {
              Navigator.of(pw.StackedService.navigatorKey!.currentContext!)
                  .pop();
            });
      } else {
        Map<String, dynamic> data = {
          "pin": pinController!.text,
          "phone": phoneController!.text,
          "role": "staff",
          "name": nameController!.text,
          "password": passwordController!.text
        };
        try {
          isLoading = true;
          rebuildUi();
          ApiResponse response = await authApi.register(data);
          if (response.ok) {
            Map<String, dynamic> data = response.body;
            isLoading = false;
            rebuildUi();
            locator<DialogService>().show(
                type: "success",
                title: "Success",
                message: data['message'],
                showCancelBtn: false,
                onOkayTap: () {
                  Navigator.of(pw.StackedService.navigatorKey!.currentContext!)
                      .pop();
                  Navigator.of(pw.StackedService.navigatorKey!.currentContext!)
                      .pushReplacementNamed(Routes.login);
                });
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
  }
}
