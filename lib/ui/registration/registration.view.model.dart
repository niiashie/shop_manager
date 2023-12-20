import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class RegistrationViewModel extends BaseViewModel {
  TextEditingController? pinController,
      nameController,
      passwordController,
      confirmPasswordController;

  init() {
    pinController = TextEditingController(text: "");
    nameController = TextEditingController(text: "");
    passwordController = TextEditingController(text: "");
    confirmPasswordController = TextEditingController(text: "");
  }
}
