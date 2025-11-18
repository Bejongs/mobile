import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class PriceText extends StatelessWidget {
  final int price;
  final TextStyle? style;

  PriceText(this.price, {Key? key, this.style}) : super(key: key);

  String _format(int value) {
    final formatter = NumberFormat.currency(
      locale: 'id_ID',
      symbol: 'Rp ',
      decimalDigits: 0,
    );
    return formatter.format(value);
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      _format(price),
      style: style ?? Theme.of(context).textTheme.bodyMedium,
    );
  }
}
