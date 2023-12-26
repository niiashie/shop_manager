class Requisition {
  int? id;
  String? userId;
  String? description;
  double? total;
  String? status;
  DateTime? dateAdded;

  Requisition(
      {this.id,
      this.userId,
      this.description,
      this.total,
      this.status,
      this.dateAdded});

  Requisition.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    description = json['description'];
    total = double.parse(json['total'].toString());
    id = json['id'];
    status = json['status'];
    dateAdded = DateTime.parse(json['created_at']);
  }
}
