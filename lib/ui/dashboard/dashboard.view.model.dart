import 'package:shop_manager/utils.dart';
import 'package:stacked/stacked.dart';

class DashboardViewModel extends BaseViewModel {
  bool homeSelected = true,
      shopSelceted = false,
      productSelected = false,
      stockSelected = false,
      profileSelected = false;

  onSideMenuSelect(String type) {
    unselectAll();
    if (type == "home") {
      homeSelected = true;
      Utils.sideMenuNavigationKey.currentState?.pushReplacementNamed("/");
    } else if (type == "shop") {
      shopSelceted = true;
      Utils.sideMenuNavigationKey.currentState?.pushReplacementNamed("/shop");
    } else if (type == "products") {
      productSelected = true;
      Utils.sideMenuNavigationKey.currentState
          ?.pushReplacementNamed("/product");
    } else if (type == "stocks") {
      stockSelected = true;
      Utils.sideMenuNavigationKey.currentState?.pushReplacementNamed("/stocks");
    } else if (type == "profile") {
      profileSelected = true;
      Utils.sideMenuNavigationKey.currentState
          ?.pushReplacementNamed("/profile");
    }
    rebuildUi();
  }

  unselectAll() {
    homeSelected = false;
    shopSelceted = false;
    productSelected = false;
    stockSelected = false;
    productSelected = false;
    profileSelected = false;
  }
}
