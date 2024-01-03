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

  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    quantity = json['quantity'];
    location = json['location'];
    costPrice = double.parse(json['cost_price'].toString());
    sellingPrice = double.parse(json['selling_price'].toString());
    dateAdded = DateTime.parse(json['created_at']);
  }
}
