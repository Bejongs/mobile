class CartItemModel {
  final String menuId;
  final String menuName;
  final String imageUrl;
  final int price;
  int qty;

  CartItemModel({
    required this.menuId,
    required this.menuName,
    required this.imageUrl,
    required this.price,
    this.qty = 1,
  });

  int get total => price * qty;
}
