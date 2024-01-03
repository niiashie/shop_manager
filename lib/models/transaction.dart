import 'package:shop_manager/models/transaction_product.dart';
import 'package:shop_manager/models/user.dart';

class Transaction {
  int? id;
  String? customer;
  double? total;
  User? user;
  DateTime? dateAdded;
  List<TransactionProduct>? transactionProducts;

  Transaction(
      {this.id,
      this.customer,
      this.total,
      this.user,
      this.dateAdded,
      this.transactionProducts});

  Transaction.fromJson(Map<String, dynamic> json) {
    List<TransactionProduct> products2 = [];
    List<dynamic> products = json['transaction_product'];
    for (var obj in products) {
      products2.add(TransactionProduct.fromJson(obj));
    }

    id = json['id'];
    customer = json['customer'];
    total = double.parse(json['total'].toString());
    dateAdded = DateTime.parse(json['created_at']);
    user = User.fromJson(json['user'], isLogin: false);
    transactionProducts = products2;
  }
}
