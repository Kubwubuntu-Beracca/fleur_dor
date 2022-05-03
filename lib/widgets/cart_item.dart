// ignore_for_file: prefer_const_constructors_in_immutables, use_key_in_widget_constructors, sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/cart.dart';

class CartItemWidget extends StatelessWidget {
  CartItemWidget(
    this.id,
    this.productId,
    this.price,
    this.quantity,
    this.title,
    this.imageNet,
  );
  final String id;
  final String productId;
  final int? price;
  final int? quantity;
  final String? title;
  final String? imageNet;

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(id),
      background: Container(
        color: Theme.of(context).errorColor,
        child: const Icon(
          Icons.delete,
          color: Colors.white,
          size: 40,
        ),
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20),
        margin: const EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 4,
        ),
      ),
      direction: DismissDirection.endToStart,
      onDismissed: (direction) {
        Provider.of<Cart>(context, listen: false).removeItem(productId);
      },
      child: Card(
        margin: const EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 4,
        ),
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: ListTile(
            leading: Container(
              width: 60,
              height: 100,
              child: Image.network(
                imageNet!,
                fit: BoxFit.cover,
              ),
            ),
            title: Text(title!),
            subtitle: Text('Total: ${price! * quantity!} Fbu'),
            trailing: Text('$quantity x'),
          ),
        ),
      ),
    );
  }
}
