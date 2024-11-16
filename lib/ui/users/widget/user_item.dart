import 'package:flutter/material.dart';
import 'package:shop_manager/constants/colors.dart';
import 'package:shop_manager/ui/users/user_view.model.dart';

class UserItem extends StatelessWidget {
  final int index;
  final UserViewModel viewModel;
  const UserItem({super.key, required this.viewModel, required this.index});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 40,
      margin: const EdgeInsets.only(left: 20, right: 20),
      color: index % 2 == 0 ? Colors.white : Colors.grey[100],
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          Expanded(
            child: Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.only(left: 15),
                child: Text(
                  viewModel.users[index].name!,
                  style: const TextStyle(color: AppColors.crudTextColor),
                ),
              ),
            ),
          ),
          Expanded(
            child: Center(
              child: Text(
                viewModel.users[index].phone!,
                style: const TextStyle(color: AppColors.crudTextColor),
              ),
            ),
          ),
          Expanded(
            child: Center(
              child: Text(
                viewModel.capitalize(viewModel.users[index].role!),
                style: const TextStyle(color: AppColors.crudTextColor),
              ),
            ),
          ),
          Expanded(
            child: Center(
              child: Text(
                viewModel.capitalize(viewModel.users[index].access!),
                style: const TextStyle(color: AppColors.crudTextColor),
              ),
            ),
          ),
          Expanded(
            child: Center(
                child: Material(
              elevation: 2,
              borderRadius: const BorderRadius.all(Radius.circular(5)),
              child: InkWell(
                child: Container(
                  width: 30,
                  height: 30,
                  decoration: const BoxDecoration(
                    color: AppColors.primaryColor,
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                  ),
                  child: const Center(
                    child: Icon(
                      Icons.visibility,
                      size: 12,
                      color: Colors.white,
                    ),
                  ),
                ),
                onTap: () {
                  viewModel.showUserDetailOnTap(index);
                  // viewModel
                  //     .editCustomer(index);
                },
              ),
            )),
          ),
          Visibility(
            visible: viewModel.appService.user!.role == "manager" ||
                viewModel.appService.user!.role == "admin",
            child: Expanded(
                child: Center(
              child: Material(
                elevation: 2,
                borderRadius: const BorderRadius.all(Radius.circular(5)),
                child: InkWell(
                  child: Container(
                    width: 30,
                    height: 32,
                    decoration: const BoxDecoration(
                      color: AppColors.primaryColor,
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                    ),
                    child: const Center(
                      child: Icon(
                        Icons.settings,
                        size: 12,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  onTap: () {
                    viewModel.showUserManager(index);
                  },
                ),
              ),
            )),
          )
        ],
      ),
    );
  }
}
