import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:shop_manager/constants/assets.dart';
import 'package:shop_manager/constants/colors.dart';
import 'package:shop_manager/constants/fonts.dart';
import 'package:shop_manager/ui/profit/profit_view_model.dart';
import 'package:shop_manager/ui/shared/custom_button.dart';
import 'package:shop_manager/ui/shared/custom_form_field.dart';
import 'package:shop_manager/ui/shared/empty_results.dart';
import 'package:stacked/stacked.dart';

class ProfitView extends StackedView<ProfitViewModel> {
  const ProfitView({Key? key}) : super(key: key);

  @override
  bool get reactive => true;

  @override
  bool get disposeViewModel => true;

  @override
  void onViewModelReady(ProfitViewModel viewModel) async {
    super.onViewModelReady(viewModel);
    viewModel.init();
    debugPrint("Do something...");
  }

  @override
  Widget builder(BuildContext context, viewModel, Widget? child) {
    return Scaffold(
        body: SizedBox(
            width: double.infinity,
            height: double.infinity,
            child: Visibility(
                visible:
                    viewModel.appService.user!.role == "manager" ? true : false,
                replacement: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Lottie.asset(AppImages.errorAnim,
                          width: 120, height: 120),
                      const SizedBox(
                        height: 15,
                      ),
                      const Text(
                        "Unauthorized Access",
                        style: TextStyle(
                            fontFamily: AppFonts.poppinsMedium, fontSize: 20),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      const Text(
                          "Sorry you have not been granted access to view profit margins. Thank you")
                    ],
                  ),
                ),
                child: SingleChildScrollView(
                    child: Column(
                  children: [
                    const SizedBox(
                      height: 15,
                    ),
                    SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: Stack(
                          children: [
                            const Align(
                                alignment: Alignment.centerLeft,
                                child: Padding(
                                    padding: EdgeInsets.only(left: 20),
                                    child: Text(
                                      "Profit Margins",
                                      style: TextStyle(
                                          fontFamily: AppFonts.poppinsBold,
                                          fontSize: 22),
                                    ))),
                            Align(
                              alignment: Alignment.centerRight,
                              child: Padding(
                                padding: const EdgeInsets.only(right: 20),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                      width: 170,
                                      child: CustomFormField(
                                        controller: viewModel.startDate,
                                        contentPadding: 2,
                                        fillColor: Colors.white,
                                        filled: true,
                                        prefixIcon: const Icon(
                                          Icons.calendar_month,
                                          size: 15,
                                        ),
                                        hintText: "Start Date",
                                        labelText: "Start Date",
                                        onTap: () {
                                          viewModel
                                              .selectDate(viewModel.startDate!);
                                        },
                                        readOnly: true,
                                      ),
                                    ),
                                    const SizedBox(width: 10),
                                    SizedBox(
                                      width: 170,
                                      child: CustomFormField(
                                        controller: viewModel.endDate,
                                        contentPadding: 2,
                                        fillColor: Colors.white,
                                        filled: true,
                                        prefixIcon: const Icon(
                                          Icons.calendar_month,
                                          size: 15,
                                        ),
                                        hintText: "End Date",
                                        labelText: "End Date",
                                        onTap: () {
                                          viewModel
                                              .selectDate(viewModel.endDate!);
                                        },
                                        readOnly: true,
                                      ),
                                    ),
                                    const SizedBox(width: 10),
                                    CustomButton(
                                      width: 100,
                                      height: 47,
                                      elevation: 2,
                                      color: AppColors.primaryColor,
                                      title: const Row(
                                        mainAxisSize: MainAxisSize.min,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Icon(
                                            Icons.filter_alt_outlined,
                                            size: 15,
                                            color: Colors.white,
                                          ),
                                          SizedBox(
                                            width: 5,
                                          ),
                                          Text(
                                            "Filter",
                                            style:
                                                TextStyle(color: Colors.white),
                                          )
                                        ],
                                      ),
                                      ontap: () {
                                        viewModel.onFilterTapped();
                                      },
                                    )
                                  ],
                                ),
                              ),
                            )
                          ],
                        )),
                    const SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: Center(
                        child: Container(
                          width: 170,
                          height: 45,
                          decoration: const BoxDecoration(
                              color: AppColors.primaryColor,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20))),
                          child: Center(
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.baseline,
                              textBaseline: TextBaseline.alphabetic,
                              children: [
                                const Text(
                                  "Profit : ",
                                  style: TextStyle(
                                      fontSize: 11, color: Colors.white),
                                ),
                                const SizedBox(width: 5),
                                const Text(
                                  "GHS",
                                  style: TextStyle(
                                      fontSize: 11, color: Colors.white),
                                ),
                                const SizedBox(width: 5),
                                Text(
                                  viewModel.total.toString(),
                                  style: const TextStyle(
                                      fontSize: 17, color: Colors.white),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    Visibility(
                        visible: viewModel.transactionLoading,
                        replacement: Visibility(
                          visible: viewModel.transactions.isEmpty,
                          replacement: ListView.builder(
                              itemCount: viewModel.transactions.length,
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemBuilder: (context, index) {
                                return Container(
                                  width: double.infinity,
                                  margin: const EdgeInsets.only(
                                      left: 30, right: 30),
                                  padding:
                                      const EdgeInsets.only(top: 5, bottom: 5),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      SizedBox(
                                        width: double.infinity,
                                        height: 50,
                                        child: Stack(
                                          children: [
                                            Align(
                                              alignment: Alignment.centerLeft,
                                              child: Text(
                                                "${DateFormat.yMMMd().format(viewModel.transactions[index].dateAdded!)} ${DateFormat.jm().format(viewModel.transactions[index].dateAdded!)}",
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        width: double.infinity,
                                        height: 40,
                                        decoration: const BoxDecoration(
                                            color: AppColors.primaryColor,
                                            borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(10),
                                                topRight: Radius.circular(10))),
                                        child: const Row(
                                          mainAxisSize: MainAxisSize.max,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Expanded(
                                                child: Align(
                                              alignment: Alignment.centerLeft,
                                              child: Padding(
                                                padding:
                                                    EdgeInsets.only(left: 10),
                                                child: Text(
                                                  "Product",
                                                  style: TextStyle(
                                                      color: Colors.white),
                                                ),
                                              ),
                                            )),
                                            Expanded(
                                              child: Center(
                                                child: Text(
                                                  "CostPrice",
                                                  style: TextStyle(
                                                      color: Colors.white),
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              child: Center(
                                                child: Text(
                                                  "Selling Price",
                                                  style: TextStyle(
                                                      color: Colors.white),
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              child: Center(
                                                child: Text(
                                                  "Quantity",
                                                  style: TextStyle(
                                                      color: Colors.white),
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              child: Center(
                                                child: Text(
                                                  "Amount",
                                                  style: TextStyle(
                                                      color: Colors.white),
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              child: Center(
                                                child: Text(
                                                  "Profit",
                                                  style: TextStyle(
                                                      color: Colors.white),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      ListView.builder(
                                          itemCount: viewModel
                                              .transactions[index]
                                              .transactionProducts!
                                              .length,
                                          physics:
                                              const NeverScrollableScrollPhysics(),
                                          shrinkWrap: true,
                                          itemBuilder: (context, index2) {
                                            return Container(
                                              width: double.infinity,
                                              height: 40,
                                              color: index2 % 2 == 0
                                                  ? Colors.white
                                                  : Colors.grey[100],
                                              child: Row(
                                                mainAxisSize: MainAxisSize.max,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  Expanded(
                                                      child: Align(
                                                    alignment:
                                                        Alignment.centerLeft,
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 10),
                                                      child: Text(
                                                        viewModel
                                                            .transactions[index]
                                                            .transactionProducts![
                                                                index2]
                                                            .product!
                                                            .name!,
                                                      ),
                                                    ),
                                                  )),
                                                  Expanded(
                                                    child: Center(
                                                      child: Text(
                                                        viewModel
                                                            .transactions[index]
                                                            .transactionProducts![
                                                                index2]
                                                            .costPrice
                                                            .toString(),
                                                      ),
                                                    ),
                                                  ),
                                                  Expanded(
                                                    child: Center(
                                                      child: Text(
                                                        viewModel
                                                            .transactions[index]
                                                            .transactionProducts![
                                                                index2]
                                                            .unitPrice
                                                            .toString(),
                                                      ),
                                                    ),
                                                  ),
                                                  Expanded(
                                                    child: Center(
                                                      child: Text(
                                                        viewModel
                                                            .transactions[index]
                                                            .transactionProducts![
                                                                index2]
                                                            .quantity
                                                            .toString(),
                                                      ),
                                                    ),
                                                  ),
                                                  Expanded(
                                                    child: Center(
                                                      child: Text(
                                                        viewModel
                                                            .transactions[index]
                                                            .transactionProducts![
                                                                index2]
                                                            .amount
                                                            .toString(),
                                                      ),
                                                    ),
                                                  ),
                                                  Expanded(
                                                    child: Center(
                                                      child: Text(
                                                        "${viewModel.transactions[index].transactionProducts![index2].amount! - (viewModel.transactions[index].transactionProducts![index2].costPrice! * viewModel.transactions[index].transactionProducts![index2].quantity!)}",
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            );
                                          }),
                                      SizedBox(
                                        width: double.infinity,
                                        height: 40,
                                        child: Align(
                                          alignment: Alignment.centerRight,
                                          child: Container(
                                            height: 40,
                                            width: 200,
                                            color: Colors.red,
                                            child: Center(
                                              child: Row(
                                                mainAxisSize: MainAxisSize.min,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.baseline,
                                                textBaseline:
                                                    TextBaseline.ideographic,
                                                children: [
                                                  const Text(
                                                    "Total : ",
                                                    style: TextStyle(
                                                        fontSize: 11,
                                                        color: Colors.white),
                                                  ),
                                                  const SizedBox(
                                                    width: 5,
                                                  ),
                                                  const Text(
                                                    "GHS",
                                                    style: TextStyle(
                                                        fontSize: 11,
                                                        color: Colors.white),
                                                  ),
                                                  const SizedBox(
                                                    width: 5,
                                                  ),
                                                  Text(
                                                    viewModel.getTotalProfit(
                                                        viewModel.transactions[
                                                            index]),
                                                    style: const TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 18),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                );
                              }),
                          child: const SizedBox(
                            width: double.infinity,
                            height: 400,
                            child: Center(
                              child: CustomEmptyResults(
                                message: "No Transactions Yet?",
                              ),
                            ),
                          ),
                        ),
                        child: const SizedBox(
                          width: double.infinity,
                          height: 100,
                          child: Center(
                            child: CircularProgressIndicator(
                              strokeWidth: 1,
                            ),
                          ),
                        ))
                  ],
                )))));
  }

  @override
  ProfitViewModel viewModelBuilder(BuildContext context) => ProfitViewModel();
}
