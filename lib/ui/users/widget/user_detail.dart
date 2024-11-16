import 'package:flutter/material.dart';
import 'package:shop_manager/constants/colors.dart';
import 'package:shop_manager/constants/fonts.dart';
import 'package:shop_manager/ui/shared/custom_button.dart';
import 'package:shop_manager/ui/shared/custom_form_field.dart';
import 'package:shop_manager/ui/users/user_view.model.dart';

class UserDetailView extends StatelessWidget {
  final UserViewModel viewModel;
  const UserDetailView({super.key, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 450,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
          border: Border.all(color: Colors.grey[300]!, width: 1),
          borderRadius: const BorderRadius.all(Radius.circular(15))),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(
            height: 10,
          ),
          const Text(
            "User Details",
            style: TextStyle(fontSize: 16, fontFamily: AppFonts.poppinsMedium),
          ),
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 2, bottom: 2),
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
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 2, bottom: 2),
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
          ),
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 2, bottom: 2),
            child: CustomFormField(
              controller: TextEditingController(
                  text: viewModel.selectedUser != null
                      ? viewModel.selectedUser!.role
                      : ""),
              filled: true,
              fillColor: Colors.white,
              readOnly: true,
              label: "Role",
              prefixIcon: const Icon(
                Icons.work,
                color: Colors.grey,
                size: 14,
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 2, bottom: 2),
            child: CustomFormField(
              controller: TextEditingController(
                  text: viewModel.selectedUser != null
                      ? viewModel.selectedUser!.access
                      : ""),
              filled: true,
              fillColor: Colors.white,
              readOnly: true,
              label: "Access",
              prefixIcon: const Icon(
                Icons.visibility,
                color: Colors.grey,
                size: 14,
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          const SizedBox(
            width: double.infinity,
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Branches",
                style: TextStyle(color: Colors.grey),
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          ListView.builder(
              itemCount: viewModel.selectedUser != null
                  ? viewModel.selectedUser!.branches!.length
                  : 0,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return Container(
                  width: double.infinity,
                  height: 40,
                  decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius:
                          const BorderRadius.all(Radius.circular(10))),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: Text(
                        viewModel.selectedUser!.branches![index].name!,
                        style: const TextStyle(color: AppColors.crudTextColor),
                      ),
                    ),
                  ),
                );
              }),
          const SizedBox(
            height: 15,
          ),
        ],
      ),
    );
  }
}
