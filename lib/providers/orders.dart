// ignore_for_file: unnecessary_null_comparison, avoid_print

import 'package:fleur_d_or/providers/cart.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class OrderItem {
  final String id;
  final int amount;
  final List<CartItem> products;
  final DateTime dateTime;

  OrderItem({
    required this.id,
    required this.amount,
    required this.products,
    required this.dateTime,
  });
}

class Orders with ChangeNotifier {
  List<OrderItem> _orders = [];
  final String? authToken;
  Orders(this.authToken, this._orders);
  List<OrderItem> get orders {
    return [..._orders];
  }

  Future<void> fetchAndSetOrders() async {
    final url =
        'https://goldenflower-a6046-default-rtdb.europe-west1.firebasedatabase.app/orders.json?auth=$authToken';
    final response = await http.get(Uri.parse(url));
    print(response.body);

    final List<OrderItem> loadedOrders = [];
    //decode json data and chek if it is not equal to null
    final jsonToDartData = json.decode(response.body);
    if (jsonToDartData == null) {
      return;
    }
    final extractedData = jsonToDartData as Map<String, dynamic>;

    extractedData.forEach((orderId, orderData) {
      loadedOrders.add(OrderItem(
        id: orderId,
        amount: orderData['amount'],
        dateTime: DateTime.parse(orderData['dateTime']),
        products: (orderData['products'] as List<dynamic>)
            .map((item) => CartItem(
                  id: item['id'],
                  title: item['title'],
                  quantity: item['quantity'],
                  price: item['price'],
                  image: item['image'],
                ))
            .toList(),
      ));
    });
    _orders = loadedOrders.reversed.toList();
    notifyListeners();
  }

  Future<void> addOrder(List<CartItem> cartProducts, int total) async {
    final timeStamp = DateTime.now();
    final url =
        'https://goldenflower-a6046-default-rtdb.europe-west1.firebasedatabase.app/orders.json?auth=$authToken';

    try {
      final response = await http.post(
        Uri.parse(url),
        body: json.encode({
          'amount': total,
          'dateTime': timeStamp.toIso8601String(),
          'products': cartProducts
              .map((cp) => {
                    'id': cp.id,
                    'title': cp.title,
                    'quantity': cp.quantity,
                    'price': cp.price,
                    'image': cp.image
                  })
              .toList(),
        }),
      );
      _orders.insert(
        0,
        OrderItem(
          id: json.decode(response.body)['name'],
          amount: total,
          products: cartProducts,
          dateTime: timeStamp,
        ),
      );
      notifyListeners();
    } catch (error) {
      rethrow;
    }
  }
}
