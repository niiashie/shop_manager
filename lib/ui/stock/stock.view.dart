// ignore_for_file: prefer_is_empty

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shop_manager/constants/colors.dart';
import 'package:shop_manager/constants/fonts.dart';
import 'package:shop_manager/models/transaction.dart';
import 'package:shop_manager/ui/shared/custom_button.dart';
import 'package:shop_manager/ui/shared/custom_form_field.dart';
import 'package:shop_manager/ui/shared/empty_results.dart';
import 'package:shop_manager/ui/stock/stock.view.model.dart';
import 'package:stacked/stacked.dart';

class StockView extends StackedView<StockViewModel> {
  const StockView({Key? key}) : super(key: key);

  @override
  bool get reactive => true;

  @override
  bool get disposeViewModel => true;

  @override
  void onViewModelReady(StockViewModel viewModel) async {
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
            child: SingleChildScrollView(
                child: Visibility(
              visible: !viewModel.showTransactionHistory,
              replacement: Column(
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  const SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: Stack(
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: EdgeInsets.only(left: 10),
                            child: Text(
                              "Transaction History",
                              style: TextStyle(
                                  fontFamily: AppFonts.poppinsBold,
                                  fontSize: 22),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 15),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.only(top: 5, bottom: 5),
                    margin: const EdgeInsets.only(left: 25, right: 25),
                    child: Stack(
                      children: [
                        Align(
                            alignment: Alignment.centerLeft,
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                SizedBox(
                                  width: 200,
                                  child: CustomFormField(
                                    fillColor: Colors.white,
                                    filled: true,
                                    readOnly: true,
                                    contentPadding: 4,
                                    hintText: "Start Date",
                                    label: "Start Date",
                                    prefixIcon: const Icon(
                                      Icons.calendar_month,
                                      size: 12,
                                    ),
                                    onTap: () {
                                      viewModel
                                          .selectDate(viewModel.startDate!);
                                    },
                                    controller: viewModel.startDate,
                                  ),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                SizedBox(
                                  width: 200,
                                  child: CustomFormField(
                                    fillColor: Colors.white,
                                    filled: true,
                                    readOnly: true,
                                    contentPadding: 4,
                                    hintText: "End Date",
                                    label: "End Date",
                                    prefixIcon: const Icon(
                                      Icons.calendar_month,
                                      size: 12,
                                    ),
                                    onTap: () {
                                      viewModel.selectDate(viewModel.endDate!);
                                    },
                                    controller: viewModel.endDate,
                                  ),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 23),
                                  child: CustomButton(
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
                                          style: TextStyle(color: Colors.white),
                                        )
                                      ],
                                    ),
                                    ontap: () {
                                      viewModel.filterTransactions();
                                      // viewModel.getTransactions(
                                      //     {"date": viewModel.selectedDate});
                                    },
                                  ),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 23),
                                  child: CustomButton(
                                    width: 50,
                                    height: 47,
                                    elevation: 2,
                                    color: AppColors.primaryColor,
                                    title: const Icon(
                                      Icons.today,
                                      color: Colors.white,
                                      size: 15,
                                    ),
                                    ontap: () {
                                      viewModel.showTodayTransaction();
                                      // viewModel.getTransactions(
                                      //     {"date": viewModel.selectedDate});
                                    },
                                  ),
                                ),
                              ],
                            )),
                        Align(
                            alignment: Alignment.centerRight,
                            child: Padding(
                              padding: const EdgeInsets.only(top: 10),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  const Text(
                                    "Total :   ",
                                  ),
                                  const Text(
                                    "GHS",
                                    style: TextStyle(fontSize: 12),
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    viewModel.historyTotal.toString(),
                                    style: const TextStyle(
                                        fontFamily: AppFonts.poppinsMedium,
                                        fontSize: 20),
                                  )
                                ],
                              ),
                            ))
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Visibility(
                      visible: viewModel.transactionLoading,
                      replacement: Visibility(
                        visible:
                            viewModel.transactions.length > 0 ? true : false,
                        replacement: const SizedBox(
                          width: double.infinity,
                          height: 400,
                          child: Center(
                            child: CustomEmptyResults(
                              message: "No Transactions Yet?",
                            ),
                          ),
                        ),
                        child: ListView.builder(
                            itemCount: viewModel.transactions.length,
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              return Container(
                                width: double.infinity,
                                padding:
                                    const EdgeInsets.only(top: 10, bottom: 10),
                                margin:
                                    const EdgeInsets.only(left: 25, right: 25),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    SizedBox(
                                      width: double.infinity,
                                      height: 70,
                                      child: Stack(
                                        children: [
                                          Align(
                                              alignment: Alignment.centerLeft,
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 10),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Row(
                                                      mainAxisSize:
                                                          MainAxisSize.min,
                                                      children: [
                                                        const Text(
                                                          "Cashier : ",
                                                          style: TextStyle(
                                                              fontSize: 13),
                                                        ),
                                                        const SizedBox(
                                                          width: 10,
                                                        ),
                                                        Text(
                                                          viewModel
                                                              .transactions[
                                                                  index]
                                                              .user!
                                                              .name!,
                                                          style:
                                                              const TextStyle(
                                                                  fontSize: 13),
                                                        )
                                                      ],
                                                    ),
                                                    Row(
                                                      mainAxisSize:
                                                          MainAxisSize.min,
                                                      children: [
                                                        const Text(
                                                          "Customer : ",
                                                          style: TextStyle(
                                                              fontSize: 13),
                                                        ),
                                                        const SizedBox(
                                                          width: 10,
                                                        ),
                                                        Text(
                                                          viewModel
                                                                  .transactions[
                                                                      index]
                                                                  .customer ??
                                                              "",
                                                          style:
                                                              const TextStyle(
                                                                  fontSize: 13),
                                                        )
                                                      ],
                                                    ),
                                                    Row(
                                                      mainAxisSize:
                                                          MainAxisSize.min,
                                                      children: [
                                                        const Text(
                                                          "Time : ",
                                                          style: TextStyle(
                                                              fontSize: 13),
                                                        ),
                                                        const SizedBox(
                                                          width: 10,
                                                        ),
                                                        Text(
                                                          "${DateFormat.yMMMd().format(viewModel.transactions[index].dateAdded!)} ${DateFormat.jm().format(viewModel.transactions[index].dateAdded!)}",
                                                          style:
                                                              const TextStyle(
                                                                  fontSize: 13),
                                                        )
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              )),
                                          Align(
                                            alignment: Alignment.centerRight,
                                            child: Row(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                const Text(
                                                  "Sub Total : ",
                                                  style:
                                                      TextStyle(fontSize: 13),
                                                ),
                                                const SizedBox(
                                                  width: 10,
                                                ),
                                                Text(
                                                  "GHS ${viewModel.transactions[index].total}",
                                                  style: const TextStyle(
                                                      fontSize: 17),
                                                )
                                              ],
                                            ),
                                          )
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
                                        children: [
                                          Expanded(
                                              child: Align(
                                            alignment: Alignment.centerLeft,
                                            child: Padding(
                                              padding:
                                                  EdgeInsets.only(left: 15),
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
                                              "Unit Price",
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                          )),
                                          Expanded(
                                              child: Center(
                                            child: Text(
                                              "Quantity",
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                          )),
                                          Expanded(
                                              child: Center(
                                            child: Text(
                                              "Amount",
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                          ))
                                        ],
                                      ),
                                    ),
                                    ListView.builder(
                                        itemCount: viewModel.transactions[index]
                                            .transactionProducts!.length,
                                        shrinkWrap: true,
                                        physics:
                                            const NeverScrollableScrollPhysics(),
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
                                                            left: 15),
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
                                                )
                                              ],
                                            ),
                                          );
                                        })
                                  ],
                                ),
                              );
                            }),
                      ),
                      child: const SizedBox(
                        width: double.infinity,
                        height: 200,
                        child: Center(
                          child: SizedBox(
                            width: 30,
                            height: 30,
                            child: CircularProgressIndicator(
                              strokeWidth: 1,
                              color: AppColors.primaryColor,
                            ),
                          ),
                        ),
                      ))
                ],
              ),
              child: Column(
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  const SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: Stack(
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: EdgeInsets.only(left: 10),
                            child: Text(
                              "Transactions",
                              style: TextStyle(
                                  fontFamily: AppFonts.poppinsBold,
                                  fontSize: 22),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.only(top: 5, bottom: 5),
                    margin: const EdgeInsets.only(left: 25, right: 25),
                    child: Stack(
                      children: [
                        Align(
                            alignment: Alignment.centerLeft,
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                SizedBox(
                                  width: 200,
                                  child: CustomFormField(
                                    fillColor: Colors.white,
                                    filled: true,
                                    readOnly: true,
                                    contentPadding: 4,
                                    hintText: "Select date",
                                    prefixIcon: const Icon(
                                      Icons.calendar_month,
                                      size: 12,
                                    ),
                                    onTap: () {
                                      viewModel.selectDate(viewModel.date!);
                                    },
                                    controller: viewModel.date,
                                  ),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
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
                                        style: TextStyle(color: Colors.white),
                                      )
                                    ],
                                  ),
                                  ontap: () {
                                    viewModel.getTransactions(
                                        {"date": viewModel.selectedDate});
                                  },
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                CustomButton(
                                  width: 50,
                                  height: 47,
                                  elevation: 2,
                                  color: AppColors.primaryColor,
                                  title: const Icon(
                                    Icons.history,
                                    color: Colors.white,
                                    size: 15,
                                  ),
                                  ontap: () {
                                    viewModel.showHistory();
                                    debugPrint("History");
                                  },
                                )
                              ],
                            )),
                        Align(
                            alignment: Alignment.centerRight,
                            child: Padding(
                              padding: const EdgeInsets.only(top: 10),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  const Text(
                                    "Total :   ",
                                  ),
                                  const Text(
                                    "GHS",
                                    style: TextStyle(fontSize: 12),
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    viewModel.total.toString(),
                                    style: const TextStyle(
                                        fontFamily: AppFonts.poppinsMedium,
                                        fontSize: 20),
                                  )
                                ],
                              ),
                            ))
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Visibility(
                      visible: viewModel.transactionLoading,
                      replacement: Visibility(
                        visible:
                            viewModel.transactions.length > 0 ? true : false,
                        replacement: const SizedBox(
                          width: double.infinity,
                          height: 400,
                          child: Center(
                            child: CustomEmptyResults(
                              message: "No Transactions Yet?",
                            ),
                          ),
                        ),
                        child: ListView.builder(
                            itemCount: viewModel.transactions.length,
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              return Container(
                                width: double.infinity,
                                padding:
                                    const EdgeInsets.only(top: 10, bottom: 10),
                                margin:
                                    const EdgeInsets.only(left: 25, right: 25),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    SizedBox(
                                      width: double.infinity,
                                      height: 70,
                                      child: Stack(
                                        children: [
                                          Align(
                                              alignment: Alignment.centerLeft,
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 10),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Row(
                                                      mainAxisSize:
                                                          MainAxisSize.min,
                                                      children: [
                                                        const Text(
                                                          "Cashier : ",
                                                          style: TextStyle(
                                                              fontSize: 13),
                                                        ),
                                                        const SizedBox(
                                                          width: 10,
                                                        ),
                                                        Text(
                                                          viewModel
                                                              .transactions[
                                                                  index]
                                                              .user!
                                                              .name!,
                                                          style:
                                                              const TextStyle(
                                                                  fontSize: 13),
                                                        )
                                                      ],
                                                    ),
                                                    Row(
                                                      mainAxisSize:
                                                          MainAxisSize.min,
                                                      children: [
                                                        const Text(
                                                          "Customer : ",
                                                          style: TextStyle(
                                                              fontSize: 13),
                                                        ),
                                                        const SizedBox(
                                                          width: 10,
                                                        ),
                                                        Text(
                                                          viewModel
                                                                  .transactions[
                                                                      index]
                                                                  .customer ??
                                                              "",
                                                          style:
                                                              const TextStyle(
                                                                  fontSize: 13),
                                                        )
                                                      ],
                                                    ),
                                                    Row(
                                                      mainAxisSize:
                                                          MainAxisSize.min,
                                                      children: [
                                                        const Text(
                                                          "Time : ",
                                                          style: TextStyle(
                                                              fontSize: 13),
                                                        ),
                                                        const SizedBox(
                                                          width: 10,
                                                        ),
                                                        Text(
                                                          DateFormat.jm()
                                                              .format(viewModel
                                                                  .transactions[
                                                                      index]
                                                                  .dateAdded!),
                                                          style:
                                                              const TextStyle(
                                                                  fontSize: 13),
                                                        )
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              )),
                                          Align(
                                            alignment: Alignment.centerRight,
                                            child: Row(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                const Text(
                                                  "Sub Total : ",
                                                  style:
                                                      TextStyle(fontSize: 13),
                                                ),
                                                const SizedBox(
                                                  width: 10,
                                                ),
                                                Text(
                                                  "GHS ${viewModel.transactions[index].total}",
                                                  style: const TextStyle(
                                                      fontSize: 17),
                                                )
                                              ],
                                            ),
                                          )
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
                                        children: [
                                          Expanded(
                                              child: Align(
                                            alignment: Alignment.centerLeft,
                                            child: Padding(
                                              padding:
                                                  EdgeInsets.only(left: 15),
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
                                              "Unit Price",
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                          )),
                                          Expanded(
                                              child: Center(
                                            child: Text(
                                              "Quantity",
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                          )),
                                          Expanded(
                                              child: Center(
                                            child: Text(
                                              "Amount",
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                          ))
                                        ],
                                      ),
                                    ),
                                    ListView.builder(
                                        itemCount: viewModel.transactions[index]
                                            .transactionProducts!.length,
                                        shrinkWrap: true,
                                        physics:
                                            const NeverScrollableScrollPhysics(),
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
                                                            left: 15),
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
                                                )
                                              ],
                                            ),
                                          );
                                        })
                                  ],
                                ),
                              );
                            }),
                      ),
                      child: const SizedBox(
                        width: double.infinity,
                        height: 200,
                        child: Center(
                          child: SizedBox(
                            width: 30,
                            height: 30,
                            child: CircularProgressIndicator(
                              strokeWidth: 1,
                              color: AppColors.primaryColor,
                            ),
                          ),
                        ),
                      ))
                ],
              ),
            ))));
  }

  @override
  StockViewModel viewModelBuilder(BuildContext context) => StockViewModel();
}
