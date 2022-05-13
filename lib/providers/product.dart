import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Product with ChangeNotifier {
  final String id;
  final String? title;
  final String? description;
  final String? price;
  final String? category;
  final String? imageUrl;
  bool isFavorite;

  Product({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.category,
    required this.imageUrl,
    this.isFavorite = false,
  });
  void _setFavValue(newValue) {
    isFavorite = newValue;
    notifyListeners();
  }

  Future<void> toggleFavoriteStatus(String? token) async {
    final oldStatus = isFavorite;
    isFavorite = !isFavorite;
    notifyListeners();
    try {
      final url =
          'https://goldenflower-a6046-default-rtdb.europe-west1.firebasedatabase.app/products/$id.json?auth=$token';
      final response = await http.patch(Uri.parse(url),
          body: json.encode({'isFavorite': isFavorite}));
      if (response.statusCode >= 400) {
        _setFavValue(oldStatus);
      }
    } catch (error) {
      _setFavValue(oldStatus);
    }
  }
}
