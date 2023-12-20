import 'package:flutter/material.dart';
import 'package:shop_manager/constants/assets.dart';
import 'package:shop_manager/constants/colors.dart';
import 'package:shop_manager/constants/fonts.dart';
import 'package:shop_manager/ui/dashboard/dashboard.view.model.dart';
import 'package:shop_manager/ui/shared/side_menu_item.dart';
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
                      width: 220,
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
                              title: "Stocks",
                              selected: viewModel.stockSelected,
                              icon: Icons.inventory,
                              onTap: () {
                                viewModel.onSideMenuSelect("stocks");
                              },
                              onHover: (a) {}),
                          SideMenuItem(
                              title: "Profile",
                              selected: viewModel.profileSelected,
                              icon: Icons.person,
                              onTap: () {
                                viewModel.onSideMenuSelect("profile");
                              },
                              onHover: (a) {})
                        ],
                      )),
                )
              ],
            ),
          ),
          Container(
            width: double.infinity,
            height: double.infinity,
            margin: const EdgeInsets.only(left: 250, top: 50),
            decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  // bottomLeft: Radius.circular(20),
                )),
            child: Navigator(
                      key: Utils.sideMenuNavigationKey,
                      initialRoute: '/',
                      onGenerateRoute: ((settings) {
                        Widget page;
                        switch (settings.name) {
                          case '/':
                            page = HomeView(
                              totalBooks: totalBooks,
                              purchasedBooks: booksBought,
                              totalPosts: totalPosts,
                            );
                            break;
                          case '/books':
                            page = const MyBookView();
                            break;
                          case '/orders':
                            page = const OrdersView();
                            break;
                          case '/account':
                            page = const AccountView();
                            break;
                          case '/posts':
                            page = const ChurchPostView();
                          default:
                            page = HomeView(
                              totalBooks: totalBooks,
                              purchasedBooks: booksBought,
                              totalPosts: totalPosts,
                            );
                            break;
                        }
                        return PageRouteBuilder(
                            pageBuilder:
                                (context, animation, secondaryAnimation) =>
                                    page,
                            transitionDuration: const Duration(seconds: 0));
                      })),,    
          )
        ],
      ),
    ));
  }

  @override
  DashboardViewModel viewModelBuilder(BuildContext context) =>
      DashboardViewModel();
}
