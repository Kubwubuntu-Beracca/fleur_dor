// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors

import 'package:fleur_d_or/providers/cart.dart';
import 'package:fleur_d_or/providers/product.dart';
import 'package:fleur_d_or/Screens/product_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ItemWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final product = Provider.of<Product>(context, listen: false);
    final cart = Provider.of<Cart>(context, listen: false);
    return Stack(
      children: <Widget>[
        ClipRRect(
          borderRadius: BorderRadius.circular(10.0),
          child: GridTile(
            child: GestureDetector(
              onTap: () {
                Navigator.of(context).pushNamed(ProductDetailScreen.routeName,
                    arguments: product.id);
              },
              child: Image.network(
                product.imageUrl!,
                fit: BoxFit.cover,
              ),
            ),
            footer: GridTileBar(
              backgroundColor: Colors.white,
              leading: Text(
                '${product.price!} Fbu',
                style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                  fontSize: 18,
                ),
              ),
              title: const Text(''),
              trailing: IconButton(
                onPressed: () {
                  cart.addItem(product.id, int.parse(product.price!),
                      product.title, product.imageUrl);
                  ScaffoldMessenger.of(context).hideCurrentSnackBar();
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: const Text(
                        'Added to bag',
                        textAlign: TextAlign.center,
                      ),
                      duration: const Duration(seconds: 3),
                      action: SnackBarAction(
                        label: 'UNDO',
                        textColor: Colors.amber,
                        onPressed: () {
                          cart.removeSingleItem(product.id);
                        },
                      ),
                    ),
                  );
                },
                icon: const Icon(
                  Icons.shopping_bag_outlined,
                  color: Colors.black,
                ),
              ),
            ),
          ),
        ),
        Positioned(
          right: 10,
          top: 10,
          child: Container(
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              //border: Border.all(width: 2, color: Colors.black54),
              color: Colors.white,
            ),
            constraints: const BoxConstraints(
              minHeight: 20,
              minWidth: 20,
            ),
            child: Consumer<Product>(
              //product is the value representing Product data
              builder: (ctx, product, child) => IconButton(
                onPressed: () {
                  product.toggleFavoriteStatus();
                },
                icon: Icon(
                  product.isFavorite ? Icons.favorite : Icons.favorite_border,
                  color: Colors.black,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
