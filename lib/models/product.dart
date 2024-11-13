class Product {
  int? id;
  String? name;
  double? costPrice;
  double? sellingPrice;
  int? quantity;
  String? location;
  DateTime? dateAdded;
  Product(
      {this.id,
      this.name,
      this.costPrice,
      this.quantity,
      this.sellingPrice,
      this.location,
      this.dateAdded});

  @override
  String toString() {
    return name!;
  }

  Product.fromJson(Map<String, dynamic> json, {String type = ""}) {
    id = json['id'];
    name = json['name'];
    quantity =
        json['quantity'] == null ? 0 : int.parse(json['quantity'].toString());
    location = json['location'];
    costPrice = double.parse(json['cost_price'].toString());
    sellingPrice = type.isEmpty
        ? json['selling_price'] == null
            ? 0
            : double.parse(json['selling_price'].toString())
        : type == "received"
            ? double.parse(
                json['branch'][0]['pivot']['selling_price'].toString())
            : 0;
    dateAdded = DateTime.parse(json['created_at']);
  }
}
