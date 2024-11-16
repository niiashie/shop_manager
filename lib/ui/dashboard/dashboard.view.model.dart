import 'package:flutter/material.dart';
import 'package:shop_manager/app/locator.dart';
import 'package:shop_manager/constants/routes.dart';
import 'package:shop_manager/services/app_service.dart';
import 'package:shop_manager/services/dialog.service.dart';
import 'package:shop_manager/utils.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart' as pw;

class DashboardViewModel extends BaseViewModel {
  bool homeSelected = true,
      shopSelceted = false,
      productSelected = false,
      stockSelected = false,
      profileSelected = false,
      receivedGoodsSelected = false,
      branchSelected = false,
      usersSelected = false,
      requisitionSelected = false;
  var appService = locator<AppService>();
  List<String> branchNames = [];
  String? selectedCompanyBranch;

  init() {
    branchNames = appService.user!.branches!.map((b) => b.name!).toList();
    setSelectedCompanyBranch(branchNames[0]);
  }

  setSelectedCompanyBranch(a) {
    selectedCompanyBranch = a;
    rebuildUi();
  }

  onSideMenuSelect(String type) {
    unselectAll();
    if (type == "home") {
      homeSelected = true;
      Utils.sideMenuNavigationKey.currentState?.pushReplacementNamed("/");
    } else if (type == "shop") {
      shopSelceted = true;
      Utils.sideMenuNavigationKey.currentState?.pushReplacementNamed("/shop");
    } else if (type == "customers") {
      requisitionSelected = true;
      Utils.sideMenuNavigationKey.currentState
          ?.pushReplacementNamed("/customers");
    } else if (type == "products") {
      productSelected = true;
      Utils.sideMenuNavigationKey.currentState
          ?.pushReplacementNamed("/product");
    } else if (type == "stocks") {
      stockSelected = true;
      Utils.sideMenuNavigationKey.currentState?.pushReplacementNamed("/stocks");
    } else if (type == "profile") {
      profileSelected = true;
      Utils.sideMenuNavigationKey.currentState?.pushReplacementNamed("/profit");
    } else if (type == "receivedGoods") {
      receivedGoodsSelected = true;
      Utils.sideMenuNavigationKey.currentState
          ?.pushReplacementNamed("/receivedGoods");
    } else if (type == "users") {
      usersSelected = true;
      Utils.sideMenuNavigationKey.currentState?.pushReplacementNamed("/users");
    } else if (type == "branches") {
      branchSelected = true;
      Utils.sideMenuNavigationKey.currentState
          ?.pushReplacementNamed("/branches");
    }
    rebuildUi();
  }

  unselectAll() {
    homeSelected = false;
    shopSelceted = false;
    productSelected = false;
    stockSelected = false;
    productSelected = false;
    usersSelected = false;
    branchSelected = false;
    profileSelected = false;
    requisitionSelected = false;
    receivedGoodsSelected = false;
  }

  logout() {
    locator<DialogService>().show(
        type: "warning",
        title: "Logout",
        message: "Do you really want to logout?",
        showCancelBtn: true,
        cancelBtnText: "No",
        okayBtnText: "Yes",
        onCancelTap: () {
          Navigator.of(pw.StackedService.navigatorKey!.currentContext!).pop();
        },
        onOkayTap: () {
          appService.user = null;
          debugPrint("user : ${appService.user}");
          Navigator.of(pw.StackedService.navigatorKey!.currentContext!)
              .pushNamedAndRemoveUntil(
                  Routes.login, (Route<dynamic> route) => false);
        });
  }
}
