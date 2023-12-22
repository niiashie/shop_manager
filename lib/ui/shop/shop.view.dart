import 'package:flutter/material.dart';
import 'package:shop_manager/constants/colors.dart';
import 'package:shop_manager/constants/fonts.dart';
import 'package:shop_manager/ui/shared/custom_button.dart';
import 'package:shop_manager/ui/shared/custom_dropdown.dart';
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
                      padding: const EdgeInsets.only(left: 10),
                      child: Text(
                        "Shop",
                        style: const TextStyle(
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
                    color: index % 2 == 0 ? Colors.white : Colors.grey[100],
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        // Expanded(child: viewModel.productRows[index]),
                        const SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: CustomDropdown(
                            items: viewModel.productList,
                            hasIcon: false,
                            hintText: 'Select Product',
                            defaultValue: viewModel.productSelection[index],
                            onChanged: (a) {
                              viewModel.setProductSelection(a!, index);
                            },
                          ),
                        ),
                        const SizedBox(
                          width: 15,
                        ),
                        Expanded(
                          child: CustomFormField(
                            fillColor: Colors.white,
                            filled: true,
                            controller: viewModel.productUnitPrices[index],
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
                              controller: viewModel.productQuantity[index],
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
                            borderRadius:
                                const BorderRadius.all(Radius.circular(13)),
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
              child: Align(
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
            )
          ],
        ),
      ),
    ));
  }

  @override
  ShopViewModel viewModelBuilder(BuildContext context) => ShopViewModel();
}
