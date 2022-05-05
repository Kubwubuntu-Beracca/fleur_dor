// ignore_for_file: unrelated_type_equality_checks, use_key_in_widget_constructors, sized_box_for_whitespace, prefer_const_constructors

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
      body: Column(children: <Widget>[
        Container(
          height: 600,
          width: double.infinity,
          child: GridTile(
            child: Image.network(
              loadedProducts.imageUrl!,
              fit: BoxFit.cover,
            ),
            footer: GridTileBar(
              backgroundColor: Colors.white,
              subtitle: Text(
                '${loadedProducts.description}',
                style: TextStyle(color: Colors.black45),
              ),
              title: Text('${loadedProducts.price}',
                  style: TextStyle(color: Colors.black)),
              trailing: IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.share_outlined,
                    color: Colors.black,
                    size: 25,
                  )),
            ),
          ),
        ),
        Divider(
          thickness: 1,
        ),
        Expanded(
          child: Row(
            children: <Widget>[
              IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.favorite_border,
                  color: Colors.black,
                  size: 30,
                ),
              ),
              Expanded(
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.only(
                    right: 10,
                    bottom: 5,
                  ),
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      primary: Colors.black,
                    ),
                    child: Text(
                      'ADD TO BAG',
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ]),
    );
  }
}
