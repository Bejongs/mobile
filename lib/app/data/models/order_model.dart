class OrderModel {
  final String id;
  final String userId;
  final int total;
  final String createdAt;

  OrderModel({
    required this.id,
    required this.userId,
    required this.total,
    required this.createdAt,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return OrderModel(
      id: json['id'],
      userId: json['user_id'],
      total: json['total'],        // ← FIXED
      createdAt: json['created_at'],
    );
  }
}
