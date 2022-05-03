// ignore_for_file: prefer_final_fields

import 'package:flutter/material.dart';

class CartItem {
  final String id;
  final String? title;
  final int? quantity;
  final int? price;
  final String? image;

  CartItem(
      {required this.id,
      required this.title,
      required this.quantity,
      required this.price,
      required this.image});
}

class Cart with ChangeNotifier {
  Map<String, CartItem> _items = {};

  Map<String, CartItem> get items {
    return {..._items};
  }

  int get itemCount {
    return _items.length;
  }

  int get totalAmount {
    var total = 0;
    _items.forEach((key, cartItem) {
      total += cartItem.price! * cartItem.quantity!;
    });
    return total;
  }

  void addItem(String productId, int? price, String? title, String? image) {
    if (_items.containsKey(productId)) {
      _items.update(
        productId,
        (existingItem) => CartItem(
            id: existingItem.id,
            title: existingItem.title,
            quantity: existingItem.quantity! + 1,
            price: existingItem.price,
            image: existingItem.image),
      );
    } else {
      _items.putIfAbsent(
        productId,
        () => CartItem(
            id: DateTime.now().toString(),
            title: title,
            quantity: 1,
            price: price,
            image: image),
      );
    }
    notifyListeners();
  }

  void removeItem(String productId) {
    _items.remove(productId);
    notifyListeners();
  }
}
