import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shop_manager/api/product_api.dart';
import 'package:shop_manager/app/locator.dart';
import 'package:shop_manager/constants/colors.dart';
import 'package:shop_manager/constants/fonts.dart';
import 'package:shop_manager/models/api_response.dart';
import 'package:shop_manager/models/product.dart';
import 'package:shop_manager/services/app_service.dart';
import 'package:shop_manager/ui/shared/close_button.dart';
import 'package:shop_manager/ui/shared/custom_button.dart';
import 'package:shop_manager/ui/shared/custom_form_field.dart';
import 'package:shop_manager/utils.dart';
import 'package:stacked_services/stacked_services.dart' as pw;

class ProductUpdate extends StatefulWidget {
  final Product? product;
  final Function(Product) onProductUpdated;
  const ProductUpdate(
      {super.key, this.product, required this.onProductUpdated});

  @override
  State<ProductUpdate> createState() => _ProductUpdateState();
}

class _ProductUpdateState extends State<ProductUpdate> {
  TextEditingController? name, costPrice, sellingPrice;
  bool isLoading = false;
  ProductApi productApi = ProductApi();
  final GlobalKey<FormState> productUpdateFormKey = GlobalKey<FormState>();
  var appService = locator<AppService>();
  @override
  void initState() {
    name = TextEditingController(text: widget.product!.name);
    costPrice =
        TextEditingController(text: widget.product!.costPrice.toString());
    sellingPrice =
        TextEditingController(text: widget.product!.sellingPrice.toString());
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
                    "Product Update",
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
                            return "Product name is required";
                          }

                          return null;
                        },
                        label: "Name",
                        hintText: "Enter new product name",
                      ),
                    )),
                Padding(
                    padding: const EdgeInsets.only(top: 5, bottom: 5),
                    child: SizedBox(
                      width: 340,
                      child: CustomFormField(
                        fillColor: Colors.white,
                        filled: true,
                        controller: costPrice,
                        validator: (String? value) {
                          if (value!.isEmpty) {
                            return "Cost price required";
                          } else if (Utils().isNumeric(value) == false) {
                            return "Cost price must be numeric";
                          }

                          return null;
                        },
                        label: "Cost Price",
                        hintText: "Enter new cost price",
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
                            return "Selling price required";
                          } else if (Utils().isNumeric(value) == false) {
                            return "Selling price must be numeric";
                          }

                          return null;
                        },
                        controller: sellingPrice,
                        label: "Selling Price",
                        hintText: "Enter new selling price",
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
                  "Update Product",
                  style: TextStyle(color: Colors.white),
                ),
                ontap: () {
                  updateProductRequest();
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
        "id": widget.product!.id,
        'name': name!.text,
        'cost_price': costPrice!.text,
        'selling_price': sellingPrice!.text
      };

      try {
        ApiResponse updateProductResponse =
            await productApi.updateProduct(data);
        if (updateProductResponse.ok) {
          setState(() {
            isLoading = false;
          });
          Map<String, dynamic> body = updateProductResponse.body;
          Navigator.of(pw.StackedService.navigatorKey!.currentContext!).pop();
          widget.onProductUpdated(Product.fromJson(body['product']));
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
