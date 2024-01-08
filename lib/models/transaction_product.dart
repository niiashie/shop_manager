import 'package:shop_manager/models/product.dart';

class TransactionProduct {
  int? id;
  int? quantity;
  double? amount;
  double? unitPrice;
  double? costPrice;
  Product? product;

  TransactionProduct({
    this.id,
    this.quantity,
    this.amount,
    this.unitPrice,
    this.costPrice,
    this.product,
  });

  TransactionProduct.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    quantity = int.parse(json['quantity'].toString());
    unitPrice = double.parse(json['unit_price_as_at_purchase'].toString());
    costPrice = double.parse(json['cost_price_as_at_purchase'].toString());
    amount = double.parse(json['amount'].toString());
    product = Product.fromJson(json['product']);
  }
}
