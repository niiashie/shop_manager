import 'package:flutter/material.dart';
import 'package:shop_manager/constants/colors.dart';
import 'package:shop_manager/constants/fonts.dart';
import 'package:shop_manager/ui/products/product.view.model.dart';
import 'package:shop_manager/ui/shared/custom_button.dart';
import 'package:shop_manager/ui/shared/custom_form_field.dart';
import 'package:shop_manager/ui/shared/pagination.dart';
import 'package:shop_manager/ui/shared/search.dart';
import 'package:shop_manager/utils.dart';
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
                                  ? Row(
                                      mainAxisSize: MainAxisSize.min,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        SizedBox(
                                            width: 200,
                                            child: CustomFormField(
                                              controller: viewModel.search,
                                              hintText: "Search Product",
                                              contentPadding: 2,
                                              fillColor: Colors.white,
                                              filled: true,
                                              onChanged: (a) {
                                                if (viewModel
                                                    .search!.text.isEmpty) {
                                                  viewModel.getProducts(1);
                                                }
                                              },
                                            )),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Material(
                                            borderRadius:
                                                const BorderRadius.all(
                                                    Radius.circular(10)),
                                            color: Colors.transparent,
                                            elevation: 2,
                                            child: InkWell(
                                              child: Container(
                                                width: 40,
                                                height: 40,
                                                decoration: const BoxDecoration(
                                                  color: AppColors.primaryColor,
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(10)),
                                                ),
                                                child: const Center(
                                                  child: Icon(
                                                    Icons.search,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              ),
                                              onTap: () {
                                                viewModel.onSearchProduct();
                                              },
                                            )),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        CustomButton(
                                          width: 130,
                                          height: 45,
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
                                                style: TextStyle(
                                                    color: Colors.white),
                                              )
                                            ],
                                          ),
                                        )
                                      ],
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
                                      "Quantity",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Center(
                                    child: Text(
                                      "Edit",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                          Visibility(
                              visible: viewModel.productsLoading,
                              replacement: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  ListView.builder(
                                      itemCount: viewModel.products.length,
                                      shrinkWrap: true,
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      itemBuilder: (context, index) {
                                        return Container(
                                          width: double.infinity,
                                          height: 40,
                                          margin: const EdgeInsets.only(
                                              left: 20, right: 20),
                                          color: viewModel.products[index]
                                                      .quantity ==
                                                  0
                                              ? Colors.redAccent
                                                  .withOpacity(0.5)
                                              : index % 2 == 0
                                                  ? Colors.white
                                                  : Colors.grey[100],
                                          child: Row(
                                            mainAxisSize: MainAxisSize.max,
                                            children: [
                                              Expanded(
                                                child: Align(
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 15),
                                                    child: Text(
                                                      viewModel.products[index]
                                                          .name!,
                                                      style: const TextStyle(
                                                          color: AppColors
                                                              .crudTextColor),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Expanded(
                                                child: Center(
                                                  child: Text(
                                                    "GHS ${viewModel.products[index].costPrice}",
                                                    style: const TextStyle(
                                                        color: AppColors
                                                            .crudTextColor),
                                                  ),
                                                ),
                                              ),
                                              Expanded(
                                                child: Center(
                                                  child: Text(
                                                    "GHS ${viewModel.products[index].sellingPrice}",
                                                    style: const TextStyle(
                                                        color: AppColors
                                                            .crudTextColor),
                                                  ),
                                                ),
                                              ),
                                              Expanded(
                                                child: Center(
                                                  child: Text(
                                                    "${viewModel.products[index].quantity}",
                                                    style: const TextStyle(
                                                        color: AppColors
                                                            .crudTextColor),
                                                  ),
                                                ),
                                              ),
                                              Expanded(
                                                child: Center(
                                                    child: Material(
                                                  elevation: 2,
                                                  borderRadius:
                                                      const BorderRadius.all(
                                                          Radius.circular(5)),
                                                  child: InkWell(
                                                    child: Container(
                                                      width: 30,
                                                      height: 30,
                                                      decoration:
                                                          const BoxDecoration(
                                                        color: AppColors
                                                            .primaryColor,
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    5)),
                                                      ),
                                                      child: const Center(
                                                        child: Icon(
                                                          Icons.edit,
                                                          size: 12,
                                                          color: Colors.white,
                                                        ),
                                                      ),
                                                    ),
                                                    onTap: () {
                                                      viewModel
                                                          .editProduct(index);
                                                    },
                                                  ),
                                                )),
                                              )
                                            ],
                                          ),
                                        );
                                      }),
                                  const SizedBox(height: 20),
                                  PaginationWidget(
                                    currentPage: viewModel.currentPage,
                                    totalPages: viewModel.totalPages,
                                    onPageChanged: (a) {
                                      viewModel.changePage(a);
                                    },
                                  )
                                ],
                              ),
                              child: Container(
                                margin: const EdgeInsets.only(top: 20),
                                width: double.infinity,
                                height: 40,
                                child: const Center(
                                  child: CircularProgressIndicator(
                                    color: AppColors.primaryColor,
                                    strokeWidth: 1,
                                  ),
                                ),
                              ))
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
                            Form(
                              key: viewModel.productAdditionFormKey,
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 2, bottom: 2),
                                    child: CustomFormField(
                                      controller: viewModel.name,
                                      filled: true,
                                      fillColor: Colors.white,
                                      label: "Name",
                                      validator: (String? value) {
                                        if (value!.isEmpty) {
                                          return "Name is required";
                                        }

                                        return null;
                                      },
                                      hintText: "Please enter name of product",
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 2, bottom: 2),
                                    child: CustomFormField(
                                      controller: viewModel.sellingPrice,
                                      filled: true,
                                      fillColor: Colors.white,
                                      prefixIcon: const Text(
                                        "GHS",
                                        style: TextStyle(fontSize: 12),
                                      ),
                                      label: "Selling Price",
                                      validator: (String? value) {
                                        if (value!.isEmpty) {
                                          return "Selling price required";
                                        } else if (Utils().isNumeric(value) ==
                                            false) {
                                          return "Selling price should be a numeric value";
                                        }

                                        return null;
                                      },
                                      hintText:
                                          "Please enter selling price of product",
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 2, bottom: 2),
                                    child: CustomFormField(
                                      controller: viewModel.costPrice,
                                      filled: true,
                                      fillColor: Colors.white,
                                      prefixIcon: const Text(
                                        "GHS",
                                        style: TextStyle(fontSize: 12),
                                      ),
                                      label: "Cost Price",
                                      validator: (String? value) {
                                        if (value!.isEmpty) {
                                          return "Cost price required";
                                        } else if (Utils().isNumeric(value) ==
                                            false) {
                                          return "Cost price should be a numeric values";
                                        }

                                        return null;
                                      },
                                      hintText:
                                          "Please enter cost price of product",
                                    ),
                                  ),
                                ],
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
                                  elevation: 2,
                                  width: 100,
                                  isLoading: viewModel.isLoading,
                                  height: 40,
                                  color: AppColors.primaryColor,
                                  title: const Text(
                                    "Submit",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  ontap: () {
                                    viewModel.addProductRequest();
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
