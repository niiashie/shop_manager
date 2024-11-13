class Branch {
  int? id;
  String? address;
  String? name;
  String? phone;

  Branch({this.id, this.address, this.name, this.phone});

  Branch.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    address = json['address'];
    phone = json['phone'];
  }
}
