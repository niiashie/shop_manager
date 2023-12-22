import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:shop_manager/ui/shared/custom_dropdown.dart';
import 'package:shop_manager/ui/shared/custom_form_field.dart';
import 'package:stacked/stacked.dart';

class ShopViewModel extends BaseViewModel {
  List<Widget> productRows = [];
  List<String> productList = ['Product A', 'Product B'];
  Map<String, double> productPrices = {"Product A": 120, "Product B": 45};
  List<Map<String, dynamic>> productSelections = [];
  List<dynamic> productSelection = [];
  List<TextEditingController> productUnitPrices = [];
  List<TextEditingController> productQuantity = [];
  List<TextEditingController> productAmount = [];

  addProductRow() {
    productSelection.add(null);
    productUnitPrices.add(TextEditingController(text: ""));
    productQuantity.add(TextEditingController(text: ""));
    productAmount.add(TextEditingController(text: ""));
    // productSelections.add({
    //   "product_name": null,
    //   "unit_price": TextEditingController(text: ""),
    //   "quantity": TextEditingController(text: ""),
    //   "amount": TextEditingController(text: "")
    // });

    // productRows.add(Row(
    //   mainAxisSize: MainAxisSize.max,
    //   children: [
    //     Expanded(
    //       child: CustomDropdown(
    //           items: productList,
    //           hasIcon: false,
    //           hintText: "Select Product",
    //           defaultValue: productSelections.last['product_name'],
    //           onChanged: (a) {
    //             productSelections.last['product_name'] = a;
    //             rebuildUi();
    //           }),
    //     ),
    //     const SizedBox(
    //       width: 15,
    //     ),
    //     Expanded(
    //       child: CustomFormField(
    //         fillColor: Colors.white,
    //         filled: true,
    //         labelText: "Unit Price",
    //         hintText: "Enter unit price",
    //         prefixIcon: const Text(
    //           "GHS",
    //           style: TextStyle(fontSize: 10),
    //         ),
    //         controller: productSelections.last['unit_price'],
    //       ),
    //     ),
    //     const SizedBox(
    //       width: 15,
    //     ),
    //     Expanded(
    //       child: CustomFormField(
    //         fillColor: Colors.white,
    //         filled: true,
    //         labelText: "Quantity",
    //         hintText: "Enter quantity",
    //         controller: productSelections.last['quantity'],
    //       ),
    //     ),
    //     const SizedBox(
    //       width: 15,
    //     ),
    //     Expanded(
    //       child: CustomFormField(
    //         fillColor: Colors.white,
    //         filled: true,
    //         readOnly: true,
    //         labelText: "Amount",
    //         hintText: "Enter quantity",
    //         controller: productSelections.last['amount'],
    //       ),
    //     )
    //   ],
    // ));

    rebuildUi();
  }

  setProductSelection(String a, int index) {
    productSelection[index] = a;
    productUnitPrices[index].text = productPrices[a].toString();
    rebuildUi();
  }

  onQuantityChanged(String a, int index) {
    debugPrint("Quantity: $a ");
    double amount =
        double.parse(a) * double.parse(productUnitPrices[index].text);
    productAmount[index].text = amount.toString();
  }

  resetQuantity(int index) {
    productQuantity[index].text = "";
    productAmount[index].text = "";
    rebuildUi();
  }

  removeProduct(int index) {
    productSelection.removeAt(index);
    productUnitPrices.removeAt(index);
    productQuantity.removeAt(index);
    productAmount.removeAt(index);
    rebuildUi();
  }
}
