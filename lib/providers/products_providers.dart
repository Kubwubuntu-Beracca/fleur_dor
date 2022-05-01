// ignore_for_file: prefer_final_fields

import './product.dart';
import 'package:flutter/material.dart';

class ProductsProvider with ChangeNotifier {
  List<Product> _items = [
    Product(
      id: 'p1',
      title: 'Bouquet Rose',
      description: 'Blooming blossoming',
      price: '100.000',
      imageUrl:
          'https://images.unsplash.com/photo-1567696153798-9111f9cd3d0d?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=387&q=80',
    ),
    Product(
      id: 'p2',
      title: 'Amagaba',
      description: 'Flowering',
      price: '20.000',
      imageUrl:
          'https://images.unsplash.com/photo-1529636798458-92182e662485?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=869&q=80',
    ),
    Product(
      id: 'p3',
      title: 'Icuhiro',
      description: 'flourishing',
      price: '30.000',
      imageUrl:
          'https://images.unsplash.com/photo-1576161954389-69cb769e0eee?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=436&q=80',
    ),
    Product(
      id: 'p4',
      title: 'Centre-Face',
      description: 'thriving',
      price: '30.000',
      imageUrl:
          'https://images.unsplash.com/photo-1567696153798-9111f9cd3d0d?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=387&q=80',
    ),
    Product(
      id: 'p5',
      title: 'Simbimanga',
      description: 'Thriving in vigor',
      price: '40.000',
      imageUrl:
          'https://images.unsplash.com/photo-1529636798458-92182e662485?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=869&q=80',
    ),
    Product(
      id: 'p6',
      title: 'table d honneur',
      description: 'health and beauty',
      price: '10.000',
      imageUrl:
          'https://images.unsplash.com/photo-1576161954389-69cb769e0eee?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=436&q=80',
    )
  ];

  List<Product> get items {
    return [..._items];
  }

  Product findById(String id) {
    return _items.firstWhere((prod) => prod.id == id);
  }
}
