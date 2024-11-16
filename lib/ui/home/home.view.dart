import 'package:chart_components/bar_chart_component.dart';
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
    viewModel.getDashboardValues();
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
                                                data: viewModel.daySales,
                                                getColor: (a) {
                                                  return AppColors.primaryColor;
                                                },
                                                labels: viewModel.days,
                                                labelStyle: const TextStyle(
                                                  fontSize: 11,
                                                ),
                                                barWidth: 70,
                                                barSeparation: 15,
                                                animationDuration:
                                                    const Duration(
                                                        milliseconds: 1800),
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
                          )
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
