import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shop_manager/api/customer_api.dart';
import 'package:shop_manager/app/locator.dart';
import 'package:shop_manager/models/api_response.dart';
import 'package:shop_manager/models/customer.dart';
import 'package:shop_manager/services/app_service.dart';
import 'package:shop_manager/services/dialog.service.dart';
import 'package:shop_manager/ui/customers/widget/customers_edit_view.dart';
import 'package:stacked/stacked.dart';
import 'package:shop_manager/services/dialog.service.dart' as dialog;
import 'package:stacked_services/stacked_services.dart';

class CustomerViewModel extends BaseViewModel {
  final GlobalKey<FormState> customerAdditionFormKey = GlobalKey<FormState>();
  TextEditingController? name, phone, location;
  bool isLoading = false, showAddCustomer = false, customerLoading = false;
  var appService = locator<AppService>();
  int currentPage = 1, totalPages = 1;
  CustomerApi customerApi = CustomerApi();
  List<Customer> customers = [];

  init() {
    name = TextEditingController(text: "");
    phone = TextEditingController(text: "");
    location = TextEditingController(text: "");
    getCustomers(1);
  }

  displayAddCustomerDialog() {
    showAddCustomer = true;
    rebuildUi();
  }

  closeAddCustomerDialog() {
    showAddCustomer = false;
    rebuildUi();
  }

  changePage(int page) {
    currentPage = page;
    getCustomers(page);
  }

  editCustomer(index) {
    locator<dialog.DialogService>().show(
        type: "custom",
        title: "Success",
        customWidget: CustomersEditView(
          customer: customers[index],
          onCustomerUpdated: (customer) {
            customers[index] = customer;
            rebuildUi();
          },
        ));
  }

  getCustomers(int page) async {
    try {
      customerLoading = true;
      rebuildUi();
      ApiResponse getProductResponse =
          await customerApi.getCustomers(page: page);
      if (getProductResponse.ok) {
        List<dynamic> data = getProductResponse.data;
        totalPages = getProductResponse.body['last_page'];

        for (var obj in data) {
          customers.add(Customer.fromJson(obj));
        }
        customerLoading = false;
        rebuildUi();
      }
    } on DioException catch (e) {
      customerLoading = false;
      rebuildUi();
      ApiResponse errorResponse = ApiResponse.parse(e.response);
      debugPrint(errorResponse.message);
      appService.showErrorFromApiRequest(message: errorResponse.message!);
    }
  }

  addCustomerRequest() async {
    if (appService.user!.role != "staff") {
      Map<String, dynamic> data = {
        "name": name!.text,
        "phone": phone!.text,
        "location": location!.text
      };

      isLoading = true;
      rebuildUi();
      try {
        ApiResponse response = await customerApi.addCustomer(data);
        if (response.ok) {
          debugPrint("data: ${response.body}");
          customers.insert(0, Customer.fromJson(response.body['customer']));
          isLoading = false;
          rebuildUi();
          locator<dialog.DialogService>().show(
              message: "Successfully added customer",
              title: "Success",
              okayBtnText: "Okay",
              showCancelBtn: false,
              onOkayTap: () {
                Navigator.of(StackedService.navigatorKey!.currentContext!)
                    .pop();
              });
        }
      } on DioException catch (e) {
        isLoading = false;
        rebuildUi();
        ApiResponse errorResponse = ApiResponse.parse(e.response);
        debugPrint(errorResponse.message);
        appService.showErrorFromApiRequest(message: errorResponse.message!);
      }
    } else {
      appService.showErrorFromApiRequest(
          message: "Staff not allowed to add customers",
          title: "Unauthorized access");
    }
  }
}
