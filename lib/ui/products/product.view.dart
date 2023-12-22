import 'package:flutter/material.dart';
import 'package:shop_manager/constants/colors.dart';
import 'package:shop_manager/constants/fonts.dart';
import 'package:shop_manager/ui/products/product.view.model.dart';
import 'package:shop_manager/ui/shared/custom_button.dart';
import 'package:shop_manager/ui/shared/custom_form_field.dart';
import 'package:stacked/stacked.dart';

class ProductView extends StackedView<ProductViewModel> {
  const ProductView({Key? key}) : super(key: key);

  @override
  bool get reactive => true;

  @override
  bool get disposeViewModel => true;

  @override
  void onViewModelReady(ProductViewModel viewModel) async {
    viewModel.init();
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
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: Stack(
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: Text(
                              viewModel.showAddProduct == false
                                  ? "Products"
                                  : "Add Product",
                              style: const TextStyle(
                                  fontFamily: AppFonts.poppinsBold,
                                  fontSize: 22),
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.centerRight,
                          child: Padding(
                              padding: const EdgeInsets.only(right: 10),
                              child: viewModel.showAddProduct == false
                                  ? CustomButton(
                                      width: 130,
                                      height: 40,
                                      elevation: 2,
                                      color: AppColors.primaryColor,
                                      ontap: () {
                                        viewModel.addProductTapped();
                                      },
                                      title: const Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Icon(
                                            Icons.add,
                                            size: 15,
                                            color: Colors.white,
                                          ),
                                          SizedBox(
                                            width: 5,
                                          ),
                                          Text(
                                            "Add Product",
                                            style:
                                                TextStyle(color: Colors.white),
                                          )
                                        ],
                                      ),
                                    )
                                  : Material(
                                      elevation: 2,
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(20)),
                                      child: InkWell(
                                        child: Container(
                                          width: 40,
                                          height: 40,
                                          decoration: const BoxDecoration(
                                              color: AppColors.primaryColor,
                                              shape: BoxShape.circle),
                                          child: const Center(
                                            child: Icon(
                                              Icons.clear,
                                              color: Colors.white,
                                              size: 13,
                                            ),
                                          ),
                                        ),
                                        onTap: () {
                                          viewModel.closeAddProduct();
                                        },
                                      ))),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  Visibility(
                      visible: viewModel.showAddProduct,
                      replacement: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const SizedBox(
                            height: 15,
                          ),
                          Container(
                            width: double.infinity,
                            height: 40,
                            margin: const EdgeInsets.only(left: 20, right: 20),
                            decoration: const BoxDecoration(
                                color: AppColors.primaryColor,
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(10),
                                    topRight: Radius.circular(10))),
                            child: const Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Expanded(
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Padding(
                                      padding: EdgeInsets.only(left: 15),
                                      child: Text(
                                        "Name",
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Center(
                                    child: Text(
                                      "Cost Price",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Center(
                                    child: Text(
                                      "Selling Price",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Center(
                                    child: Text(
                                      "More Options",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                      child: Container(
                        width: 450,
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                            border:
                                Border.all(color: Colors.grey[300]!, width: 1),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(15))),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Text(
                              "Fill in details required for product to be added",
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 2, bottom: 2),
                              child: CustomFormField(
                                controller: viewModel.name,
                                filled: true,
                                fillColor: Colors.white,
                                label: "Name",
                                hintText: "Please enter name of product",
                              ),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 2, bottom: 2),
                              child: CustomFormField(
                                controller: viewModel.sellingPrice,
                                filled: true,
                                fillColor: Colors.white,
                                prefixIcon: const Text(
                                  "GHS",
                                  style: TextStyle(fontSize: 12),
                                ),
                                label: "Selling Price",
                                hintText:
                                    "Please enter selling price of product",
                              ),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 2, bottom: 2),
                              child: CustomFormField(
                                controller: viewModel.sellingPrice,
                                filled: true,
                                fillColor: Colors.white,
                                prefixIcon: const Text(
                                  "GHS",
                                  style: TextStyle(fontSize: 12),
                                ),
                                label: "Cost Price",
                                hintText: "Please enter cost price of product",
                              ),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 2, bottom: 2),
                              child: CustomFormField(
                                controller: viewModel.sellingPrice,
                                filled: true,
                                fillColor: Colors.white,
                                prefixIcon: const Icon(
                                  Icons.tag,
                                  size: 15,
                                ),
                                label: "Opening Quantity",
                                hintText: "Please enter quantity of product",
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            SizedBox(
                              width: double.infinity,
                              height: 50,
                              child: Align(
                                alignment: Alignment.centerRight,
                                child: CustomButton(
                                  width: 100,
                                  height: 40,
                                  color: AppColors.primaryColor,
                                  title: const Text(
                                    "Submit",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  ontap: () {
                                    debugPrint("Adding product");
                                  },
                                ),
                              ),
                            )
                          ],
                        ),
                      ))
                ],
              ),
            )));
  }

  @override
  ProductViewModel viewModelBuilder(BuildContext context) => ProductViewModel();
}
