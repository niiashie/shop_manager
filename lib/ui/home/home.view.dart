import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:shop_manager/constants/colors.dart';
import 'package:shop_manager/constants/fonts.dart';
import 'package:shop_manager/ui/home/home.view.model.dart';
import 'package:shop_manager/ui/home/widget/home_item.dart';
import 'package:stacked/stacked.dart';

class HomeView extends StackedView<HomeViewModel> {
  const HomeView({Key? key}) : super(key: key);

  @override
  bool get reactive => true;

  @override
  bool get disposeViewModel => true;

  @override
  void onViewModelReady(HomeViewModel viewModel) async {
    super.onViewModelReady(viewModel);
    viewModel.init();
    debugPrint("Do something...");
  }

  @override
  Widget builder(BuildContext context, viewModel, Widget? child) {
    return Scaffold(
        body: Container(
            width: double.infinity,
            height: double.infinity,
            color: Colors.white,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    width: double.infinity,
                    margin: const EdgeInsets.only(left: 10, right: 10),
                    height: 50,
                    child: const Stack(
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Home",
                            style: TextStyle(
                                fontFamily: AppFonts.poppinsBold, fontSize: 22),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Visibility(
                      visible: viewModel.isLoading,
                      replacement: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            width: double.infinity,
                            height: 130,
                            margin: const EdgeInsets.only(left: 20, right: 20),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Expanded(
                                  child: HomeItem(
                                    title: "Products Registered",
                                    value: viewModel.registeredProducts,
                                  ),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Expanded(
                                  child: HomeItem(
                                    title: "Products Value",
                                    value: "GHS ${viewModel.productsValue}",
                                  ),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Expanded(
                                    child: HomeItem(
                                  title: "Sales Today",
                                  value: "GHS ${viewModel.salesToday}",
                                )),
                                const SizedBox(
                                  width: 10,
                                ),
                                Expanded(
                                    child: HomeItem(
                                  title: "Unpaid Sales",
                                  value: viewModel.unpaidSales,
                                )),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Container(
                            width: double.infinity,
                            padding: const EdgeInsets.only(top: 5, bottom: 5),
                            margin: const EdgeInsets.only(left: 20, right: 20),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Material(
                                  elevation: 2,
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(10)),
                                  child: Container(
                                    width: 400,
                                    padding: const EdgeInsets.only(
                                        top: 10, bottom: 15),
                                    decoration: const BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10))),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const SizedBox(
                                          height: 20,
                                        ),
                                        const Padding(
                                          padding: EdgeInsets.only(left: 15),
                                          child: Text(
                                            "Low Stock Products",
                                            style: TextStyle(
                                                fontFamily:
                                                    AppFonts.poppinsMedium),
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        Container(
                                          width: double.infinity,
                                          height: 40,
                                          color: AppColors.primaryColor,
                                          child: const Row(
                                            mainAxisSize: MainAxisSize.max,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              SizedBox(
                                                width: 180,
                                                child: Align(
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  child: Padding(
                                                    padding: EdgeInsets.only(
                                                        left: 15),
                                                    child: Text(
                                                      "Product",
                                                      style: TextStyle(
                                                          color: Colors.white),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Expanded(
                                                child: Center(
                                                  child: Text(
                                                    "Unit Price",
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
                                              )
                                            ],
                                          ),
                                        ),
                                        ListView.builder(
                                            itemCount:
                                                viewModel.products.length,
                                            physics:
                                                const NeverScrollableScrollPhysics(),
                                            shrinkWrap: true,
                                            itemBuilder: (context, index) {
                                              return Container(
                                                width: double.infinity,
                                                height: 40,
                                                color: index % 2 == 0
                                                    ? Colors.white
                                                    : Colors.grey[100],
                                                child: Row(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  children: [
                                                    SizedBox(
                                                      width: 180,
                                                      child: Align(
                                                        alignment: Alignment
                                                            .centerLeft,
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .only(
                                                                  left: 15),
                                                          child: Text(
                                                            viewModel
                                                                .products[index]
                                                                .name!,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    Expanded(
                                                      child: Center(
                                                        child: Text(
                                                          viewModel
                                                              .products[index]
                                                              .sellingPrice
                                                              .toString(),
                                                        ),
                                                      ),
                                                    ),
                                                    Expanded(
                                                      child: Center(
                                                        child: Text(
                                                          viewModel
                                                              .products[index]
                                                              .quantity
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
                                  ),
                                ),
                                const SizedBox(
                                  width: 15,
                                ),
                                Expanded(
                                  child: Material(
                                    elevation: 2,
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(10)),
                                    child: Container(
                                        width: double.infinity,
                                        padding: const EdgeInsets.all(10),
                                        height: 400,
                                        decoration: const BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(10))),
                                        child: Stack(
                                          children: [
                                            Container(
                                              width: double.infinity,
                                              height: double.infinity,
                                              margin: const EdgeInsets.all(20),
                                              child: BarChart(
                                                duration:
                                                    const Duration(
                                                        milliseconds: 1800),
                                                BarChartData(
                                                  barGroups: viewModel
                                                          .daySales.isNotEmpty
                                                      ? viewModel.daySales
                                                          .reversed
                                                          .toList()
                                                          .asMap()
                                                          .entries
                                                          .map((e) =>
                                                              BarChartGroupData(
                                                                x: e.key,
                                                                barRods: [
                                                                  BarChartRodData(
                                                                    toY:
                                                                        e.value,
                                                                    color: AppColors
                                                                        .primaryColor,
                                                                    width: 40,
                                                                    borderRadius: const BorderRadius.vertical(
                                                                        top: Radius.circular(
                                                                            4)),
                                                                  ),
                                                                ],
                                                              ))
                                                          .toList()
                                                      : [],
                                                  groupsSpace: 15,
                                                  titlesData: FlTitlesData(
                                                    bottomTitles: AxisTitles(
                                                      sideTitles: SideTitles(
                                                        showTitles: true,
                                                        reservedSize: 28,
                                                        getTitlesWidget:
                                                            (value, meta) {
                                                          final labels = viewModel
                                                                  .days
                                                                  .isNotEmpty
                                                              ? viewModel.days
                                                                  .reversed
                                                                  .toList()
                                                              : <String>[];
                                                          final idx =
                                                              value.toInt();
                                                          if (idx >= 0 &&
                                                              idx <
                                                                  labels
                                                                      .length) {
                                                            return SideTitleWidget(
                                                              axisSide: meta
                                                                  .axisSide,
                                                              child: Text(
                                                                  labels[idx],
                                                                  style: const TextStyle(
                                                                      fontSize:
                                                                          11)),
                                                            );
                                                          }
                                                          return const SizedBox
                                                              .shrink();
                                                        },
                                                      ),
                                                    ),
                                                    topTitles: const AxisTitles(
                                                        sideTitles: SideTitles(
                                                            showTitles: false)),
                                                    rightTitles:
                                                        const AxisTitles(
                                                            sideTitles:
                                                                SideTitles(
                                                                    showTitles:
                                                                        false)),
                                                    leftTitles: AxisTitles(
                                                      sideTitles: SideTitles(
                                                        showTitles: true,
                                                        reservedSize: 40,
                                                        getTitlesWidget:
                                                            (value, meta) =>
                                                                Text(
                                                          value
                                                              .toStringAsFixed(
                                                                  0),
                                                          style: const TextStyle(
                                                              fontSize: 11),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  borderData:
                                                      FlBorderData(show: false),
                                                  gridData: const FlGridData(
                                                      show: true),
                                                ),
                                              ),
                                            ),
                                            const Align(
                                              alignment: Alignment.bottomCenter,
                                              child: Text(
                                                "Days Vrs Sales",
                                                style: TextStyle(fontSize: 13),
                                              ),
                                            )
                                          ],
                                        )),
                                  ),
                                )
                              ],
                            ),
                          ),
                          const SizedBox(height: 20),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Top Selling Products
                              Expanded(
                                child: Material(
                                  elevation: 2,
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(10)),
                                  child: Container(
                                    width: double.infinity,
                                    padding: const EdgeInsets.all(10),
                                    height: 400,
                                    decoration: const BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10))),
                                    child: Stack(
                                      children: [
                                        Container(
                                          width: double.infinity,
                                          height: double.infinity,
                                          margin: const EdgeInsets.only(
                                              left: 20,
                                              right: 20,
                                              top: 20,
                                              bottom: 30),
                                          child: BarChart(
                                            duration: const Duration(
                                                milliseconds: 1800),
                                            BarChartData(
                                              barGroups: viewModel
                                                      .topProductUnits
                                                      .isNotEmpty
                                                  ? viewModel.topProductUnits
                                                      .asMap()
                                                      .entries
                                                      .map((e) =>
                                                          BarChartGroupData(
                                                            x: e.key,
                                                            barRods: [
                                                              BarChartRodData(
                                                                toY: e.value,
                                                                color: AppColors
                                                                    .primaryColor,
                                                                width: 40,
                                                                borderRadius: const BorderRadius
                                                                    .vertical(
                                                                    top: Radius
                                                                        .circular(
                                                                            4)),
                                                              ),
                                                            ],
                                                          ))
                                                      .toList()
                                                  : [],
                                              groupsSpace: 15,
                                              titlesData: FlTitlesData(
                                                bottomTitles: AxisTitles(
                                                  sideTitles: SideTitles(
                                                    showTitles: true,
                                                    reservedSize: 36,
                                                    getTitlesWidget:
                                                        (value, meta) {
                                                      final idx =
                                                          value.toInt();
                                                      if (idx >= 0 &&
                                                          idx <
                                                              viewModel
                                                                  .topProductNames
                                                                  .length) {
                                                        return SideTitleWidget(
                                                          axisSide:
                                                              meta.axisSide,
                                                          child: Text(
                                                            viewModel
                                                                .topProductNames[
                                                                    idx],
                                                            style: const TextStyle(
                                                                fontSize: 10),
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                          ),
                                                        );
                                                      }
                                                      return const SizedBox
                                                          .shrink();
                                                    },
                                                  ),
                                                ),
                                                topTitles: const AxisTitles(
                                                    sideTitles: SideTitles(
                                                        showTitles: false)),
                                                rightTitles: const AxisTitles(
                                                    sideTitles: SideTitles(
                                                        showTitles: false)),
                                                leftTitles: AxisTitles(
                                                  sideTitles: SideTitles(
                                                    showTitles: true,
                                                    reservedSize: 40,
                                                    getTitlesWidget:
                                                        (value, meta) => Text(
                                                      value.toStringAsFixed(0),
                                                      style: const TextStyle(
                                                          fontSize: 11),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              borderData:
                                                  FlBorderData(show: false),
                                              gridData: const FlGridData(
                                                  show: true),
                                            ),
                                          ),
                                        ),
                                        const Align(
                                          alignment: Alignment.bottomCenter,
                                          child: Text(
                                            "Top Selling Products",
                                            style: TextStyle(fontSize: 13),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 15),
                              // Cash vs Credit Donut
                              SizedBox(
                                width: 400,
                                child: Material(
                                  elevation: 2,
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(10)),
                                  child: Container(
                                    padding: const EdgeInsets.all(10),
                                    height: 400,
                                    decoration: const BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10))),
                                    child: Stack(
                                      children: [
                                        const Align(
                                          alignment: Alignment.topLeft,
                                          child: Padding(
                                            padding: EdgeInsets.only(
                                                left: 10, top: 8),
                                            child: Text(
                                              "Sales by Type",
                                              style: TextStyle(fontSize: 13),
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              top: 30, bottom: 40),
                                          child: PieChart(
                                            PieChartData(
                                              centerSpaceRadius: 60,
                                              sectionsSpace: 3,
                                              sections: [
                                                PieChartSectionData(
                                                  value: viewModel.cashCount
                                                      .toDouble(),
                                                  color: AppColors.arrowUpColor,
                                                  title:
                                                      '${viewModel.cashCount}',
                                                  radius: 80,
                                                  titleStyle: const TextStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 14),
                                                ),
                                                PieChartSectionData(
                                                  value: viewModel.creditCount
                                                      .toDouble(),
                                                  color:
                                                      AppColors.soldAssetsColor,
                                                  title:
                                                      '${viewModel.creditCount}',
                                                  radius: 80,
                                                  titleStyle: const TextStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 14),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        Align(
                                          alignment: Alignment.bottomCenter,
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                bottom: 12),
                                            child: Row(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                Container(
                                                    width: 12,
                                                    height: 12,
                                                    decoration:
                                                        const BoxDecoration(
                                                            color: AppColors
                                                                .arrowUpColor,
                                                            shape:
                                                                BoxShape.circle)),
                                                const SizedBox(width: 6),
                                                const Text("Cash",
                                                    style:
                                                        TextStyle(fontSize: 12)),
                                                const SizedBox(width: 20),
                                                Container(
                                                    width: 12,
                                                    height: 12,
                                                    decoration:
                                                        const BoxDecoration(
                                                            color: AppColors
                                                                .soldAssetsColor,
                                                            shape:
                                                                BoxShape.circle)),
                                                const SizedBox(width: 6),
                                                const Text("Credit",
                                                    style:
                                                        TextStyle(fontSize: 12)),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      child: const SizedBox(
                        width: double.infinity,
                        height: 400,
                        child: Center(
                          child: SizedBox(
                            width: 25,
                            height: 25,
                            child: CircularProgressIndicator(
                              color: AppColors.primaryColor,
                              strokeWidth: 1,
                            ),
                          ),
                        ),
                      ))
                ],
              ),
            )));
  }

  @override
  HomeViewModel viewModelBuilder(BuildContext context) => HomeViewModel();
}
