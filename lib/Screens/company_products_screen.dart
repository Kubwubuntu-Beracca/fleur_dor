// ignore_for_file: use_key_in_widget_constructors

import 'package:fleur_d_or/Screens/edit_product_screen.dart';

import '../widgets/app_drawer.dart';
import '../widgets/company_product_item.dart';
import '../providers/products_providers.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CompanyProductsScreen extends StatelessWidget {
  static const routeName = '/company-products';
  @override
  Widget build(BuildContext context) {
    final productsData = Provider.of<ProductsProvider>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        iconTheme: Theme.of(context).iconTheme,
        title: const Text(
          'Our Products',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            onPressed: () {
              Navigator.of(context).pushNamed(EditProductScreen.routeName);
            },
            icon: const Icon(Icons.add),
          )
        ],
      ),
      drawer: const AppDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: ListView.builder(
            itemCount: productsData.items.length,
            itemBuilder: (_, i) => Column(children: [
                  CompProdItem(
                    productsData.items[i].id,
                    productsData.items[i].title,
                    productsData.items[i].imageUrl,
                  ),
                  const Divider(),
                ])),
      ),
    );
  }
}
