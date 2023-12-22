import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shop_manager/api/auth_api.dart';
import 'package:shop_manager/app/locator.dart';
import 'package:shop_manager/constants/routes.dart';
import 'package:shop_manager/models/api_response.dart';
import 'package:shop_manager/models/user.dart';
import 'package:shop_manager/services/app_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart' as pw;

class LoginViewModel extends BaseViewModel {
  TextEditingController? pinController, passwordController;
  var appService = locator<AppService>();
  final GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();
  bool isLoading = false;
  AuthApi authApi = AuthApi();

  init() {
    pinController = TextEditingController(text: "");
    passwordController = TextEditingController(text: "");
  }

  login() async {
    if (loginFormKey.currentState!.validate()) {
      Map<String, dynamic> data = {
        'pin': pinController!.text,
        'password': passwordController!.text
      };

      try {
        isLoading = true;
        rebuildUi();
        ApiResponse loginResponse = await authApi.login(data);
        if (loginResponse.ok) {
          Map<String, dynamic> data = loginResponse.body;
          isLoading = false;
          rebuildUi();
          if (data['user']['access'] == "pending") {
            appService.showErrorFromApiRequest(
                title: "Account Unverified",
                message:
                    "User account pending verification. Contact admin to allow access");
          } else {
            appService.user = User.fromJson(loginResponse.body);
            Navigator.of(pw.StackedService.navigatorKey!.currentContext!)
                .pushReplacementNamed(Routes.dashboard);
          }
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
