import 'package:flutter/material.dart';
import 'package:shop_manager/ui/products/product.view.model.dart';
import 'package:stacked/stacked.dart';

class ProductView extends StackedView<ProductViewModel> {
  const ProductView({Key? key}) : super(key: key);

  @override
  bool get reactive => true;

  @override
  bool get disposeViewModel => true;

  @override
  void onViewModelReady(ProductViewModel viewModel) async {
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
        child: Text("Procucts"),
      ),
    ));
  }

  @override
  ProductViewModel viewModelBuilder(BuildContext context) => ProductViewModel();
}
