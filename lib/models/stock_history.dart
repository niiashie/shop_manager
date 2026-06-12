class StockHistoryUser {
  final int id;
  final String name;
  final String phone;
  final String role;

  StockHistoryUser({
    required this.id,
    required this.name,
    required this.phone,
    required this.role,
  });

  factory StockHistoryUser.fromJson(Map<String, dynamic> json) {
    return StockHistoryUser(
      id: json['id'],
      name: json['name'] ?? '',
      phone: json['phone'] ?? '',
      role: json['role'] ?? '',
    );
  }
}

class StockHistory {
  final String type;
  final int quantityChange;
  final int quantityBefore;
  final int quantityAfter;
  final int? referenceId;
  final StockHistoryUser user;
  final DateTime createdAt;

  StockHistory({
    required this.type,
    required this.quantityChange,
    required this.quantityBefore,
    required this.quantityAfter,
    this.referenceId,
    required this.user,
    required this.createdAt,
  });

  factory StockHistory.fromJson(Map<String, dynamic> json) {
    return StockHistory(
      type: json['type'] ?? '',
      quantityChange: json['quantity_change'] ?? 0,
      quantityBefore: json['quantity_before'] ?? 0,
      quantityAfter: json['quantity_after'] ?? 0,
      referenceId: json['reference_id'],
      user: StockHistoryUser.fromJson(json['user']),
      createdAt: DateTime.parse(json['created_at']),
    );
  }
}
