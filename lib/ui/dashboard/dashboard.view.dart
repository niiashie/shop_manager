import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shop_manager/app/locator.dart';
import 'package:shop_manager/constants/assets.dart';
import 'package:shop_manager/constants/colors.dart';
import 'package:shop_manager/constants/fonts.dart';
import 'package:shop_manager/models/branch.dart';
import 'package:shop_manager/services/app_service.dart';
import 'package:shop_manager/ui/branch/branch_view.dart';
import 'package:shop_manager/ui/customers/customers_view.dart';
import 'package:shop_manager/ui/dashboard/dashboard.view.model.dart';
import 'package:shop_manager/ui/home/home.view.dart';
import 'package:shop_manager/ui/products/product.view.dart';
import 'package:shop_manager/ui/profit/profit_view.dart';
import 'package:shop_manager/ui/received_goods/received_goods_view.dart';
import 'package:shop_manager/ui/requisition/requisition.view.dart';
import 'package:shop_manager/ui/shared/side_menu_item.dart';
import 'package:shop_manager/ui/shop/shop.view.dart';
import 'package:shop_manager/ui/stock/stock.view.dart';
import 'package:shop_manager/ui/unpaid_transactions/unpaid_transactions_view.dart';
import 'package:shop_manager/ui/users/user_view.dart';
import 'package:shop_manager/utils.dart';
import 'package:stacked/stacked.dart';

class DashBoardView extends StackedView<DashboardViewModel> {
  const DashBoardView({Key? key}) : super(key: key);

  @override
  bool get reactive => true;

  @override
  bool get disposeViewModel => true;

  @override
  void onViewModelReady(DashboardViewModel viewModel) async {
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
      child: Stack(
        children: [
          Container(
            width: double.infinity,
            height: double.infinity,
            color: Colors.grey[300],
            child: Stack(
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: Container(
                      width: 250,
                      padding: const EdgeInsets.only(top: 5, bottom: 5),
                      //color: Colors.amber,
                      margin:
                          const EdgeInsets.only(top: 25, left: 15, right: 15),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.asset(
                            AppImages.stockGrowth,
                            width: 70,
                            height: 70,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          const Text(
                            "Stock Manager",
                            style: TextStyle(
                                fontFamily: AppFonts.poppinsMedium,
                                color: AppColors.crudTextColor),
                          ),
                          const SizedBox(
                            height: 50,
                          ),
                          SideMenuItem(
                              title: "Home",
                              icon: Icons.home,
                              selected: viewModel.homeSelected,
                              onTap: () {
                                viewModel.onSideMenuSelect("home");
                              },
                              onHover: (a) {}),
                          SideMenuItem(
                              title: "Shop",
                              selected: viewModel.shopSelceted,
                              icon: Icons.store,
                              onTap: () {
                                viewModel.onSideMenuSelect("shop");
                              },
                              onHover: (a) {}),
                          SideMenuItem(
                              title: "Products",
                              selected: viewModel.productSelected,
                              icon: Icons.local_grocery_store,
                              onTap: () {
                                viewModel.onSideMenuSelect("products");
                              },
                              onHover: (a) {}),
                          SideMenuItem(
                              title: "Transactions",
                              selected: viewModel.stockSelected,
                              icon: Icons.inventory,
                              onTap: () {
                                viewModel.onSideMenuSelect("stocks");
                              },
                              onHover: (a) {}),
                          SideMenuItem(
                              title: "Customers",
                              selected: viewModel.requisitionSelected,
                              icon: Icons.person,
                              onTap: () {
                                viewModel.onSideMenuSelect("customers");
                              },
                              onHover: (a) {}),
                          SideMenuItem(
                              title: "Received Goods",
                              selected: viewModel.receivedGoodsSelected,
                              icon: Icons.store,
                              onTap: () {
                                viewModel.onSideMenuSelect("receivedGoods");
                              },
                              onHover: (a) {}),
                          Visibility(
                              visible: viewModel.appService.user!.role ==
                                      "manager" ||
                                  viewModel.appService.user!.role == "admin",
                              child: SideMenuItem(
                                  title: "Profit Margins",
                                  selected: viewModel.profileSelected,
                                  icon: Icons.payments,
                                  onTap: () {
                                    viewModel.onSideMenuSelect("profile");
                                  },
                                  onHover: (a) {})),
                          SideMenuItem(
                              title: "Users",
                              selected: viewModel.usersSelected,
                              icon: Icons.person,
                              onTap: () {
                                viewModel.onSideMenuSelect("users");
                              },
                              onHover: (a) {}),
                          SideMenuItem(
                              title: "Branches",
                              selected: viewModel.branchSelected,
                              icon: Icons.timeline,
                              onTap: () {
                                viewModel.onSideMenuSelect("branches");
                              },
                              onHover: (a) {})
                        ],
                      )),
                ),
                Align(
                  alignment: Alignment.topRight,
                  child: Padding(
                    padding: const EdgeInsets.only(right: 20, top: 10),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.apartment,
                          size: 10,
                          color: AppColors.crudTextColor,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        SizedBox(
                            height: 40,
                            width: 130,
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton(
                                  dropdownColor: Colors.white,
                                  isExpanded: true,
                                  icon: Icon(
                                    Icons.expand_more,
                                    color: Colors.grey[600],
                                    size: 17,
                                  ),
                                  hint: const Text('All Branches',
                                      style: TextStyle(
                                          fontSize: 14, color: Colors.black38)),
                                  value: viewModel.selectedCompanyBranch,
                                  items: viewModel.branchNames
                                      .map((String branch) {
                                    return DropdownMenuItem<String>(
                                      value: branch,
                                      child: Text(
                                        branch,
                                        style: const TextStyle(fontSize: 12),
                                      ),
                                    );
                                  }).toList(),
                                  onChanged: (String? val) {
                                    Branch? branch = viewModel
                                        .appService.user!.branches!
                                        .where((branch) => branch.name == val!)
                                        .toList()
                                        .first;

                                    if (branch.id !=
                                        viewModel
                                            .appService.selectedBranch!.id) {
                                      viewModel.appService
                                          .branchChangeListenerController
                                          .add(branch.id.toString());
                                      viewModel.appService.selectedBranch =
                                          branch;

                                      viewModel.setSelectedCompanyBranch(val);
                                    }
                                  }),
                            )),

                        const SizedBox(
                          width: 10,
                        ),
                        const Icon(
                          Icons.calendar_month,
                          size: 10,
                          color: AppColors.crudTextColor,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          DateFormat.yMMMd().format(DateTime.now()),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        const Icon(
                          Icons.person,
                          size: 10,
                          color: AppColors.crudTextColor,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          locator<AppService>().user!.name!,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Material(
                          elevation: 2,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(15)),
                          color: Colors.transparent,
                          child: InkWell(
                            child: Container(
                              width: 30,
                              height: 30,
                              decoration: const BoxDecoration(
                                color: AppColors.primaryColor,
                                shape: BoxShape.circle,
                              ),
                              child: const Center(
                                child: Icon(
                                  Icons.logout,
                                  size: 12,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            onTap: () {
                              viewModel.logout();
                            },
                          ),
                        )
                        // CustomButton(
                        //   width: 100,
                        //   height: 30,
                        //   elevation: 2,
                        //   color: AppColors.primaryColor,
                        //   title: const Text(
                        //     "Logout",
                        //     style: TextStyle(color: Colors.white),
                        //   ),
                        //   ontap: () {
                        //     debugPrint("Logging out");
                        //   },
                        // )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
          Container(
            width: double.infinity,
            height: double.infinity,
            margin: const EdgeInsets.only(
                left: 280, top: 50, right: 20, bottom: 20),
            padding: const EdgeInsets.all(15),
            decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(15))),
            child: Navigator(
                key: Utils.sideMenuNavigationKey,
                initialRoute: '/',
                onGenerateRoute: ((settings) {
                  Widget page;
                  switch (settings.name) {
                    case '/':
                      page = const HomeView();
                      break;
                    case '/product':
                      page = const ProductView();
                      break;
                    case '/profit':
                      page = const ProfitView();
                      break;
                    case '/shop':
                      page = const ShopView();
                      break;
                    case '/requisition':
                      page = const RequisitionView();
                      break;
                    case '/customers':
                      page = const CustomerView();
                      break;
                    case '/receivedGoods':
                      page = const ReceivedGoodsView();
                      break;
                    case '/unpaidTransactions':
                      page = const UnpaidTransactionsView();
                      break;
                    case '/stocks':
                      page = const StockView();
                    case '/users':
                      page = const UsersView();
                    case '/branches':
                      page = const BranchView();
                    default:
                      page = const HomeView();
                      break;
                  }
                  return PageRouteBuilder(
                      pageBuilder: (context, animation, secondaryAnimation) =>
                          page,
                      transitionDuration: const Duration(seconds: 0));
                })),
          )
        ],
      ),
    ));
  }

  @override
  DashboardViewModel viewModelBuilder(BuildContext context) =>
      DashboardViewModel();
}
