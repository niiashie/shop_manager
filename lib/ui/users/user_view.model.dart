import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shop_manager/api/auth_api.dart';
import 'package:shop_manager/app/locator.dart';
import 'package:shop_manager/models/api_response.dart';
import 'package:shop_manager/models/branch.dart';
import 'package:shop_manager/models/user.dart';
import 'package:shop_manager/services/app_service.dart';
import 'package:stacked/stacked.dart';

class UserViewModel extends BaseViewModel {
  bool isLoading = false,
      showUserDetail = false,
      userInformationView = false,
      usersLoading = false,
      showManage = false;
  var appService = locator<AppService>();
  int currentPage = 1, totalPages = 1;
  List<User> users = [];
  List<Branch> branches = [];
  List<Branch> selectedBranch = [];
  User? selectedUser;
  String? newUserRole, newUserAccess;
  List<String> roles = ['manager', 'supervisor', 'staff'];
  List<String> access = ['granted', 'block'];
  AuthApi authApi = AuthApi();

  getUsers() async {
    try {
      usersLoading = true;
      rebuildUi();
      ApiResponse userResponse = await authApi.getUsers();
      if (userResponse.ok) {
        List<dynamic> data = userResponse.data;
        for (var obj in data) {
          users.add(User.fromJson(obj, isLogin: false));
        }
        await getBranches();
        usersLoading = false;
        rebuildUi();
      }
    } on DioException catch (e) {
      usersLoading = false;
      rebuildUi();
      ApiResponse errorResponse = ApiResponse.parse(e.response);

      appService.showErrorFromApiRequest(message: errorResponse.message!);
    }
  }

  String capitalize(String word) {
    if (word.isEmpty) return word;
    return word[0].toUpperCase() + word.substring(1).toLowerCase();
  }

  getAvailableBranchesToSelect() {
    for (var obj in selectedBranch) {
      branches.removeWhere((element) => element.id == obj.id);
    }

    debugPrint("branches left : ${branches.length}");
  }

  setSelectedRole(String role) {
    newUserRole = role;
    rebuildUi();
  }

  setUserAccess(String access) {
    newUserAccess = access;
    rebuildUi();
  }

  showUserDetailOnTap(index) {
    selectedUser = users[index];
    showUserDetail = true;

    rebuildUi();
  }

  showUserManager(index) {
    selectedUser = users[index];
    newUserRole = selectedUser!.role;
    newUserAccess = selectedUser!.access;
    selectedBranch = selectedUser!.branches!;
    getAvailableBranchesToSelect();
    showManage = true;
    showUserDetail = true;
    rebuildUi();
  }

  removeSelectedBranchFromIndex(int index) {
    if (selectedBranch.length == 1) {
      appService.showErrorFromApiRequest(
          message: "User must be assigned to at least one branch");
    } else {
      branches.add(selectedBranch[index]);
      selectedBranch.removeAt(index);

      rebuildUi();
    }
  }

  addUserToUserToBranch(String a) {
    Branch branch = branches.where((e) => e.name == a).first;
    selectedBranch.add(branch);
    branches.removeWhere((element) => element.id == branch.id);
    rebuildUi();
  }

  closeUserDetail() {
    showUserDetail = false;
    showManage = false;
    selectedUser = null;
    rebuildUi();
  }

  getBranches() async {
    try {
      ApiResponse response = await authApi.getBranches();
      if (response.ok) {
        List<dynamic> data = response.body;
        branches.clear();
        for (var obj in data) {
          branches.add(Branch.fromJson(obj));
        }
      }
    } on DioException catch (e) {
      ApiResponse errorResponse = ApiResponse.parse(e.response);

      appService.showErrorFromApiRequest(message: errorResponse.message!);
    }
  }
}
