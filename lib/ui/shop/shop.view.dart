import 'package:flutter/material.dart';
import 'package:shop_manager/constants/colors.dart';
import 'package:shop_manager/constants/fonts.dart';
import 'package:shop_manager/models/customer.dart';
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
                        itemBuilder: (context, index2) {
                          return Container(
                            width: double.infinity,
                            padding: const EdgeInsets.only(top: 10, bottom: 10),
                            margin: const EdgeInsets.only(left: 25, right: 25),
                            color: index2 % 2 == 0
                                ? Colors.white
                                : Colors.grey[100],
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                // Expanded(child: viewModel.productRows[index]),
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
                                        return const Iterable<Product>.empty();
                                      } else {
                                        List<Product> matches = <Product>[];
                                        matches.addAll(viewModel.allProducts);

                                        matches.retainWhere((s) {
                                          return s.name!.toLowerCase().contains(
                                              textEditingValue.text
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
                                              hintText: "Enter ..",
                                              labelText: "Product",
                                              labelStyle: const TextStyle(
                                                  color: Colors.black38),
                                              hintStyle: const TextStyle(
                                                color: Colors.black38,
                                                fontSize: 14,
                                              ),
                                              enabledBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                  width: 1,
                                                  color: Colors.grey[300]!,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(15.0),
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
                                                maxHeight: 150, maxWidth: 380),
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
                                    controller:
                                        viewModel.productUnitPrices[index2],
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
                                          viewModel.productQuantity[index2],
                                      labelText: "Quantity",
                                      onChanged: (a) {
                                        if (Utils().isNumeric(a)) {
                                          viewModel.onQuantityChanged(
                                              a, index2);
                                        } else {
                                          viewModel.resetQuantity(index2);
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
                                    controller: viewModel.productAmount[index2],
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
                              "Transaction Details",
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
                    Container(
                      width: double.infinity,
                      margin: const EdgeInsets.only(left: 20, right: 20),
                      height: 50,
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Expanded(
                            child: Container(
                              width: double.infinity,
                              height: 50,
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      color: Colors.grey[400]!, width: 0.5),
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(15))),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  const SizedBox(
                                    width: 15,
                                  ),
                                  Icon(
                                    Icons.point_of_sale_outlined,
                                    color: Colors.grey[500],
                                    size: 13,
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Expanded(
                                    child: DropdownButtonHideUnderline(
                                      child: DropdownButton(
                                          dropdownColor: Colors.white,
                                          isExpanded: true,
                                          icon: Icon(
                                            Icons.expand_more,
                                            color: Colors.grey[600],
                                            size: 17,
                                          ),
                                          hint: const Text(
                                              'Select transaction type',
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  color: Colors.black38)),
                                          value:
                                              viewModel.selectedTransactionType,
                                          items: viewModel.transactionTypes
                                              .map((String branch) {
                                            return DropdownMenuItem<String>(
                                              value: branch,
                                              child: Text(
                                                branch,
                                                style: const TextStyle(
                                                    fontSize: 12),
                                              ),
                                            );
                                          }).toList(),
                                          onChanged: (String? val) {
                                            viewModel
                                                .setSelectedTransactionType(
                                                    val!);
                                          }),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 15,
                          ),
                          Expanded(
                              child: RawAutocomplete<Customer>(
                            optionsBuilder:
                                (TextEditingValue textEditingValue) {
                              if (textEditingValue.text == '') {
                                return const Iterable<Customer>.empty();
                              } else {
                                List<Customer> matches = <Customer>[];
                                matches.addAll(viewModel.allCustomers);

                                matches.retainWhere((s) {
                                  return s.name!.toLowerCase().contains(
                                      textEditingValue.text.toLowerCase());
                                });

                                return matches;
                              }
                            },
                            fieldViewBuilder: (
                              BuildContext context,
                              TextEditingController textEditingController,
                              FocusNode focusNode,
                              VoidCallback onFieldSubmitted,
                            ) {
                              return Container(
                                width: double.infinity,
                                height: 47,
                                decoration: const BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10)),
                                    color: Colors.white),
                                child: TextFormField(
                                    controller: textEditingController,
                                    focusNode: focusNode,
                                    onFieldSubmitted: (String value) {
                                      onFieldSubmitted();
                                    },
                                    decoration: InputDecoration(
                                      hintText: "Enter customer",
                                      labelText: "Customer",
                                      labelStyle: const TextStyle(
                                          color: Colors.black38),
                                      hintStyle: const TextStyle(
                                        color: Colors.black38,
                                        fontSize: 14,
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          width: 1,
                                          color: Colors.grey[300]!,
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(15.0),
                                      ),
                                    )),
                              );
                            },
                            optionsViewBuilder: (
                              BuildContext context,
                              AutocompleteOnSelected<Customer> onSelected,
                              Iterable<Customer> options,
                            ) {
                              return Align(
                                alignment: Alignment.topLeft,
                                child: Material(
                                  elevation: 4.0,
                                  color: Colors.white,
                                  child: ConstrainedBox(
                                    constraints: const BoxConstraints(
                                        maxHeight: 150, maxWidth: 380),
                                    child: ListView.builder(
                                      padding: const EdgeInsets.all(8.0),
                                      itemCount: options.length,
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        final Customer option =
                                            options.elementAt(index);
                                        return GestureDetector(
                                          onTap: () {
                                            onSelected(option);
                                            viewModel.setCreditCustomer(option);

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
                          )
                              // Container(
                              //   width: double.infinity,
                              //   height: 50,
                              //   decoration: BoxDecoration(
                              //       border: Border.all(
                              //           color: Colors.grey[400]!, width: 0.5),
                              //       borderRadius: const BorderRadius.all(
                              //           Radius.circular(15))),
                              //   child: Row(
                              //     mainAxisSize: MainAxisSize.max,
                              //     crossAxisAlignment: CrossAxisAlignment.center,
                              //     children: [
                              //       const SizedBox(
                              //         width: 15,
                              //       ),
                              //       Icon(
                              //         Icons.person_2,
                              //         color: Colors.grey[500],
                              //         size: 13,
                              //       ),
                              //       const SizedBox(
                              //         width: 10,
                              //       ),
                              //       Expanded(
                              //           child:

                              //           // DropdownButtonHideUnderline(
                              //           //   child: DropdownButton(
                              //           //       dropdownColor: Colors.white,
                              //           //       isExpanded: true,
                              //           //       icon: Icon(
                              //           //         Icons.expand_more,
                              //           //         color: Colors.grey[600],
                              //           //         size: 17,
                              //           //       ),
                              //           //       hint: const Text('Select customer',
                              //           //           style: TextStyle(
                              //           //               fontSize: 14,
                              //           //               color: Colors.black38)),
                              //           //       value: viewModel.selectedCustomer,
                              //           //       items: viewModel.allCustomers
                              //           //           .map((Customer customer) {
                              //           //         return DropdownMenuItem<String>(
                              //           //           value: customer.id.toString(),
                              //           //           child: Text(
                              //           //             "${customer.name} (${customer.phone})",
                              //           //             style: const TextStyle(
                              //           //                 fontSize: 12),
                              //           //           ),
                              //           //         );
                              //           //       }).toList(),
                              //           //       onChanged: (String? val) {
                              //           //         viewModel.setSelectedCustomer(val!);
                              //           //       }),
                              //           // ),
                              //           ),
                              //       const SizedBox(
                              //         width: 10,
                              //       ),
                              //     ],
                              //   ),
                              // ),
                              )
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),

                    // Container(
                    //   width: double.infinity,
                    //   padding: const EdgeInsets.only(top: 2, bottom: 2),
                    //   margin: const EdgeInsets.only(left: 20, right: 20),
                    //   child: Row(
                    //     mainAxisSize: MainAxisSize.max,
                    //     children: [
                    //       Expanded(
                    //         child: CustomFormField(
                    //           fillColor: Colors.white,
                    //           filled: true,
                    //           controller: viewModel.cusName,
                    //           labelText: "Customer Name",
                    //           hintText: "Enter customer name",
                    //         ),
                    //       ),
                    //       const SizedBox(
                    //         width: 15,
                    //       ),
                    //       Expanded(
                    //         child: CustomFormField(
                    //           fillColor: Colors.white,
                    //           filled: true,
                    //           controller: viewModel.cusPhone,
                    //           labelText: "Customer Phone",
                    //           hintText: "Enter customer phone",
                    //         ),
                    //       ),
                    //     ],
                    //   ),
                    // ),
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
