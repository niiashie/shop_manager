import 'package:shop_manager/models/product.dart';

class TransactionProduct {
  int? id;
  int? quantity;
  double? amount;
  double? unitPrice;
  Product? product;

  TransactionProduct({
    this.id,
    this.quantity,
    this.amount,
    this.unitPrice,
    this.product,
  });

  TransactionProduct.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    quantity = json['quantity'];
    unitPrice = double.parse(json['unit_price'].toString());
    amount = double.parse(json['amount'].toString());
    product = Product.fromJson(json['product']);
  }
}
