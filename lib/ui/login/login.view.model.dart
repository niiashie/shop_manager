import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class LoginViewModel extends BaseViewModel {
  TextEditingController? pinController, passwordController;

  init() {
    pinController = TextEditingController(text: "");
    passwordController = TextEditingController(text: "");
  }
}
