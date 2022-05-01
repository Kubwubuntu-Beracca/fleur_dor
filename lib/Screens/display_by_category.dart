// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/products_providers.dart';
import '../widgets/item_widget.dart';

class DisplayByCategory extends StatelessWidget {
  static const routeName = '/display-by-category';

  @override
  Widget build(BuildContext context) {
    final catName = ModalRoute.of(context)!.settings.arguments as String;
    final products =
        Provider.of<ProductsProvider>(context).findByCategory(catName);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        iconTheme: const IconThemeData(color: Colors.black),
        title: Text(
          catName,
          style: const TextStyle(color: Colors.black),
        ),
        centerTitle: true,
      ),
      body: GridView.builder(
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
      ),
    );
  }
}
