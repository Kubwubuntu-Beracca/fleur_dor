// ignore_for_file: unrelated_type_equality_checks, use_key_in_widget_constructors

import 'package:fleur_d_or/providers/products_providers.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/products_providers.dart';

class ProductDetailScreen extends StatelessWidget {
  static const routeName = '/product-detail';

  @override
  Widget build(BuildContext context) {
    final productId = ModalRoute.of(context)!.settings.arguments as String;
    //since product detail is of course also a child of the changeNotifierProvider, we can tap into our provider as well
    final loadedProducts = Provider.of<ProductsProvider>(
      context,
      listen: false,
    ).findById(
        productId); //set listen to false if you only need data one time and not intersted in updates
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        iconTheme: const IconThemeData(color: Colors.black),
        title: Text(
          loadedProducts.title!,
          style: const TextStyle(color: Colors.black),
        ),
        centerTitle: true,
      ),
    );
  }
}
