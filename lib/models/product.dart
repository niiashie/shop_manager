class Product {
  int? id;
  String? name;
  double? costPrice;
  double? sellingPrice;
  DateTime? dateAdded;
  Product(
      {this.id, this.name, this.costPrice, this.sellingPrice, this.dateAdded});

  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    costPrice = double.parse(json['cost_price'].toString());
    sellingPrice = double.parse(json['selling_price'].toString());
    dateAdded = DateTime.parse(json['created_at']);
  }
}
