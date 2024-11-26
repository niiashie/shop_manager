import 'package:flutter/material.dart';
import 'package:shop_manager/constants/colors.dart';
import 'package:shop_manager/constants/fonts.dart';
import 'package:shop_manager/ui/customers/customers_view.model.dart';
import 'package:shop_manager/ui/shared/close_button.dart';
import 'package:shop_manager/ui/shared/custom_button.dart';
import 'package:shop_manager/ui/shared/custom_form_field.dart';
import 'package:shop_manager/ui/shared/pagination.dart';
import 'package:stacked/stacked.dart';

class CustomerView extends StackedView<CustomerViewModel> {
  const CustomerView({Key? key}) : super(key: key);

  @override
  bool get reactive => true;

  @override
  bool get disposeViewModel => true;

  @override
  void onViewModelReady(CustomerViewModel viewModel) async {
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
                      const Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Customers",
                          style: TextStyle(
                              fontFamily: AppFonts.poppinsBold, fontSize: 22),
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: viewModel.showAddCustomer
                            ? CustomCloseButton(
                                size: 30,
                                onTap: () {
                                  viewModel.closeAddCustomerDialog();
                                },
                              )
                            : CustomButton(
                                width: 130,
                                height: 40,
                                elevation: 2,
                                color: AppColors.primaryColor,
                                title: const Text(
                                  "Add Customer",
                                  style: TextStyle(color: Colors.white),
                                ),
                                ontap: () {
                                  viewModel.displayAddCustomerDialog();
                                },
                              ),
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                Visibility(
                    visible: viewModel.showAddCustomer,
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
                                    "Phone Number",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Center(
                                  child: Text(
                                    "Location",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Center(
                                  child: Text(
                                    "Debt",
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
                            visible: viewModel.customerLoading,
                            replacement: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                ListView.builder(
                                    itemCount: viewModel.customers.length,
                                    shrinkWrap: true,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    itemBuilder: (context, index) {
                                      return Container(
                                        width: double.infinity,
                                        height: 40,
                                        margin: const EdgeInsets.only(
                                            left: 20, right: 20),
                                        color: viewModel
                                                    .customers[index].debt! >
                                                0
                                            ? Colors.redAccent.withOpacity(0.5)
                                            : index % 2 == 0
                                                ? Colors.white
                                                : Colors.grey[100],
                                        child: Row(
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            Expanded(
                                              child: Align(
                                                alignment: Alignment.centerLeft,
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 15),
                                                  child: Text(
                                                    viewModel
                                                        .customers[index].name!,
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
                                                  viewModel
                                                      .customers[index].phone!,
                                                  style: const TextStyle(
                                                      color: AppColors
                                                          .crudTextColor),
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              child: Center(
                                                child: Text(
                                                  viewModel.customers[index]
                                                          .location ??
                                                      "",
                                                  style: const TextStyle(
                                                      color: AppColors
                                                          .crudTextColor),
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              child: Center(
                                                child: Text(
                                                  "GHS ${viewModel.customers[index].debt!}",
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
                                                        .editCustomer(index);
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
                            "Fill in details required for customer to be added",
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Form(
                            key: viewModel.customerAdditionFormKey,
                            child: Column(
                              children: [
                                Padding(
                                  padding:
                                      const EdgeInsets.only(top: 2, bottom: 2),
                                  child: CustomFormField(
                                    controller: viewModel.name,
                                    filled: true,
                                    fillColor: Colors.white,
                                    label: "Name",
                                    prefixIcon: const Icon(
                                      Icons.person,
                                      color: Colors.grey,
                                      size: 14,
                                    ),
                                    validator: (String? value) {
                                      if (value!.isEmpty) {
                                        return "Name is required";
                                      }

                                      return null;
                                    },
                                    hintText: "Please enter name of customer",
                                  ),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.only(top: 2, bottom: 2),
                                  child: CustomFormField(
                                    controller: viewModel.phone,
                                    filled: true,
                                    fillColor: Colors.white,
                                    prefixIcon: const Icon(
                                      Icons.phone,
                                      color: Colors.grey,
                                      size: 14,
                                    ),
                                    label: "Phone Number",
                                    validator: (String? value) {
                                      if (value!.isEmpty) {
                                        return "Phone number price required";
                                      }

                                      return null;
                                    },
                                    hintText:
                                        "Please enter customer phone number",
                                  ),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.only(top: 2, bottom: 2),
                                  child: CustomFormField(
                                    controller: viewModel.location,
                                    filled: true,
                                    fillColor: Colors.white,
                                    label: "Location",
                                    prefixIcon: const Icon(
                                      Icons.location_on,
                                      color: Colors.grey,
                                      size: 14,
                                    ),
                                    hintText: "Please enter location address",
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
                                  viewModel.addCustomer();
                                },
                              ),
                            ),
                          )
                        ],
                      ),
                    ))
              ],
            ))));
  }

  @override
  CustomerViewModel viewModelBuilder(BuildContext context) =>
      CustomerViewModel();
}
