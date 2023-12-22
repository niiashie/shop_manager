import 'package:flutter/material.dart';
import 'package:shop_manager/constants/assets.dart';
import 'package:shop_manager/constants/colors.dart';
import 'package:shop_manager/constants/fonts.dart';
import 'package:shop_manager/constants/routes.dart';
import 'package:shop_manager/ui/registration/registration.view.model.dart';
import 'package:shop_manager/ui/shared/custom_button.dart';
import 'package:shop_manager/ui/shared/custom_form_field.dart';
import 'package:stacked/stacked.dart';

class RegistrationView extends StackedView<RegistrationViewModel> {
  const RegistrationView({Key? key}) : super(key: key);

  @override
  bool get reactive => true;

  @override
  bool get disposeViewModel => true;

  @override
  void onViewModelReady(RegistrationViewModel viewModel) async {
    viewModel.init();
    super.onViewModelReady(viewModel);
    debugPrint("Do something...");
  }

  @override
  Widget builder(BuildContext context, viewModel, Widget? child) {
    return Scaffold(
        body: SizedBox(
      width: double.infinity,
      height: double.infinity,
      child: Stack(
        children: [
          Image.asset(
            AppImages.stockManager,
            width: double.infinity,
            height: double.infinity,
            fit: BoxFit.fill,
          ),
          Container(
            width: double.infinity,
            height: double.infinity,
            color: Colors.black.withOpacity(0.5),
          ),
          Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    "SHOP MANAGER",
                    style: TextStyle(
                        fontFamily: AppFonts.poppinsMedium,
                        color: Colors.white,
                        fontSize: 35),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  const Text(
                    "Keep Track Of Your Stock And Manage Your Inventory",
                    style: TextStyle(color: Colors.white, fontSize: 17),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    width: 500,
                    height: 800,
                    child: Stack(
                      children: [
                        Align(
                          alignment: Alignment.topCenter,
                          child: Padding(
                              padding: const EdgeInsets.only(top: 50),
                              child: Material(
                                elevation: 2,
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(15)),
                                child: Container(
                                  width: double.infinity,
                                  padding: const EdgeInsets.only(
                                      top: 15, bottom: 15),
                                  decoration: const BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(15))),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      const SizedBox(
                                        height: 65,
                                      ),
                                      const Text(
                                        "Lets get started now!",
                                        style: TextStyle(
                                            fontFamily: AppFonts.poppinsMedium,
                                            fontSize: 18),
                                      ),
                                      const Text(
                                          "Key in your credentials to login or create an account"),
                                      const SizedBox(
                                        height: 15,
                                      ),
                                      Form(
                                        key: viewModel.registrationFormKey,
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            SizedBox(
                                              width: 300,
                                              child: CustomFormField(
                                                fillColor: Colors.white,
                                                filled: true,
                                                controller:
                                                    viewModel.nameController,
                                                hintText: "Enter your Name",
                                                labelText: "Name",
                                                validator: (String? value) {
                                                  if (value!.isEmpty) {
                                                    return "Name required";
                                                  }

                                                  return null;
                                                },
                                                prefixIcon: Icon(
                                                  Icons.badge_outlined,
                                                  color: Colors.grey[400]!,
                                                  size: 15,
                                                ),
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            SizedBox(
                                              width: 300,
                                              child: CustomFormField(
                                                fillColor: Colors.white,
                                                filled: true,
                                                controller:
                                                    viewModel.phoneController,
                                                hintText:
                                                    "Enter Your Phone Number",
                                                labelText: "Phone Number",
                                                validator: (String? value) {
                                                  if (value!.isEmpty) {
                                                    return "Phone number required";
                                                  }

                                                  return null;
                                                },
                                                prefixIcon: Icon(
                                                  Icons.badge_outlined,
                                                  color: Colors.grey[400]!,
                                                  size: 15,
                                                ),
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            SizedBox(
                                              width: 300,
                                              child: CustomFormField(
                                                fillColor: Colors.white,
                                                filled: true,
                                                controller:
                                                    viewModel.pinController,
                                                hintText: "Enter your PIN",
                                                labelText: "PIN",
                                                validator: (String? value) {
                                                  if (value!.isEmpty) {
                                                    return "PIN required";
                                                  } else if (value.length < 4) {
                                                    return "PIN should be at lease 4 digits";
                                                  }

                                                  return null;
                                                },
                                                prefixIcon: Icon(
                                                  Icons.badge_outlined,
                                                  color: Colors.grey[400]!,
                                                  size: 15,
                                                ),
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            SizedBox(
                                              width: 300,
                                              child: CustomFormField(
                                                fillColor: Colors.white,
                                                filled: true,
                                                controller: viewModel
                                                    .passwordController,
                                                hintText: "Enter your password",
                                                labelText: "Password",
                                                isPasswordField: true,
                                                validator: (String? value) {
                                                  if (value!.isEmpty) {
                                                    return "Password required";
                                                  }

                                                  return null;
                                                },
                                                prefixIcon: Icon(
                                                  Icons.lock_outline,
                                                  color: Colors.grey[400]!,
                                                  size: 15,
                                                ),
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            SizedBox(
                                              width: 300,
                                              child: CustomFormField(
                                                fillColor: Colors.white,
                                                filled: true,
                                                controller: viewModel
                                                    .confirmPasswordController,
                                                hintText:
                                                    "Confirm your password",
                                                labelText: "Confirm Password",
                                                isPasswordField: true,
                                                validator: (String? value) {
                                                  if (value!.isEmpty) {
                                                    return "Password confirmation required";
                                                  }

                                                  return null;
                                                },
                                                prefixIcon: Icon(
                                                  Icons.lock_outline,
                                                  color: Colors.grey[400]!,
                                                  size: 15,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 15,
                                      ),
                                      CustomButton(
                                        width: 150,
                                        height: 40,
                                        elevation: 2,
                                        isLoading: viewModel.isLoading,
                                        color: AppColors.primaryColor,
                                        title: const Text(
                                          "Create Account",
                                          style: TextStyle(color: Colors.white),
                                        ),
                                        ontap: () {
                                          viewModel.register();
                                        },
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Material(
                                        color: Colors.transparent,
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(20)),
                                        child: InkWell(
                                          child: const SizedBox(
                                            width: 150,
                                            height: 40,
                                            child: Center(
                                              child: Text(
                                                "Sign In",
                                                style: TextStyle(
                                                    color:
                                                        AppColors.primaryColor,
                                                    fontFamily:
                                                        AppFonts.poppinsMedium),
                                              ),
                                            ),
                                          ),
                                          onTap: () {
                                            Navigator.of(context)
                                                .pushReplacementNamed(
                                                    Routes.login);
                                          },
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              )),
                        ),
                        Align(
                          alignment: Alignment.topCenter,
                          child: Material(
                            elevation: 2,
                            borderRadius:
                                const BorderRadius.all(Radius.circular(50)),
                            child: Container(
                              width: 100,
                              height: 100,
                              decoration: const BoxDecoration(
                                  shape: BoxShape.circle, color: Colors.white),
                              child: Center(
                                child: Image.asset(
                                  AppImages.stockGrowth,
                                  width: 60,
                                  height: 60,
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    ));
  }

  @override
  RegistrationViewModel viewModelBuilder(BuildContext context) =>
      RegistrationViewModel();
}
