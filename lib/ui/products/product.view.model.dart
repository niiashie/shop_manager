import 'package:flutter/cupertino.dart';
import 'package:stacked/stacked.dart';

class ProductViewModel extends BaseViewModel {
  bool showAddProduct = false;
  TextEditingController? name, costPrice, sellingPrice, quantity;

  init() {
    name = TextEditingController(text: "");
    costPrice = TextEditingController(text: "");
    sellingPrice = TextEditingController(text: "");
    quantity = TextEditingController(text: "");
  }

  addProductTapped() {
    showAddProduct = true;
    rebuildUi();
  }

  closeAddProduct() {
    showAddProduct = false;
    rebuildUi();
  }
}
