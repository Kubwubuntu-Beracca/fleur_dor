// ignore_for_file: prefer_final_fields

import './product.dart';
import 'package:flutter/material.dart';

class ProductsProvider with ChangeNotifier {
  List<Product> _items = [
    Product(
      id: 'p1',
      title: 'Bouquet Rose',
      description: 'Blooming blossoming',
      price: '100000',
      category: 'Anniversary',
      imageUrl:
          'https://images.unsplash.com/photo-1567696153798-9111f9cd3d0d?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=387&q=80',
    ),
    Product(
      id: 'p2',
      title: 'Amagaba',
      description: 'Flowering',
      price: '20000',
      category: 'Dot',
      imageUrl:
          'https://images.unsplash.com/photo-1529636798458-92182e662485?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=869&q=80',
    ),
    Product(
      id: 'p3',
      title: 'Icuhiro',
      description: 'flourishing',
      price: '30000',
      category: 'Mariage',
      imageUrl:
          'https://images.unsplash.com/photo-1576161954389-69cb769e0eee?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=436&q=80',
    ),
    Product(
      id: 'p4',
      title: 'Centre-Face',
      description: 'thriving',
      price: '30000',
      category: 'Anniversary',
      imageUrl:
          'https://images.unsplash.com/photo-1567696153798-9111f9cd3d0d?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=387&q=80',
    ),
    Product(
      id: 'p5',
      title: 'Simbimanga',
      description: 'Thriving in vigor',
      price: '40000',
      category: 'Dot',
      imageUrl:
          'https://images.unsplash.com/photo-1529636798458-92182e662485?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=869&q=80',
    ),
    Product(
      id: 'p6',
      title: 'table d honneur',
      description: 'health and beauty',
      price: '10000',
      category: 'Mariage',
      imageUrl:
          'https://images.unsplash.com/photo-1576161954389-69cb769e0eee?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=436&q=80',
    )
  ];

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

  void addProduct(Product product) {
    final newProduct = Product(
      title: product.title,
      description: product.description,
      price: product.price,
      imageUrl: product.imageUrl,
      category: product.category,
      id: DateTime.now().toString(),
    );
    _items.add(newProduct);
    // _items.insert(0, newProduct); at the start of the list
    notifyListeners();
  }

  void updateProduct(String id, Product newProduct) {
    final prodIndex = _items.indexWhere((prod) => prod.id == id);
    if (prodIndex >= 0) {
      _items[prodIndex] = newProduct;
      notifyListeners();
    } else {}
  }

  void deleteProduct(String id) {
    _items.removeWhere((prod) => prod.id == id);
    notifyListeners();
  }
}
