import 'package:flutter/material.dart';
import 'package:shop_manager/constants/colors.dart';
import 'package:shop_manager/constants/fonts.dart';
import 'package:shop_manager/constants/routes.dart';
import 'package:shop_manager/ui/login/login.view.model.dart';
import 'package:shop_manager/ui/shared/custom_button.dart';
import 'package:shop_manager/ui/shared/custom_form_field.dart';
import 'package:stacked/stacked.dart';

import '../../../constants/app.dart';
import '../../constants/assets.dart';

class LoginScreen extends StackedView<LoginViewModel> {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  bool get reactive => true;

  @override
  bool get disposeViewModel => true;

  @override
  void onViewModelReady(LoginViewModel viewModel) async {
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
                    height: 520,
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
                                      top: 10, bottom: 10),
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
                                        key: viewModel.loginFormKey,
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
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
                                                validator: (String? value) {
                                                  if (value!.isEmpty) {
                                                    return "Password required";
                                                  }

                                                  return null;
                                                },
                                                isPasswordField: true,
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
                                        color: AppColors.primaryColor,
                                        isLoading: viewModel.isLoading,
                                        title: const Text(
                                          "Sign In",
                                          style: TextStyle(color: Colors.white),
                                        ),
                                        ontap: () {
                                          viewModel.login();
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
                                                "Create Account",
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
                                                    Routes.register);
                                            debugPrint("Creating account");
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
            )
          ],
        ),
      ),
    );
  }

  @override
  LoginViewModel viewModelBuilder(BuildContext context) => LoginViewModel();
}


// import 'package:flutter/material.dart';
// import 'package:shop_manager/constants/assets.dart';
// import 'package:shop_manager/constants/fonts.dart';
// import 'package:shop_manager/ui/shared/custom_form_field.dart';

// class LoginScreen extends StatefulWidget {
//   const LoginScreen({super.key});

//   @override
//   State<LoginScreen> createState() => _LoginScreenState();
// }

// class _LoginScreenState extends State<LoginScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return 

//   }
// }
