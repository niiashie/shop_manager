import 'package:shop_manager/models/product.dart';

class ReceivedGoods {
  int? id;
  int? quantity;
  Product? product;

  ReceivedGoods.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    quantity = int.parse(json['quantity']);
    product = Product.fromJson(json['product']);
  }
}
