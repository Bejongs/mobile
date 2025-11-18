import 'package:flutter/material.dart';
import 'package:demo_modul4/app/data/models/cart_item_model.dart';

class CartItemCard extends StatelessWidget {
  final CartItemModel item;
  final VoidCallback? onRemove;
  final VoidCallback? onIncrement;
  final VoidCallback? onDecrement;

  const CartItemCard({
    Key? key,
    required this.item,
    this.onRemove,
    this.onIncrement,
    this.onDecrement,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      child: ListTile(
        leading: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(onPressed: onDecrement, icon: const Icon(Icons.remove)),
            Text('${item.quantity}'),
            IconButton(onPressed: onIncrement, icon: const Icon(Icons.add)),
          ],
        ),
        title: Text(item.menuName),
        subtitle: Text('Rp ${item.price} • Subtotal: Rp ${item.totalPrice}'),
        trailing: IconButton(onPressed: onRemove, icon: const Icon(Icons.delete)),
      ),
    );
  }
}
