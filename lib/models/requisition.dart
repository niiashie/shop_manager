import 'package:shop_manager/models/received_goods.dart';
import 'package:shop_manager/models/user.dart';

class Requisition {
  int? id;
  String? userId;
  String? description;
  double? total;
  String? status;
  User? user;
  DateTime? dateAdded;
  List<ReceivedGoods>? receivedGoods;

  Requisition(
      {this.id,
      this.userId,
      this.description,
      this.total,
      this.status,
      this.dateAdded});

  Requisition.fromJson(Map<String, dynamic> json) {
    List<ReceivedGoods> goods = [];
    if (json['received_goods'] != null) {
      for (int i = 0; i < json['received_goods'].length; i++) {
        goods.add(ReceivedGoods.fromJson(json['received_goods'][i]));
      }
    }

    userId = json['user_id'];
    description = json['description'];
    total = double.parse(json['total'].toString());
    id = json['id'];
    status = json['status'];
    dateAdded = DateTime.parse(json['created_at']);
    user = json['user'] != null
        ? User.fromJson(json['user'], isLogin: false)
        : null;
    receivedGoods = goods;
  }

  List<Requisition> addAll(List<dynamic> requisitions) {
    List<Requisition> requisitionsResult = [];
    for (int j = 0; j < requisitions.length; j++) {
      requisitionsResult.add(Requisition.fromJson(requisitions[j]));
    }
    return requisitionsResult;
  }
}
