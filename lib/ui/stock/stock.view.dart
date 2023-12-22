import 'package:flutter/material.dart';
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
    debugPrint("Do something...");
  }

  @override
  Widget builder(BuildContext context, viewModel, Widget? child) {
    return const Scaffold(
        body: SizedBox(
      width: double.infinity,
      height: double.infinity,
      child: Center(
        child: Text("Profile"),
      ),
    ));
  }

  @override
  StockViewModel viewModelBuilder(BuildContext context) => StockViewModel();
}
