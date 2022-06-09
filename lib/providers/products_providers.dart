// ignore_for_file: prefer_final_fields, avoid_print, unnecessary_null_comparison

import 'dart:convert';

import 'package:fleur_d_or/models/http_exception.dart';

import './product.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ProductsProvider with ChangeNotifier {
  List<Product> _items = [
    // Product(
    //   id: 'p1',
    //   title: 'Bouquet Rose',
    //   description: 'Blooming blossoming',
    //   price: '100000',
    //   category: 'Anniversary',
    //   imageUrl:
    //       'https://images.unsplash.com/photo-1567696153798-9111f9cd3d0d?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=387&q=80',
    // ),
    // Product(
    //   id: 'p2',
    //   title: 'Amagaba',
    //   description: 'Flowering',
    //   price: '20000',
    //   category: 'Dot',
    //   imageUrl:
    //       'https://images.unsplash.com/photo-1529636798458-92182e662485?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=869&q=80',
    // ),
    // Product(
    //   id: 'p3',
    //   title: 'Icuhiro',
    //   description: 'flourishing',
    //   price: '30000',
    //   category: 'Mariage',
    //   imageUrl:
    //       'https://images.unsplash.com/photo-1576161954389-69cb769e0eee?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=436&q=80',
    // ),
    // Product(
    //   id: 'p4',
    //   title: 'Centre-Face',
    //   description: 'thriving',
    //   price: '30000',
    //   category: 'Anniversary',
    //   imageUrl:
    //       'https://images.unsplash.com/photo-1567696153798-9111f9cd3d0d?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=387&q=80',
    // ),
    // Product(
    //   id: 'p5',
    //   title: 'Simbimanga',
    //   description: 'Thriving in vigor',
    //   price: '40000',
    //   category: 'Dot',
    //   imageUrl:
    //       'https://images.unsplash.com/photo-1529636798458-92182e662485?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=869&q=80',
    // ),
    // Product(
    //   id: 'p6',
    //   title: 'table d honneur',
    //   description: 'health and beauty',
    //   price: '10000',
    //   category: 'Mariage',
    //   imageUrl:
    //       'https://images.unsplash.com/photo-1576161954389-69cb769e0eee?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=436&q=80',
    // )
  ];

  final String? authToken;
  final String? userId;
  var _code = '';
  ProductsProvider(this.authToken, this.userId, this._items);

  List<Product> get items {
    return [..._items];
  }

  List<Product> get favoriteItems {
    return _items.where((prodItem) => prodItem.isFavorite).toList();
  }

  Product findById(String id) {
    return _items.firstWhere((prod) => prod.id == id);
  }

  List<Product> findByCategory(String catgName) {
    return _items.where((prod) {
      return prod.category!.contains(catgName);
    }).toList();
  }

  Future<void> fetchAndSetProducts([bool filterByUser = false]) async {
    final filterString =
        filterByUser ? 'orderBy="creatorId"&equalTo="$userId"' : "";
    var url =
        'https://goldenflower-a6046-default-rtdb.europe-west1.firebasedatabase.app/products.json?auth=$authToken&$filterString';
    try {
      final response = await http.get(Uri.parse(url));
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      if (extractedData == null) {
        return;
      }
      url =
          'https://goldenflower-a6046-default-rtdb.europe-west1.firebasedatabase.app/userFavorites/$userId.json?auth=$authToken';

      final favoriteResponse = await http.get(Uri.parse(url));
      print(favoriteResponse.body);
      final favoriteData = json.decode(favoriteResponse.body);
      List<Product> loadedData = [];
      extractedData.forEach((prodId, prodData) {
        loadedData.add(
          Product(
            id: prodId,
            title: prodData['title'],
            description: prodData['description'],
            price: prodData['price'],
            category: prodData['category'],
            imageUrl: prodData['imageUrl'],
            isFavorite:
                favoriteData == null ? false : favoriteData[prodId] ?? false,
          ),
        );
      });
      _items = loadedData;
      notifyListeners();
    } catch (error) {
      rethrow;
    }
  }

  Future<void> secretCode(String? code) async {
    final url =
        'https://goldenflower-a6046-default-rtdb.europe-west1.firebasedatabase.app/secret.json?auth=$authToken';
    try {
      final response =
          await http.post(Uri.parse(url), body: (json.encode({'code': code})));
      print(response.body);
    } catch (error) {
      rethrow;
    }
  }

  Future<void> getCode() async {
    final url =
        'https://goldenflower-a6046-default-rtdb.europe-west1.firebasedatabase.app/secret.json?auth=$authToken';
    try {
      final response = await http.get(Uri.parse(url));
      print(response.body);
      final responseData = json.decode(response.body);
      _code = responseData['code'];
      print(_code);
    } catch (error) {
      rethrow;
    }
  }

  String? get code {
    return _code;
  }

  Future<void> addProduct(Product product) async {
    final url =
        'https://goldenflower-a6046-default-rtdb.europe-west1.firebasedatabase.app/products.json?auth=$authToken';

    try {
      final response = await http.post(
        Uri.parse(url),
        body: json.encode(
          {
            'title': product.title,
            'description': product.description,
            'price': product.price,
            'category': product.category,
            'imageUrl': product.imageUrl,
            'creatorId': userId
          },
        ),
      );
      print(json.decode(response.body));
      final newProduct = Product(
        title: product.title,
        description: product.description,
        price: product.price,
        imageUrl: product.imageUrl,
        category: product.category,
        id: json.decode(response.body)['name'],
      );
      _items.add(newProduct);
      // _items.insert(0, newProduct); at the start of the list
      notifyListeners();
    } catch (error) {
      print(error);
      rethrow;
    }
  }

  Future<void> updateProduct(String id, Product newProduct) async {
    final prodIndex = _items.indexWhere((prod) => prod.id == id);
    if (prodIndex >= 0) {
      try {
        final url =
            'https://goldenflower-a6046-default-rtdb.europe-west1.firebasedatabase.app/products/$id.json?auth=$authToken';
        await http.patch(
          Uri.parse(url),
          body: json.encode({
            'title': newProduct.title,
            'price': newProduct.price,
            'category': newProduct.category,
            'description': newProduct.description,
            'imageUrl': newProduct.imageUrl,
          }),
        );
        _items[prodIndex] = newProduct;
        notifyListeners();
      } catch (error) {
        rethrow;
      }
    } else {}
  }

  Future<void> deleteProduct(String id) async {
    final url =
        'https://goldenflower-a6046-default-rtdb.europe-west1.firebasedatabase.app/products/$id.json';
    final existingProductIndex = _items.indexWhere((prod) => prod.id == id);
    Product? existingProduct = _items[existingProductIndex];
    _items.removeAt(existingProductIndex);
    notifyListeners();
    final response = await http.delete(Uri.parse(url));
    if (response.statusCode >= 400) {
      _items.insert(existingProductIndex, existingProduct);
      notifyListeners();
      throw HttpException('Could not delete product');
    }
    existingProduct = null;

    // _items.removeWhere((prod) => prod.id == id);
  }
}
