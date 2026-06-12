import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shop_manager/constants/colors.dart';
import 'package:shop_manager/models/product.dart';
import 'package:shop_manager/models/stock_history.dart';
import 'package:shop_manager/ui/products/product_history/product_history.view.model.dart';
import 'package:shop_manager/ui/shared/pagination.dart';
import 'package:stacked/stacked.dart';

class ProductHistoryView extends StackedView<ProductHistoryViewModel> {
  final Product product;

  const ProductHistoryView({Key? key, required this.product}) : super(key: key);

  @override
  bool get reactive => true;

  @override
  void onViewModelReady(ProductHistoryViewModel viewModel) {
    viewModel.init();
  }

  @override
  ProductHistoryViewModel viewModelBuilder(BuildContext context) =>
      ProductHistoryViewModel(product: product);

  @override
  Widget builder(
      BuildContext context, ProductHistoryViewModel viewModel, Widget? child) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Header
        Row(
          children: [
            InkWell(
              borderRadius: BorderRadius.circular(8),
              onTap: () => Navigator.of(context).pop(),
              child: const Padding(
                padding: EdgeInsets.all(6),
                child: Icon(Icons.arrow_back_ios_new,
                    size: 16, color: AppColors.primaryColor),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                "Stock History — ${product.name}",
                style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: AppColors.crudTextColor),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),

        // Current stock summary card
        if (viewModel.currentStock != null) _CurrentStockCard(viewModel),

        const SizedBox(height: 16),

        // Table header
        Container(
          width: double.infinity,
          height: 40,
          margin: const EdgeInsets.only(left: 20, right: 20),
          decoration: const BoxDecoration(
            color: AppColors.primaryColor,
            borderRadius: BorderRadius.all(Radius.circular(5)),
          ),
          child: const Row(
            children: [
              _HeaderCell("Type", flex: 2),
              _HeaderCell("Change"),
              _HeaderCell("Before"),
              _HeaderCell("After"),
              _HeaderCell("Ref #"),
              _HeaderCell("User", flex: 2),
              _HeaderCell("Role"),
              _HeaderCell("Date & Time", flex: 3),
            ],
          ),
        ),

        // Table body
        Expanded(
          child: viewModel.loading
              ? const Center(child: CircularProgressIndicator())
              : viewModel.history.isEmpty
                  ? const Center(
                      child: Text("No history found",
                          style: TextStyle(color: AppColors.crudTextColor)))
                  : SingleChildScrollView(
                      child: Column(
                        children: [
                          ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: viewModel.history.length,
                            itemBuilder: (context, index) {
                              return _HistoryRow(
                                  record: viewModel.history[index],
                                  index: index);
                            },
                          ),
                        ],
                      ),
                    ),
        ),

        // Pagination
        if (!viewModel.loading && viewModel.totalPages > 1)
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: PaginationWidget(
              currentPage: viewModel.currentPage,
              totalPages: viewModel.totalPages,
              onPageChanged: (page) => viewModel.changePage(page),
            ),
          ),
      ],
    );
  }
}

class _CurrentStockCard extends StatelessWidget {
  final ProductHistoryViewModel viewModel;
  const _CurrentStockCard(this.viewModel);

  @override
  Widget build(BuildContext context) {
    final stock = viewModel.currentStock!;
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
      decoration: BoxDecoration(
        color: AppColors.primaryColor.withValues(alpha: 0.07),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
            color: AppColors.primaryColor.withValues(alpha: 0.2)),
      ),
      child: Row(
        children: [
          _StockStat(
              label: "Current Stock",
              value: "${stock['quantity']} units",
              icon: Icons.inventory_2_outlined),
          const SizedBox(width: 30),
          _StockStat(
              label: "Selling Price",
              value: "GHS ${stock['selling_price']}",
              icon: Icons.sell_outlined),
          const SizedBox(width: 30),
          _StockStat(
              label: "Stock Value",
              value: "GHS ${stock['value']}",
              icon: Icons.account_balance_wallet_outlined),
        ],
      ),
    );
  }
}

class _StockStat extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;

  const _StockStat(
      {required this.label, required this.value, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 18, color: AppColors.primaryColor),
        const SizedBox(width: 8),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(label,
                style: const TextStyle(
                    fontSize: 11, color: AppColors.crudTextColor)),
            Text(value,
                style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: AppColors.crudTextColor)),
          ],
        )
      ],
    );
  }
}

class _HeaderCell extends StatelessWidget {
  final String text;
  final int flex;

  const _HeaderCell(this.text, {this.flex = 1});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: flex,
      child: Center(
        child: Text(text,
            style: const TextStyle(
                color: Colors.white,
                fontSize: 12,
                fontWeight: FontWeight.w500)),
      ),
    );
  }
}

class _HistoryRow extends StatelessWidget {
  final StockHistory record;
  final int index;

  const _HistoryRow({required this.record, required this.index});

  @override
  Widget build(BuildContext context) {
    final isStockOut = record.type == 'stock_out';
    final rowColor = index % 2 == 0 ? Colors.white : Colors.grey[100]!;
    final changeColor =
        isStockOut ? AppColors.soldAssetsColor : AppColors.arrowUpColor;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 10),
      margin: const EdgeInsets.only(left: 20, right: 20),
      color: rowColor,
      child: Row(
        children: [
          // Type chip
          Expanded(
            flex: 2,
            child: Center(
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: (isStockOut
                          ? AppColors.soldAssetsColor
                          : AppColors.arrowUpColor)
                      .withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  isStockOut ? "Stock Out" : "Stock In",
                  style: TextStyle(
                      fontSize: 11,
                      color: isStockOut
                          ? AppColors.soldAssetsColor
                          : AppColors.arrowUpColor,
                      fontWeight: FontWeight.w600),
                ),
              ),
            ),
          ),

          // Qty change
          Expanded(
            child: Center(
              child: Text(
                record.quantityChange > 0
                    ? "+${record.quantityChange}"
                    : "${record.quantityChange}",
                style: TextStyle(
                    color: changeColor,
                    fontWeight: FontWeight.w600,
                    fontSize: 13),
              ),
            ),
          ),

          // Before
          Expanded(
            child: Center(
              child: Text("${record.quantityBefore}",
                  style: const TextStyle(
                      color: AppColors.crudTextColor, fontSize: 13)),
            ),
          ),

          // After
          Expanded(
            child: Center(
              child: Text("${record.quantityAfter}",
                  style: const TextStyle(
                      color: AppColors.crudTextColor, fontSize: 13)),
            ),
          ),

          // Reference ID
          Expanded(
            child: Center(
              child: Text(
                record.referenceId != null ? "#${record.referenceId}" : "—",
                style: const TextStyle(
                    color: AppColors.crudTextColor, fontSize: 13),
              ),
            ),
          ),

          // User name + tooltip with full details
          Expanded(
            flex: 2,
            child: Center(
              child: Tooltip(
                message:
                    "Phone: ${record.user.phone}\nRole: ${record.user.role}",
                child: Text(
                  record.user.name,
                  style: const TextStyle(
                      color: AppColors.primaryColor,
                      fontSize: 13,
                      fontWeight: FontWeight.w500),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
          ),

          // Role badge
          Expanded(
            child: Center(
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
                decoration: BoxDecoration(
                  color: AppColors.leasedAssetsColor.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  record.user.role,
                  style: const TextStyle(
                      fontSize: 10,
                      color: AppColors.leasedAssetsColor,
                      fontWeight: FontWeight.w600),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
          ),

          // Date & Time
          Expanded(
            flex: 3,
            child: Center(
              child: Text(
                DateFormat("dd MMM yyyy, hh:mm a").format(
                    record.createdAt.toLocal()),
                style: const TextStyle(
                    color: AppColors.crudTextColor, fontSize: 12),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
