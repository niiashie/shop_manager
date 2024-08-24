import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shop_manager/constants/colors.dart';
import 'package:shop_manager/constants/fonts.dart';
import 'package:shop_manager/ui/received_goods/received_goods_view.model.dart';
import 'package:shop_manager/ui/received_goods/widget/received_goods_details.dart';
import 'package:shop_manager/ui/shared/pagination.dart';
import 'package:stacked/stacked.dart';

class ReceivedGoodsView extends StackedView<ReceivedGoodsViewModel> {
  const ReceivedGoodsView({Key? key}) : super(key: key);

  @override
  bool get reactive => true;

  @override
  bool get disposeViewModel => true;

  @override
  void onViewModelReady(ReceivedGoodsViewModel viewModel) async {
    super.onViewModelReady(viewModel);
    viewModel.init();
    debugPrint("Do something...");
  }

  @override
  Widget builder(BuildContext context, viewModel, Widget? child) {
    return Scaffold(
        body: Container(
            color: Colors.white,
            width: double.infinity,
            height: double.infinity,
            child: Visibility(
              visible: viewModel.isLoading,
              replacement: SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    const SizedBox(
                      width: double.infinity,
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: EdgeInsets.only(left: 10),
                          child: Text(
                            "Received Goods",
                            style: TextStyle(
                                fontFamily: AppFonts.poppinsBold, fontSize: 22),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    Visibility(
                        visible: viewModel.showDetails,
                        replacement: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              width: double.infinity,
                              height: 40,
                              margin:
                                  const EdgeInsets.only(left: 20, right: 20),
                              decoration: const BoxDecoration(
                                  color: AppColors.primaryColor,
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(10),
                                      topRight: Radius.circular(10))),
                              child: const Row(
                                mainAxisSize: MainAxisSize.max,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    width: 50,
                                  ),
                                  Expanded(
                                    child: Align(
                                      alignment: Alignment.centerLeft,
                                      child: Padding(
                                        padding: EdgeInsets.only(left: 15),
                                        child: Text(
                                          "Description",
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Center(
                                      child: Text(
                                        "Creator",
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Center(
                                      child: Text(
                                        "Total",
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Center(
                                      child: Text(
                                        "Status",
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Center(
                                      child: Text(
                                        "Date",
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Center(
                                      child: Text(
                                        "Products",
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            ListView.builder(
                                itemCount: viewModel.requisitions.length,
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemBuilder: (context, index) {
                                  return Container(
                                    width: double.infinity,
                                    height: 40,
                                    margin: const EdgeInsets.only(
                                        left: 20, right: 20),
                                    color: index % 2 == 0
                                        ? Colors.white
                                        : Colors.grey[100],
                                    child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        SizedBox(
                                            width: 50,
                                            child: Center(
                                              child: Text(
                                                "${index + 1}",
                                                style: const TextStyle(
                                                    color: AppColors
                                                        .crudTextColor),
                                              ),
                                            )),
                                        Expanded(
                                          child: Align(
                                            alignment: Alignment.centerLeft,
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 15),
                                              child: Text(
                                                viewModel.requisitions[index]
                                                    .description!,
                                                overflow: TextOverflow.ellipsis,
                                                style: const TextStyle(
                                                    color: AppColors
                                                        .crudTextColor),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          child: Center(
                                            child: Text(
                                              viewModel.requisitions[index]
                                                  .user!.name!,
                                              style: const TextStyle(
                                                  color:
                                                      AppColors.crudTextColor),
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          child: Center(
                                            child: Text(
                                              "GHS ${viewModel.requisitions[index].total}",
                                              style: const TextStyle(
                                                  color:
                                                      AppColors.crudTextColor),
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          child: Center(
                                              child: Container(
                                                  height: 25,
                                                  width: 80,
                                                  decoration: BoxDecoration(
                                                      color: viewModel
                                                                  .requisitions[
                                                                      index]
                                                                  .status ==
                                                              "pending"
                                                          ? Colors.amber[700]
                                                          : viewModel
                                                                      .requisitions[
                                                                          index]
                                                                      .status ==
                                                                  "decline"
                                                              ? Colors.red[700]
                                                              : Colors
                                                                  .green[700],
                                                      borderRadius:
                                                          const BorderRadius
                                                              .all(
                                                              Radius.circular(
                                                                  5))),
                                                  child: Center(
                                                    child: Text(
                                                      "${viewModel.requisitions[index].status![0].toUpperCase()}${viewModel.requisitions[index].status!.substring(1).toLowerCase()}",
                                                      style: const TextStyle(
                                                          fontSize: 11,
                                                          color: Colors.white),
                                                    ),
                                                  ))),
                                        ),
                                        Expanded(
                                          child: Center(
                                            child: Text(
                                              DateFormat.yMMMd().format(
                                                  viewModel.requisitions[index]
                                                      .dateAdded!),
                                              style: const TextStyle(
                                                  color:
                                                      AppColors.crudTextColor),
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          child: Center(
                                              child: Material(
                                            elevation: 2,
                                            borderRadius:
                                                const BorderRadius.all(
                                                    Radius.circular(5)),
                                            child: InkWell(
                                              child: Container(
                                                width: 30,
                                                height: 30,
                                                decoration: const BoxDecoration(
                                                  color: AppColors.primaryColor,
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(5)),
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
                                                viewModel.viewRequisitionDetail(
                                                    viewModel
                                                        .requisitions[index]);
                                                //viewModel.editProduct(index);
                                              },
                                            ),
                                          )),
                                        ),
                                      ],
                                    ),
                                  );
                                }),
                            const SizedBox(height: 20),
                            PaginationWidget(
                              currentPage: viewModel.currentPage,
                              totalPages: viewModel.totalPages,
                              onPageChanged: (a) {
                                viewModel.changePage(a);
                              },
                            )
                          ],
                        ),
                        child: RecievedGoodsDetail(
                          onCloseTap: () {
                            viewModel.closeRequisitionDetail();
                          },
                          requisition: viewModel.selectedRequisition,
                        )),
                  ],
                ),
              ),
              child: const Center(
                child: SizedBox(
                  width: 30,
                  height: 30,
                  child: CircularProgressIndicator(
                    strokeWidth: 1,
                    color: AppColors.primaryColor,
                  ),
                ),
              ),
            )));
  }

  @override
  ReceivedGoodsViewModel viewModelBuilder(BuildContext context) =>
      ReceivedGoodsViewModel();
}
