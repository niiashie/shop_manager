import 'package:flutter/material.dart';
import 'package:shop_manager/constants/colors.dart';
import 'package:shop_manager/constants/fonts.dart';
import 'package:shop_manager/ui/branch/branch_view_model.dart';
import 'package:shop_manager/ui/shared/close_button.dart';
import 'package:shop_manager/ui/shared/custom_button.dart';
import 'package:shop_manager/ui/shared/custom_form_field.dart';
import 'package:stacked/stacked.dart';

class BranchView extends StackedView<BranchViewModel> {
  const BranchView({Key? key}) : super(key: key);

  @override
  bool get reactive => true;

  @override
  bool get disposeViewModel => true;

  @override
  void onViewModelReady(BranchViewModel viewModel) async {
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
                          "Branches",
                          style: TextStyle(
                              fontFamily: AppFonts.poppinsBold, fontSize: 22),
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: viewModel.showAddBranch
                            ? CustomCloseButton(
                                size: 30,
                                onTap: () {
                                  viewModel.closeAddBranchDialog();
                                },
                              )
                            : Visibility(
                                visible:
                                    viewModel.appService.user!.role == "admin",
                                child: CustomButton(
                                  width: 130,
                                  height: 40,
                                  elevation: 2,
                                  color: AppColors.primaryColor,
                                  title: const Text(
                                    "Add Branch",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  ontap: () {
                                    viewModel.displayAddBranchDialog();
                                  },
                                )),
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                Visibility(
                    visible: viewModel.showAddBranch,
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
                              SizedBox(
                                width: 70,
                              ),
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
                                    "Location Address",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Visibility(
                            visible: viewModel.branchLoading,
                            replacement: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                ListView.builder(
                                    itemCount: viewModel.branches.length,
                                    shrinkWrap: true,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    itemBuilder: (context, index) {
                                      return Container(
                                        width: double.infinity,
                                        height: 40,
                                        margin: const EdgeInsets.only(
                                            left: 20, right: 20),
                                        color: index % 2 == 0
                                            ? Colors.white
                                            : Colors.grey[100],
                                        child: Row(
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            SizedBox(
                                                width: 70,
                                                child: Center(
                                                  child: Text(
                                                    "${index + 1}.",
                                                    style: const TextStyle(
                                                        color: AppColors
                                                            .crudTextColor),
                                                  ),
                                                )),
                                            Expanded(
                                              child: Align(
                                                alignment: Alignment.centerLeft,
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 15),
                                                  child: Text(
                                                    viewModel
                                                        .branches[index].name!,
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
                                                      .branches[index].phone!,
                                                  style: const TextStyle(
                                                      color: AppColors
                                                          .crudTextColor),
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              child: Center(
                                                child: Text(
                                                  viewModel
                                                      .branches[index].address!,
                                                  style: const TextStyle(
                                                      color: AppColors
                                                          .crudTextColor),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      );
                                    }),
                                const SizedBox(height: 20),
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
                                    controller: viewModel.address,
                                    filled: true,
                                    fillColor: Colors.white,
                                    label: "Location Address",
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
                                  viewModel.addBranchRequest();
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
  BranchViewModel viewModelBuilder(BuildContext context) => BranchViewModel();
}
