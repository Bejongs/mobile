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
