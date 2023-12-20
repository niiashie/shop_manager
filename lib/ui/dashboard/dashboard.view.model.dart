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
    } else if (type == "shop") {
      shopSelceted = true;
    } else if (type == "products") {
      productSelected = true;
    } else if (type == "stocks") {
      stockSelected = true;
    } else if (type == "profile") {
      profileSelected = true;
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
