import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shop_manager/constants/colors.dart';
import 'package:shop_manager/constants/fonts.dart';
import 'package:shop_manager/models/product.dart';
import 'package:shop_manager/ui/requisition/requisition.view.model.dart';
import 'package:shop_manager/ui/shared/close_button.dart';
import 'package:shop_manager/ui/shared/custom_button.dart';
import 'package:shop_manager/ui/shared/custom_form_field.dart';
import 'package:shop_manager/ui/shared/empty_results.dart';
import 'package:shop_manager/utils.dart';
import 'package:stacked/stacked.dart';

class RequisitionView extends StackedView<RequisitionViewModel> {
  const RequisitionView({Key? key}) : super(key: key);

  @override
  bool get reactive => true;

  @override
  bool get disposeViewModel => true;

  @override
  void onViewModelReady(RequisitionViewModel viewModel) async {
    super.onViewModelReady(viewModel);
    viewModel.init();
    debugPrint("Do something...");
  }

  @override
  Widget builder(BuildContext context, viewModel, Widget? child) {
    return Scaffold(
        body: Container(
            color: Colors.white,
            width: double.infinity,
            height: double.infinity,
            child: Visibility(
              visible: viewModel.getProductLoading,
              replacement: Visibility(
                visible: viewModel.showPendingRequisition,
                replacement: SingleChildScrollView(
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        width: double.infinity,
                        margin: const EdgeInsets.only(left: 10, right: 10),
                        height: 50,
                        child: Stack(
                          children: [
                            Align(
                                alignment: Alignment.centerLeft,
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment:
                                      CrossAxisAlignment.baseline,
                                  textBaseline: TextBaseline.alphabetic,
                                  children: [
                                    InkWell(
                                      onHover: (a) {
                                        viewModel.receivedGoodsOnHover(a);
                                      },
                                      onTap: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: Text(
                                        "Received Goods",
                                        style: TextStyle(
                                            color: viewModel.receivedGoodsColor,
                                            fontSize: 18),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      ">",
                                      style: TextStyle(
                                          color: Colors.grey[500],
                                          fontSize: 18),
                                    ),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    const Text(
                                      "Requisition",
                                      style: TextStyle(
                                          fontFamily: AppFonts.poppinsBold,
                                          fontSize: 22),
                                    ),
                                  ],
                                )),
                            Visibility(
                                visible: viewModel.appService.user!.role ==
                                        "manager" ||
                                    viewModel.appService.user!.role == "admin",
                                child: Align(
                                  alignment: Alignment.centerRight,
                                  child: CustomButton(
                                    width: 160,
                                    elevation: 2,
                                    height: 40,
                                    color: AppColors.primaryColor,
                                    title: const Text(
                                      "Pending Requisitions",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    ontap: () {
                                      viewModel.showPendingRequisitions();
                                    },
                                  ),
                                ))
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      ListView.builder(
                          itemCount: viewModel.pendingRequisitions.length,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            return Container(
                              width: double.infinity,
                              height: 40,
                              margin: const EdgeInsets.only(
                                  left: 30, right: 30, bottom: 10),
                              decoration: BoxDecoration(
                                  color: Colors.blue.withOpacity(0.4),
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(10))),
                              child: Stack(
                                children: [
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Padding(
                                      padding: const EdgeInsets.only(left: 15),
                                      child: Text(
                                        viewModel.pendingRequisitions[index]
                                            .description!,
                                        style: const TextStyle(
                                            fontFamily: AppFonts.poppinsMedium,
                                            color: AppColors.primaryColor),
                                      ),
                                    ),
                                  ),
                                  Align(
                                    alignment: Alignment.centerRight,
                                    child: Container(
                                      width: 100,
                                      height: 30,
                                      margin: const EdgeInsets.only(right: 10),
                                      decoration: BoxDecoration(
                                          color: Colors.red.shade600,
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(10))),
                                      child: const Center(
                                        child: Text(
                                          "Pending",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 13),
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            );
                          }),
                      SizedBox(
                        width: double.infinity,
                        height: 40,
                        child: Stack(
                          children: [
                            const Align(
                              alignment: Alignment.centerLeft,
                              child: Padding(
                                padding: EdgeInsets.only(left: 25),
                                child: Text("Details"),
                              ),
                            ),
                            Align(
                              alignment: Alignment.bottomCenter,
                              child: Container(
                                width: double.infinity,
                                margin:
                                    const EdgeInsets.only(left: 20, right: 20),
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
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 5, bottom: 5, left: 20, right: 20),
                        child: CustomFormField(
                          fillColor: Colors.white,
                          filled: true,
                          hintText: "Enter requisition description",
                          labelText: "Description",
                          controller: viewModel.description,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                        width: double.infinity,
                        height: 40,
                        child: Stack(
                          children: [
                            const Align(
                              alignment: Alignment.centerLeft,
                              child: Padding(
                                padding: EdgeInsets.only(left: 25),
                                child: Text("Products"),
                              ),
                            ),
                            Align(
                              alignment: Alignment.bottomCenter,
                              child: Container(
                                width: double.infinity,
                                margin:
                                    const EdgeInsets.only(left: 20, right: 20),
                                height: 0.5,
                                color: Colors.grey[400],
                              ),
                            )
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      ListView.builder(
                          itemCount: viewModel.productSelection.length,
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemBuilder: (context, index2) {
                            return Container(
                              width: double.infinity,
                              padding: const EdgeInsets.only(top: 5, bottom: 5),
                              margin:
                                  const EdgeInsets.only(left: 25, right: 25),
                              color: index2 % 2 == 0
                                  ? Colors.white
                                  : Colors.grey[100],
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  SizedBox(
                                    width: 270,
                                    child: RawAutocomplete<Product>(
                                      optionsBuilder:
                                          (TextEditingValue textEditingValue) {
                                        // viewModel
                                        //         .addedEquipmentBrand =
                                        //     textEditingValue.text;
                                        if (textEditingValue.text == '') {
                                          return const Iterable<
                                              Product>.empty();
                                        } else {
                                          List<Product> matches = <Product>[];
                                          matches.addAll(viewModel.allProducts);

                                          matches.retainWhere((s) {
                                            return s.name!
                                                .toLowerCase()
                                                .contains(textEditingValue.text
                                                    .toLowerCase());
                                          });

                                          return matches;
                                        }
                                      },
                                      fieldViewBuilder: (
                                        BuildContext context,
                                        TextEditingController
                                            textEditingController,
                                        FocusNode focusNode,
                                        VoidCallback onFieldSubmitted,
                                      ) {
                                        return Container(
                                          width: double.infinity,
                                          height: 47,
                                          decoration: const BoxDecoration(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(10)),
                                              color: Colors.white),
                                          child: TextFormField(
                                              controller: textEditingController,
                                              focusNode: focusNode,
                                              onFieldSubmitted: (String value) {
                                                onFieldSubmitted();
                                              },
                                              decoration: InputDecoration(
                                                hintText: "Enter brand..",
                                                labelText: "Product",
                                                labelStyle: const TextStyle(
                                                    color: Colors.black38),
                                                hintStyle: const TextStyle(
                                                  color: Colors.black38,
                                                  fontSize: 14,
                                                ),
                                                enabledBorder:
                                                    OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                    width: 1,
                                                    color: Colors.grey[300]!,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          15.0),
                                                ),
                                              )),
                                        );
                                      },
                                      optionsViewBuilder: (
                                        BuildContext context,
                                        AutocompleteOnSelected<Product>
                                            onSelected,
                                        Iterable<Product> options,
                                      ) {
                                        return Align(
                                          alignment: Alignment.topLeft,
                                          child: Material(
                                            elevation: 4.0,
                                            color: Colors.white,
                                            child: ConstrainedBox(
                                              constraints: const BoxConstraints(
                                                  maxHeight: 150,
                                                  maxWidth: 380),
                                              child: ListView.builder(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                itemCount: options.length,
                                                itemBuilder:
                                                    (BuildContext context,
                                                        int index) {
                                                  final Product option =
                                                      options.elementAt(index);
                                                  return GestureDetector(
                                                    onTap: () {
                                                      onSelected(option);

                                                      viewModel.setProduct(
                                                          option, index2);
                                                      // viewModel
                                                      //     .removeAddNewBrandBtn();
                                                      // viewModel
                                                      //     .onBrandSelected(
                                                      //         option);
                                                    },
                                                    child: ListTile(
                                                      title: Text(option.name!),
                                                    ),
                                                  );
                                                },
                                              ),
                                            ),
                                          ),
                                        );
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
                                      prefixIcon: const Text(
                                        "GHS",
                                        style: TextStyle(fontSize: 9),
                                      ),
                                      controller:
                                          viewModel.productUnitPrice[index2],
                                      readOnly: true,
                                      labelText: "Unit Price",
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
                                          viewModel.productQuantity[index2],
                                      labelText: "Quantity",
                                      hintText: "Enter Quantity",
                                      onChanged: (a) {
                                        if (Utils().isNumeric(a) == false) {
                                          viewModel.invalidQuantity(index2);
                                        } else {
                                          viewModel.quantityOnChanged(index2);
                                        }
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
                                      controller:
                                          viewModel.productAmount[index2],
                                      readOnly: true,
                                      prefixIcon: const Text(
                                        "GHS",
                                        style: TextStyle(fontSize: 9),
                                      ),
                                      labelText: "Amount",
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
                                          viewModel.removeProduct(index2);
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
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
                                    elevation: 2,
                                    color: AppColors.primaryColor,
                                    title: const Text(
                                      "Add Batch",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    ontap: () {
                                      viewModel.addBatch();
                                      // viewModel.addProductRow();
                                    },
                                  ),
                                ),
                              ),
                            ],
                          )),
                      const SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                        width: double.infinity,
                        height: 40,
                        child: Align(
                          alignment: Alignment.center,
                          child: CustomButton(
                            width: 170,
                            height: 40,
                            isLoading: viewModel.submitRequisitionLoading,
                            color: AppColors.primaryColor,
                            elevation: 2,
                            title: const Text(
                              "Submit Requisition",
                              style: TextStyle(color: Colors.white),
                            ),
                            ontap: () {
                              viewModel.submitRequisition();
                            },
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: Stack(
                          children: [
                            const Align(
                              alignment: Alignment.centerLeft,
                              child: Padding(
                                padding: EdgeInsets.only(left: 20),
                                child: Text(
                                  "Pending Requisitions",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontFamily: AppFonts.poppinsBold,
                                      fontSize: 22),
                                ),
                              ),
                            ),
                            Align(
                              alignment: Alignment.centerRight,
                              child: Padding(
                                padding: const EdgeInsets.only(right: 20),
                                child: CustomCloseButton(
                                  onTap: () {
                                    viewModel.closePendingRequisitions();
                                  },
                                  size: 30,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Visibility(
                          visible: viewModel.pendingRequisitions.isEmpty,
                          replacement: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Container(
                                width: double.infinity,
                                padding:
                                    const EdgeInsets.only(top: 10, bottom: 10),
                                margin:
                                    const EdgeInsets.only(left: 25, right: 25),
                                decoration: BoxDecoration(
                                    color: Colors.blue.withOpacity(0.5),
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(10))),
                                child: Stack(
                                  children: [
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.only(left: 20),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              viewModel.pendingRequisitions
                                                      .isNotEmpty
                                                  ? viewModel
                                                      .pendingRequisitions[0]
                                                      .description!
                                                  : "",
                                              style: const TextStyle(
                                                  color: AppColors.primaryColor,
                                                  fontFamily:
                                                      AppFonts.poppinsMedium),
                                            ),
                                            Text(
                                              viewModel.pendingRequisitions
                                                      .isNotEmpty
                                                  ? DateFormat.yMMMd().format(
                                                      viewModel
                                                          .pendingRequisitions[
                                                              0]
                                                          .dateAdded!)
                                                  : "",
                                              style: const TextStyle(
                                                  color: AppColors.primaryColor,
                                                  fontFamily:
                                                      AppFonts.poppinsMedium),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                    Align(
                                      alignment: Alignment.centerRight,
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.only(right: 20),
                                        child: CustomButton(
                                          width: 150,
                                          height: 35,
                                          elevation: 2,
                                          color: Colors.white,
                                          title: Text(
                                            viewModel.pendingRequisitions
                                                    .isNotEmpty
                                                ? "GHS ${viewModel.pendingRequisitions[0].total}"
                                                : "",
                                            style: const TextStyle(
                                                color: AppColors.primaryColor),
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              SizedBox(
                                width: double.infinity,
                                height: 40,
                                child: Stack(
                                  children: [
                                    Align(
                                      alignment: Alignment.bottomCenter,
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            left: 25, right: 25),
                                        child: Container(
                                          width: double.infinity,
                                          height: 0.5,
                                          color: Colors.grey[400],
                                        ),
                                      ),
                                    ),
                                    const Align(
                                      alignment: Alignment.centerLeft,
                                      child: Padding(
                                        padding: EdgeInsets.only(left: 30),
                                        child: Text("Products"),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              Container(
                                width: double.infinity,
                                height: 40,
                                margin:
                                    const EdgeInsets.only(left: 25, right: 25),
                                decoration: const BoxDecoration(
                                    color: AppColors.primaryColor,
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(10),
                                        topRight: Radius.circular(10))),
                                child: const Row(
                                  mainAxisSize: MainAxisSize.max,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Expanded(
                                      child: Align(
                                        alignment: Alignment.centerLeft,
                                        child: Padding(
                                          padding: EdgeInsets.only(left: 10),
                                          child: Text(
                                            "Product",
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: Center(
                                        child: Text(
                                          "Unit Price",
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
                                          "Amount",
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              ListView.builder(
                                  itemCount: viewModel
                                      .pendingRequisitionProducts.length,
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemBuilder: (context, index) {
                                    return Container(
                                      width: double.infinity,
                                      padding: const EdgeInsets.only(
                                          top: 10, bottom: 10),
                                      margin: const EdgeInsets.only(
                                          left: 25, right: 25),
                                      color: index % 2 == 0
                                          ? Colors.white
                                          : Colors.grey[100],
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Expanded(
                                            child: Align(
                                              alignment: Alignment.centerLeft,
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 10),
                                                child: Text(
                                                  viewModel
                                                          .pendingRequisitionProducts[
                                                      index]['product']['name'],
                                                ),
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            child: Center(
                                              child: Text(
                                                "GHS ${viewModel.pendingRequisitionProducts[index]['product']['branch'][0]['pivot']['selling_price']}",
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            child: Center(
                                              child: Text(
                                                viewModel
                                                    .pendingRequisitionProducts[
                                                        index]['quantity']
                                                    .toString(),
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            child: Center(
                                              child: Text(
                                                "GHS ${double.parse(viewModel.pendingRequisitionProducts[index]['quantity'].toString()) * double.parse(viewModel.pendingRequisitionProducts[index]['product']['branch'][0]['pivot']['selling_price'].toString())}",
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    );
                                  }),
                              const SizedBox(
                                height: 20,
                              ),
                              SizedBox(
                                width: double.infinity,
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
                                            isLoading: viewModel
                                                .acceptRequisitionLoading,
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
                                                  "Accept",
                                                  style: TextStyle(
                                                      color: Colors.white),
                                                )
                                              ],
                                            ),
                                            ontap: () {
                                              viewModel.acceptRequisition();
                                            },
                                          ),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          CustomButton(
                                            width: 120,
                                            height: 40,
                                            elevation: 2,
                                            isLoading: viewModel
                                                .rejectRequisitionLoading,
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
                                                  "Reject",
                                                  style: TextStyle(
                                                      color: Colors.white),
                                                )
                                              ],
                                            ),
                                            ontap: () {
                                              viewModel.rejectRequisition();
                                            },
                                          ),
                                        ],
                                      )),
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              )
                            ],
                          ),
                          child: const SizedBox(
                            width: double.infinity,
                            height: 400,
                            child: Center(
                              child: CustomEmptyResults(
                                message: "No pending requisitions",
                              ),
                            ),
                          ))
                    ],
                  ),
                ),
              ),
              child: const SizedBox(
                width: double.infinity,
                height: double.infinity,
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
              ),
            )));
  }

  @override
  RequisitionViewModel viewModelBuilder(BuildContext context) =>
      RequisitionViewModel();
}
