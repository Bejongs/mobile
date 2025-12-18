class OrderModel {
  final String id;
  final DateTime createdAt;
  final int totalPrice;
  final List<OrderItemModel> items;

  OrderModel({
    required this.id,
    required this.createdAt,
    required this.totalPrice,
    required this.items,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return OrderModel(
      id: json['id'],
      createdAt: DateTime.parse(json['created_at']),
      totalPrice: json['total_price'],
      items: (json['items'] as List)
          .map((e) => OrderItemModel.fromJson(e))
          .toList(),
    );
  }
}

class OrderItemModel {
  final String menuId;
  final String menuName;
  final String imageUrl;
  final int price;
  final int quantity;

  OrderItemModel({
    required this.menuId,
    required this.menuName,
    required this.imageUrl,
    required this.price,
    required this.quantity,
  });

  factory OrderItemModel.fromJson(Map<String, dynamic> json) {
    return OrderItemModel(
      menuId: json['menu_id'],
      menuName: json['menu_name'],
      imageUrl: json['image_url'],
      price: json['price'],
      quantity: json['quantity'],
    );
  }
}
