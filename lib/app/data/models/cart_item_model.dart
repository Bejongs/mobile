import 'package:hive/hive.dart';

part 'cart_item_model.g.dart';

@HiveType(typeId: 1)
class CartItemModel extends HiveObject {
  @HiveField(0)
  String menuId;

  @HiveField(1)
  String menuName;

  @HiveField(2)
  int quantity;

  @HiveField(3)
  int price;

  CartItemModel({
    required this.menuId,
    required this.menuName,
    required this.quantity,
    required this.price,
  });

  int get totalPrice => quantity * price;

  Map<String, dynamic> toJson() => {
        'menuId': menuId,
        'menuName': menuName,
        'quantity': quantity,
        'price': price,
      };

  factory CartItemModel.fromJson(Map<String, dynamic> json) => CartItemModel(
        menuId: json['menuId'] as String,
        menuName: json['menuName'] as String,
        quantity: json['quantity'] as int,
        price: json['price'] as int,
      );
}
