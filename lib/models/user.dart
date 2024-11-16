import 'package:shop_manager/models/branch.dart';

class User {
  int? id;
  String? name;
  String? pin;
  String? role;
  String? phone;
  String? access;
  String? token;
  List<Branch>? branches;

  User({
    this.id,
    this.name,
    this.pin,
    this.role,
    this.access,
    this.phone,
    this.branches,
    this.token,
  });

  User.fromJson(Map<String, dynamic> json, {bool isLogin = true}) {
    if (isLogin) {
      name = json['user']['name'];
      pin = json['user']['pin'];
      role = json['user']['role'];
      id = json['user']['id'];
      phone = json['user']['phone'];
      access = json['user']['access'];
      branches = getBranches(json['user']['branch']);
      token = json['token'];
    } else {
      name = json['name'];
      pin = json['pin'];
      role = json['role'];
      id = json['id'];
      phone = json['phone'];
      branches = getBranches(json['branch']);
      access = json['access'];
      token = "";
    }
  }

  getBranches(List<dynamic> branches) {
    List<Branch> branchList = [];
    for (var obj in branches) {
      branchList.add(Branch.fromJson(obj));
    }
    return branchList;
  }
}
