// ignore_for_file: prefer_const_literals_to_create_immutables, avoid_unnecessary_containers, sized_box_for_whitespace, use_key_in_widget_constructors

import 'package:fleur_d_or/providers/product.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CategoryItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final product = Provider.of<Product>(context, listen: false);
    return Card(
      elevation: 5,
      child: Row(
        children: <Widget>[
          Container(
            height: 182,
            width: 130,
            padding: const EdgeInsets.all(5.0),
            child: Image.network(
              product.imageUrl!,
              fit: BoxFit.cover,
            ),
          ),
          Expanded(
            child: Container(
              height: 182,
              padding: const EdgeInsets.all(8.0),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      product.price!,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),

                    Text(
                      product.description!,
                      style: const TextStyle(color: Colors.grey, fontSize: 15),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Container(
                        height: 50,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.black,
                        ),
                        child: IconButton(
                          onPressed: () {},
                          icon: Icon(
                            product.isFavorite
                                ? Icons.favorite
                                : Icons.favorite_border,
                            color: Colors.amber,
                          ),
                        )),
                    //const SizedBox(height: 10),
                    // Container(
                    //   height: 100,
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 2),
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child: Row(
                              children: <Widget>[
                                const Icon(
                                  Icons.star_border,
                                  color: Colors.black,
                                ),
                                const Icon(
                                  Icons.star_border,
                                  color: Colors.black,
                                ),
                                const Icon(
                                  Icons.star_border,
                                  color: Colors.black,
                                ),
                                const Icon(
                                  Icons.star_border,
                                  color: Colors.black,
                                ),
                              ],
                            ),
                          ),
                          ElevatedButton(
                            onPressed: () {},
                            child: const Text('ADD TO CART'),
                          ),
                        ],
                      ),
                    ),
                  ]),
            ),
          )
        ],
      ),
    );
  }
}
