class Customer {
  int? id;
  String? name;
  String? phone;
  String? location;
  double? debt;

  Customer({this.id, this.location, this.name, this.phone, this.debt});

  Customer.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    location = json['location'];
    phone = json['phone'];
    debt = double.parse(json['debt'].toString());
  }

  @override
  String toString() {
    return name!;
  }
}
