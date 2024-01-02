import 'package:flutter/material.dart';
import 'package:shop_manager/constants/colors.dart';
import 'package:shop_manager/constants/fonts.dart';
import 'package:shop_manager/models/product.dart';
import 'package:shop_manager/ui/shared/custom_button.dart';
import 'package:shop_manager/ui/shared/custom_form_field.dart';
import 'package:shop_manager/ui/shop/shop.view.model.dart';
import 'package:shop_manager/utils.dart';
import 'package:stacked/stacked.dart';

class ShopView extends StackedView<ShopViewModel> {
  const ShopView({Key? key}) : super(key: key);

  @override
  bool get reactive => true;

  @override
  bool get disposeViewModel => true;

  @override
  void onViewModelReady(ShopViewModel viewModel) async {
    super.onViewModelReady(viewModel);
    viewModel.init();
    debugPrint("Do something...");
  }

  @override
  Widget builder(BuildContext context, viewModel, Widget? child) {
    return Scaffold(
        body: Container(
      width: double.infinity,
      height: double.infinity,
      color: Colors.white,
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(
              height: 10,
            ),
            const SizedBox(
              width: double.infinity,
              height: 50,
              child: Stack(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: EdgeInsets.only(left: 10),
                      child: Text(
                        "Shop",
                        style: TextStyle(
                            fontFamily: AppFonts.poppinsBold, fontSize: 22),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Visibility(
                visible: viewModel.getProductLoading,
                replacement: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: double.infinity,
                      margin: const EdgeInsets.only(left: 20, right: 20),
                      height: 40,
                      child: Stack(
                        children: [
                          const Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "Product List",
                              style: TextStyle(color: Colors.grey),
                            ),
                          ),
                          Align(
                            alignment: Alignment.bottomCenter,
                            child: Container(
                              width: double.infinity,
                              height: 0.5,
                              color: Colors.grey[400],
                            ),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    ListView.builder(
                        itemCount: viewModel.productSelection.length,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          return Container(
                            width: double.infinity,
                            padding: const EdgeInsets.only(top: 10, bottom: 10),
                            margin: const EdgeInsets.only(left: 25, right: 25),
                            color: index % 2 == 0
                                ? Colors.white
                                : Colors.grey[100],
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                // Expanded(child: viewModel.productRows[index]),
                                const SizedBox(
                                  width: 10,
                                ),
                                Expanded(
                                  child: Container(
                                    width: double.infinity,
                                    padding: const EdgeInsets.only(
                                        left: 10, right: 10),
                                    height: 45,
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        border: Border.all(
                                            color: Colors.black12, width: 1),
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(10))),
                                    child: DropdownButtonHideUnderline(
                                      child: DropdownButton(
                                          isExpanded: true,
                                          hint: const Text("Select Product",
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  color: Colors.black38)),
                                          value:
                                              viewModel.productSelection[index],
                                          items: viewModel.allProducts
                                              .map((Product value) {
                                            return DropdownMenuItem<Product>(
                                              value: value,
                                              child: Text(
                                                value.name!,
                                                style: const TextStyle(
                                                    color:
                                                        AppColors.crudTextColor,
                                                    fontSize: 12),
                                              ),
                                            );
                                          }).toList(),
                                          onChanged: (Product? val) {
                                            viewModel.setProduct(val!, index);
                                          }),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 15,
                                ),
                                Expanded(
                                  child: CustomFormField(
                                    fillColor: Colors.white,
                                    filled: true,
                                    controller:
                                        viewModel.productUnitPrices[index],
                                    readOnly: true,
                                    labelText: "Unit Price",
                                    prefixIcon: const Text(
                                      "GHS",
                                      style: TextStyle(fontSize: 12),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 15,
                                ),
                                Expanded(
                                  child: CustomFormField(
                                      fillColor: Colors.white,
                                      filled: true,
                                      controller:
                                          viewModel.productQuantity[index],
                                      labelText: "Quantity",
                                      onChanged: (a) {
                                        if (Utils().isNumeric(a)) {
                                          viewModel.onQuantityChanged(a, index);
                                        } else {
                                          viewModel.resetQuantity(index);
                                        }
                                      },
                                      prefixIcon: const Icon(
                                        Icons.tag,
                                        size: 12,
                                      )),
                                ),
                                const SizedBox(
                                  width: 15,
                                ),
                                Expanded(
                                  child: CustomFormField(
                                    fillColor: Colors.white,
                                    filled: true,
                                    controller: viewModel.productAmount[index],
                                    labelText: "Amount",
                                    readOnly: true,
                                    prefixIcon: const Text(
                                      "GHS",
                                      style: TextStyle(fontSize: 12),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 15,
                                ),
                                SizedBox(
                                  width: 60,
                                  child: Center(
                                      child: Material(
                                    color: Colors.transparent,
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(13)),
                                    elevation: 2,
                                    child: InkWell(
                                      child: Container(
                                        width: 20,
                                        height: 20,
                                        decoration: const BoxDecoration(
                                            color: AppColors.primaryColor,
                                            shape: BoxShape.circle),
                                        child: const Center(
                                          child: Icon(
                                            Icons.clear,
                                            size: 10,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                      onTap: () {
                                        viewModel.removeProduct(index);
                                      },
                                    ),
                                  )),
                                )
                              ],
                            ),
                          );
                        }),
                    const SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                        width: double.infinity,
                        height: 40,
                        child: Stack(
                          children: [
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Padding(
                                padding: const EdgeInsets.only(left: 30),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    const Text(
                                      "Total Amount: ",
                                      style: TextStyle(fontSize: 11),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    const Text(
                                      "GHS",
                                      style: TextStyle(
                                        fontSize: 9,
                                        fontFamily: AppFonts.poppinsMedium,
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 3,
                                    ),
                                    Text(
                                      viewModel.total.toString(),
                                      style: const TextStyle(
                                          fontFamily: AppFonts.poppinsMedium,
                                          fontSize: 16),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            Align(
                              alignment: Alignment.centerRight,
                              child: Padding(
                                padding: const EdgeInsets.only(right: 20),
                                child: CustomButton(
                                  width: 120,
                                  height: 40,
                                  color: AppColors.primaryColor,
                                  title: const Text(
                                    "Add Batch",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  ontap: () {
                                    viewModel.addProductRow();
                                  },
                                ),
                              ),
                            ),
                          ],
                        )),
                    const SizedBox(
                      height: 15,
                    ),
                    Container(
                      width: double.infinity,
                      margin: const EdgeInsets.only(left: 20, right: 20),
                      height: 40,
                      child: Stack(
                        children: [
                          const Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "Customer Information(Optional)",
                              style: TextStyle(color: Colors.grey),
                            ),
                          ),
                          Align(
                            alignment: Alignment.bottomCenter,
                            child: Container(
                              width: double.infinity,
                              height: 0.5,
                              color: Colors.grey[400],
                            ),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.only(top: 2, bottom: 2),
                      margin: const EdgeInsets.only(left: 20, right: 20),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Expanded(
                            child: CustomFormField(
                              fillColor: Colors.white,
                              filled: true,
                              controller: viewModel.cusName,
                              labelText: "Customer Name",
                              hintText: "Enter customer name",
                            ),
                          ),
                          const SizedBox(
                            width: 15,
                          ),
                          Expanded(
                            child: CustomFormField(
                              fillColor: Colors.white,
                              filled: true,
                              controller: viewModel.cusPhone,
                              labelText: "Customer Phone",
                              hintText: "Enter customer phone",
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    SizedBox(
                      width: double.infinity,
                      height: 40,
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: Padding(
                            padding: const EdgeInsets.only(right: 25),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                CustomButton(
                                  width: 120,
                                  height: 40,
                                  elevation: 2,
                                  isLoading: viewModel.makeTransactionLoading,
                                  color: Colors.green.shade600,
                                  title: const Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Icon(
                                        Icons.check,
                                        size: 12,
                                        color: Colors.white,
                                      ),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Text(
                                        "Transact",
                                        style: TextStyle(color: Colors.white),
                                      )
                                    ],
                                  ),
                                  ontap: () {
                                    viewModel.submitTransaction();
                                  },
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                CustomButton(
                                  width: 120,
                                  height: 40,
                                  elevation: 2,
                                  color: Colors.red.shade600,
                                  title: const Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Icon(
                                        Icons.clear,
                                        size: 12,
                                        color: Colors.white,
                                      ),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Text(
                                        "Cancel",
                                        style: TextStyle(color: Colors.white),
                                      )
                                    ],
                                  ),
                                  ontap: () {
                                    viewModel.clearProductSelection();
                                  },
                                ),
                              ],
                            )),
                      ),
                    )
                  ],
                ),
                child: const SizedBox(
                  width: double.infinity,
                  height: 70,
                  child: Center(
                    child: SizedBox(
                      width: 30,
                      height: 30,
                      child: CircularProgressIndicator(
                        strokeWidth: 1,
                        color: AppColors.primaryColor,
                      ),
                    ),
                  ),
                ))
          ],
        ),
      ),
    ));
  }

  @override
  ShopViewModel viewModelBuilder(BuildContext context) => ShopViewModel();
}
