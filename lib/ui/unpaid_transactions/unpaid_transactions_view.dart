import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shop_manager/constants/colors.dart';
import 'package:shop_manager/constants/fonts.dart';
import 'package:shop_manager/ui/shared/custom_button.dart';
import 'package:shop_manager/ui/shared/empty_results.dart';
import 'package:shop_manager/ui/unpaid_transactions/unpaid_transactions_view_model.dart';
import 'package:shop_manager/utils.dart';
import 'package:stacked/stacked.dart';

class UnpaidTransactionsView extends StackedView<UnpaidTransactionsViewModel> {
  const UnpaidTransactionsView({Key? key}) : super(key: key);

  @override
  bool get reactive => true;

  @override
  bool get disposeViewModel => true;

  @override
  void onViewModelReady(UnpaidTransactionsViewModel viewModel) async {
    super.onViewModelReady(viewModel);
    viewModel.getUnpaidTransactions();
  }

  @override
  Widget builder(BuildContext context, viewModel, Widget? child) {
    return Scaffold(
        body: Container(
            color: Colors.white,
            width: double.infinity,
            height: double.infinity,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    width: double.infinity,
                    margin: const EdgeInsets.only(left: 10, right: 10),
                    height: 50,
                    child: Stack(
                      children: [
                        Align(
                            alignment: Alignment.centerLeft,
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.baseline,
                              textBaseline: TextBaseline.alphabetic,
                              children: [
                                InkWell(
                                  onHover: (a) {
                                    viewModel.receivedGoodsOnHover(a);
                                  },
                                  onTap: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: Text(
                                    "Transactions",
                                    style: TextStyle(
                                        color: viewModel.receivedGoodsColor,
                                        fontSize: 18),
                                  ),
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  ">",
                                  style: TextStyle(
                                      color: Colors.grey[500], fontSize: 18),
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                const Text(
                                  "Credit",
                                  style: TextStyle(
                                      fontFamily: AppFonts.poppinsBold,
                                      fontSize: 22),
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
                    height: 25,
                  ),
                  Visibility(
                    visible: viewModel.transactionLoading,
                    replacement: Visibility(
                      visible: viewModel.transactions.isNotEmpty ? true : false,
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
                                                            .transactions[index]
                                                            .user!
                                                            .name!,
                                                        style: const TextStyle(
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
                                                                .customer!
                                                                .name ??
                                                            "",
                                                        style: const TextStyle(
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
                                                        style: const TextStyle(
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
                                                style: TextStyle(fontSize: 13),
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
                                    decoration: BoxDecoration(
                                        color: viewModel
                                                    .transactions[index].type ==
                                                "cash"
                                            ? AppColors.primaryColor
                                            : Colors.redAccent,
                                        borderRadius: const BorderRadius.only(
                                            topLeft: Radius.circular(10),
                                            topRight: Radius.circular(10))),
                                    child: const Row(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        Expanded(
                                            child: Align(
                                          alignment: Alignment.centerLeft,
                                          child: Padding(
                                            padding: EdgeInsets.only(left: 15),
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
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                        )),
                                        Expanded(
                                            child: Center(
                                          child: Text(
                                            "Quantity",
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                        )),
                                        Expanded(
                                            child: Center(
                                          child: Text(
                                            "Amount",
                                            style:
                                                TextStyle(color: Colors.white),
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
                                                alignment: Alignment.centerLeft,
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
                                      }),
                                  Visibility(
                                      visible:
                                          viewModel.appService.user!.role ==
                                                  "manager" ||
                                              viewModel.appService.user!.role ==
                                                  "admin",
                                      child: SizedBox(
                                        width: double.infinity,
                                        height: 40,
                                        child: Align(
                                            alignment: Alignment.centerRight,
                                            child: Row(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                CustomButton(
                                                  width: 120,
                                                  height: 40,
                                                  elevation: 2,
                                                  isLoading: viewModel
                                                          .confirmTransactionLoaders[
                                                      index],
                                                  color: Colors.green.shade600,
                                                  title: const Row(
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    children: [
                                                      Icon(
                                                        Icons.check,
                                                        size: 12,
                                                        color: Colors.white,
                                                      ),
                                                      SizedBox(
                                                        width: 5,
                                                      ),
                                                      Text(
                                                        "Confirm",
                                                        style: TextStyle(
                                                            color:
                                                                Colors.white),
                                                      )
                                                    ],
                                                  ),
                                                  ontap: () {
                                                    viewModel
                                                        .validateCreditSale(
                                                            index, "approve");
                                                    //viewModel.acceptRequisition();
                                                  },
                                                ),
                                                const SizedBox(
                                                  width: 10,
                                                ),
                                                CustomButton(
                                                  width: 120,
                                                  height: 40,
                                                  elevation: 2,
                                                  isLoading: viewModel
                                                          .reverseTransactionLoaders[
                                                      index],
                                                  color: Colors.redAccent,
                                                  title: const Row(
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    children: [
                                                      Icon(
                                                        Icons.clear,
                                                        size: 12,
                                                        color: Colors.white,
                                                      ),
                                                      SizedBox(
                                                        width: 5,
                                                      ),
                                                      Text(
                                                        "Reject",
                                                        style: TextStyle(
                                                            color:
                                                                Colors.white),
                                                      )
                                                    ],
                                                  ),
                                                  ontap: () {
                                                    viewModel
                                                        .validateCreditSale(
                                                            index, "reverse");
                                                    //viewModel.rejectRequisition();
                                                  },
                                                ),
                                              ],
                                            )),
                                      ))
                                ],
                              ),
                            );
                          }),
                    ),
                    child: const SizedBox(
                      width: double.infinity,
                      height: 500,
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
                    ),
                  )
                ],
              ),
            )));
  }

  @override
  UnpaidTransactionsViewModel viewModelBuilder(BuildContext context) =>
      UnpaidTransactionsViewModel();
}
