import 'package:flutter/material.dart';
import 'package:shop_manager/constants/colors.dart';
import 'package:shop_manager/constants/fonts.dart';
import 'package:shop_manager/ui/shared/close_button.dart';
import 'package:shop_manager/ui/shared/custom_button.dart';
import 'package:shop_manager/ui/shared/custom_dropdown.dart';
import 'package:shop_manager/ui/shared/custom_form_field.dart';
import 'package:shop_manager/ui/shared/pagination.dart';
import 'package:shop_manager/ui/users/user_view.model.dart';
import 'package:shop_manager/ui/users/widget/user_detail.dart';
import 'package:shop_manager/ui/users/widget/user_item.dart';
import 'package:stacked/stacked.dart';

class UsersView extends StackedView<UserViewModel> {
  const UsersView({Key? key}) : super(key: key);

  @override
  bool get reactive => true;

  @override
  bool get disposeViewModel => true;

  @override
  void onViewModelReady(UserViewModel viewModel) async {
    super.onViewModelReady(viewModel);
    viewModel.getUsers();
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
                          "Users",
                          style: TextStyle(
                              fontFamily: AppFonts.poppinsBold, fontSize: 22),
                        ),
                      ),
                      Align(
                          alignment: Alignment.centerRight,
                          child: viewModel.showUserDetail
                              ? CustomCloseButton(
                                  size: 30,
                                  onTap: () {
                                    viewModel.closeUserDetail();
                                  },
                                )
                              : const SizedBox())
                    ],
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                Visibility(
                    visible: viewModel.showUserDetail,
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
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              const Expanded(
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
                              const Expanded(
                                child: Center(
                                  child: Text(
                                    "Phone Number",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ),
                              const Expanded(
                                child: Center(
                                  child: Text(
                                    "Role",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ),
                              const Expanded(
                                child: Center(
                                  child: Text(
                                    "Access",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ),
                              const Expanded(
                                child: Center(
                                  child: Text(
                                    "View",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ),
                              Visibility(
                                visible: viewModel.appService.user!.role ==
                                        "manager" ||
                                    viewModel.appService.user!.role == "admin",
                                child: const Expanded(
                                  child: Center(
                                    child: Text(
                                      "Manage",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        Visibility(
                            visible: viewModel.usersLoading,
                            replacement: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                ListView.builder(
                                    itemCount: viewModel.users.length,
                                    shrinkWrap: true,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    itemBuilder: (context, index) {
                                      return UserItem(
                                        index: index,
                                        viewModel: viewModel,
                                      );
                                    }),
                                const SizedBox(height: 20),
                                PaginationWidget(
                                  currentPage: viewModel.currentPage,
                                  totalPages: viewModel.totalPages,
                                  onPageChanged: (a) {
                                    //viewModel.changePage(a);
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
                    child: Visibility(
                      visible: viewModel.showManage,
                      replacement: UserDetailView(viewModel: viewModel),
                      child: Container(
                        width: 700,
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                            border:
                                Border.all(color: Colors.grey[300]!, width: 1),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(15))),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const SizedBox(
                              height: 10,
                            ),
                            const Text(
                              "User Details",
                              style: TextStyle(
                                  fontSize: 16,
                                  fontFamily: AppFonts.poppinsMedium),
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Expanded(
                                  child: CustomFormField(
                                    controller: TextEditingController(
                                        text: viewModel.selectedUser != null
                                            ? viewModel.selectedUser!.name
                                            : ""),
                                    filled: true,
                                    fillColor: Colors.white,
                                    readOnly: true,
                                    label: "Name",
                                    prefixIcon: const Icon(
                                      Icons.person,
                                      color: Colors.grey,
                                      size: 14,
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 15,
                                ),
                                Expanded(
                                  child: CustomFormField(
                                    controller: TextEditingController(
                                        text: viewModel.selectedUser != null
                                            ? viewModel.selectedUser!.phone
                                            : ""),
                                    filled: true,
                                    fillColor: Colors.white,
                                    readOnly: true,
                                    label: "Phone",
                                    prefixIcon: const Icon(
                                      Icons.phone,
                                      color: Colors.grey,
                                      size: 14,
                                    ),
                                  ),
                                )
                              ],
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Expanded(
                                  child: CustomDropdown(
                                    labelText: "Role",
                                    items: viewModel.roles,
                                    prefixIcon: const Icon(
                                      Icons.work,
                                      size: 13,
                                    ),
                                    defaultValue: viewModel.newUserRole,
                                    onChanged: (a) {
                                      viewModel.setSelectedRole(a!);
                                    },
                                    hintText: "Select Role",
                                  ),
                                ),
                                const SizedBox(
                                  width: 15,
                                ),
                                Expanded(
                                  child: CustomDropdown(
                                    labelText: "User Access",
                                    items: viewModel.access,
                                    prefixIcon: const Icon(
                                      Icons.visibility,
                                      size: 13,
                                    ),
                                    defaultValue: viewModel.newUserAccess,
                                    onChanged: (a) {
                                      viewModel.setUserAccess(a!);
                                    },
                                    hintText: "Select Access",
                                  ),
                                )
                              ],
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            const SizedBox(
                              width: double.infinity,
                              child: Padding(
                                padding: EdgeInsets.only(left: 3),
                                child: Text(
                                  "Branches",
                                  style: TextStyle(color: Colors.grey),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Container(
                                width: double.infinity,
                                padding: const EdgeInsets.only(
                                    top: 15, bottom: 15, left: 10, right: 10),
                                decoration: BoxDecoration(
                                    color: Colors.grey[200],
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(10))),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Wrap(
                                      spacing: 10.0,
                                      runSpacing: 10.0,
                                      children: List.generate(
                                          viewModel.selectedBranch.length,
                                          (index) {
                                        return Container(
                                          padding: const EdgeInsets.only(
                                              left: 10,
                                              right: 10,
                                              top: 5,
                                              bottom: 5),
                                          decoration: const BoxDecoration(
                                              color: AppColors.primaryColor,
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(15))),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Text(
                                                viewModel.selectedBranch[index]
                                                    .name!,
                                                style: const TextStyle(
                                                    color: Colors.white),
                                              ),
                                              const SizedBox(
                                                width: 10,
                                              ),
                                              InkWell(
                                                child: Container(
                                                  width: 15,
                                                  height: 15,
                                                  decoration:
                                                      const BoxDecoration(
                                                          shape:
                                                              BoxShape.circle,
                                                          color: Colors.white),
                                                  child: const Center(
                                                    child: Icon(
                                                      Icons.clear,
                                                      size: 11,
                                                      color: AppColors
                                                          .primaryColor,
                                                    ),
                                                  ),
                                                ),
                                                onTap: () {
                                                  viewModel
                                                      .removeSelectedBranchFromIndex(
                                                          index);
                                                },
                                              )
                                            ],
                                          ),
                                        );
                                      }),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    CustomDropdown(
                                        items: viewModel.branches
                                            .map((person) => person.name!)
                                            .toList(),
                                        prefixIcon: const Icon(
                                          Icons.apartment,
                                          size: 13,
                                          color: Colors.grey,
                                        ),
                                        hintText:
                                            "Select branch to user to branch",
                                        onChanged: (a) {
                                          viewModel.addUserToUserToBranch(a!);
                                        })
                                  ],
                                )),
                            const SizedBox(
                              height: 15,
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
                                    "Update",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  ontap: () {
                                    viewModel.updateUser();
                                    //viewModel.addCustomerRequest();
                                  },
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ))
              ],
            ))));
  }

  @override
  UserViewModel viewModelBuilder(BuildContext context) => UserViewModel();
}
