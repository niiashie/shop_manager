import 'package:flutter/material.dart';
import 'package:shop_manager/ui/home/home.view.model.dart';
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
    debugPrint("Do something...");
  }

  @override
  Widget builder(BuildContext context, viewModel, Widget? child) {
    return const Scaffold(
        body: SizedBox(
      width: double.infinity,
      height: double.infinity,
      child: Center(
        child: Text("Home"),
      ),
    ));
  }

  @override
  HomeViewModel viewModelBuilder(BuildContext context) => HomeViewModel();
}
