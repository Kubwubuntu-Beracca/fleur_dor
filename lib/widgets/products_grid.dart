// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors_in_immutables

import 'package:flutter/material.dart';
import './item_widget.dart';
import 'package:provider/provider.dart';
import '../providers/products_providers.dart';

class ProductsGrid extends StatelessWidget {
  final bool showFavs;
  ProductsGrid(this.showFavs);
  @override
  Widget build(BuildContext context) {
    final loadedData = Provider.of<ProductsProvider>(context);
    final products = showFavs ? loadedData.favoriteItems : loadedData.items;
    return GridView.builder(
      shrinkWrap: true,
      physics: const ScrollPhysics(),
      padding: const EdgeInsets.all(10.0),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 2 / 3,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10),
      itemCount: products.length,
      itemBuilder: (ctx, i) => ChangeNotifierProvider.value(
        value: products[i],
        child: ItemWidget(),
      ),
    );
  }
}
