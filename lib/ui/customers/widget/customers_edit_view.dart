import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shop_manager/api/customer_api.dart';
import 'package:shop_manager/app/locator.dart';
import 'package:shop_manager/constants/colors.dart';
import 'package:shop_manager/constants/fonts.dart';
import 'package:shop_manager/models/api_response.dart';
import 'package:shop_manager/models/customer.dart';
import 'package:shop_manager/services/app_service.dart';
import 'package:shop_manager/ui/shared/close_button.dart';
import 'package:shop_manager/ui/shared/custom_button.dart';
import 'package:shop_manager/ui/shared/custom_form_field.dart';
import 'package:stacked_services/stacked_services.dart' as pw;

class CustomersEditView extends StatefulWidget {
  final Customer? customer;
  final Function(Customer) onCustomerUpdated;
  const CustomersEditView(
      {super.key, this.customer, required this.onCustomerUpdated});

  @override
  State<CustomersEditView> createState() => _CustomersEditViewState();
}

class _CustomersEditViewState extends State<CustomersEditView> {
  TextEditingController? name, phone, location;
  bool isLoading = false;
  CustomerApi customerApi = CustomerApi();
  final GlobalKey<FormState> productUpdateFormKey = GlobalKey<FormState>();
  var appService = locator<AppService>();

  @override
  void initState() {
    name = TextEditingController(text: widget.customer!.name);
    phone = TextEditingController(text: widget.customer!.phone!);

    location = TextEditingController(text: widget.customer!.location);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 400,
      padding: const EdgeInsets.all(20),
      decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(15))),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: double.infinity,
            height: 40,
            child: Stack(
              children: [
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Customer Update",
                    style: TextStyle(
                        fontFamily: AppFonts.poppinsBold, fontSize: 17),
                  ),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: CustomCloseButton(
                    size: 20,
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                  ),
                )
              ],
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          Form(
            key: productUpdateFormKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                    padding: const EdgeInsets.only(top: 5, bottom: 5),
                    child: SizedBox(
                      width: 340,
                      child: CustomFormField(
                        fillColor: Colors.white,
                        filled: true,
                        controller: name,
                        validator: (String? value) {
                          if (value!.isEmpty) {
                            return "Customer name is required";
                          }

                          return null;
                        },
                        label: "Name",
                        hintText: "Update customer name",
                      ),
                    )),
                Padding(
                    padding: const EdgeInsets.only(top: 5, bottom: 5),
                    child: SizedBox(
                      width: 340,
                      child: CustomFormField(
                        fillColor: Colors.white,
                        filled: true,
                        validator: (String? value) {
                          if (value!.isEmpty) {
                            return "Phone number required";
                          }

                          return null;
                        },
                        controller: phone,
                        label: "Phone Number",
                        hintText: "Update customer phone number",
                      ),
                    )),
                Padding(
                    padding: const EdgeInsets.only(top: 5, bottom: 5),
                    child: SizedBox(
                      width: 340,
                      child: CustomFormField(
                        fillColor: Colors.white,
                        filled: true,
                        validator: (String? value) {
                          if (value!.isEmpty) {
                            return "Location required";
                          }

                          return null;
                        },
                        controller: location,
                        label: "Location",
                        hintText: "Enter new product location",
                      ),
                    )),
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          SizedBox(
            width: 340,
            height: 40,
            child: Align(
              alignment: Alignment.centerRight,
              child: CustomButton(
                width: 150,
                height: 40,
                isLoading: isLoading,
                color: AppColors.primaryColor,
                elevation: 2,
                title: const Text(
                  "Update Customer",
                  style: TextStyle(color: Colors.white),
                ),
                ontap: () {
                  locator<AppService>().user!.role == "manager"
                      ? updateProductRequest()
                      : appService.showErrorFromApiRequest(
                          title: "Unauthorized Access",
                          message:
                              "You dont have the permission to update product");
                },
              ),
            ),
          )
        ],
      ),
    );
  }

  updateProductRequest() async {
    if (productUpdateFormKey.currentState!.validate()) {
      setState(() {
        isLoading = true;
      });

      Map<String, dynamic> data = {
        "id": widget.customer!.id,
        'name': name!.text,
        'phone': phone!.text,
        'location': location!.text,
      };

      try {
        ApiResponse updateProductResponse =
            await customerApi.updateCustomer(data);
        if (updateProductResponse.ok) {
          setState(() {
            isLoading = false;
          });
          Map<String, dynamic> body = updateProductResponse.body;

          Navigator.of(pw.StackedService.navigatorKey!.currentContext!).pop();
          widget.onCustomerUpdated(Customer.fromJson(body['customer']));
        }
      } on DioException catch (e) {
        isLoading = false;
        setState(() {});
        ApiResponse errorResponse = ApiResponse.parse(e.response);
        debugPrint(errorResponse.message);
        appService.showErrorFromApiRequest(message: errorResponse.message!);
      }
    }
  }
}
