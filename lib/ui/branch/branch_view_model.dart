import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shop_manager/api/auth_api.dart';
import 'package:shop_manager/app/locator.dart';
import 'package:shop_manager/models/api_response.dart';
import 'package:shop_manager/models/branch.dart';
import 'package:shop_manager/services/app_service.dart';
import 'package:stacked/stacked.dart';

class BranchViewModel extends BaseViewModel {
  List<Branch> branches = [];
  bool branchLoading = false, showAddBranch = false, isLoading = false;
  TextEditingController? name, phone, address;
  AuthApi authApi = AuthApi();
  var appService = locator<AppService>();
  final GlobalKey<FormState> customerAdditionFormKey = GlobalKey<FormState>();

  init() {
    name = TextEditingController(text: "");
    phone = TextEditingController(text: "");
    address = TextEditingController(text: "");
    getBranches();
  }

  closeAddBranchDialog() {
    showAddBranch = false;
    rebuildUi();
  }

  displayAddBranchDialog() {
    showAddBranch = true;
    rebuildUi();
  }

  addBranchRequest() {}

  getBranches() async {
    branchLoading = true;
    rebuildUi();
    try {
      ApiResponse response = await authApi.getBranches();
      if (response.ok) {
        List<dynamic> data = response.body;
        branches.clear();
        for (var obj in data) {
          branches.add(Branch.fromJson(obj));
        }
        branchLoading = false;
        rebuildUi();
      }
    } on DioException catch (e) {
      branchLoading = false;
      rebuildUi();
      ApiResponse errorResponse = ApiResponse.parse(e.response);

      appService.showErrorFromApiRequest(message: errorResponse.message!);
    }
  }
}
