// ignore_for_file: use_key_in_widget_constructors

import 'package:fleur_d_or/Screens/product_details_screen.dart';
import 'package:flutter/material.dart';

class ItemWidget extends StatelessWidget {
  const ItemWidget(
    this.id,
    this.price,
    this.imageUrl,
  );
  final String id;
  final String? price;
  final String? imageUrl;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        ClipRRect(
          borderRadius: BorderRadius.circular(10.0),
          child: GridTile(
            child: GestureDetector(
              onTap: () {
                Navigator.of(context)
                    .pushNamed(ProductDetailScreen.routeName, arguments: id);
              },
              child: Image.network(
                imageUrl!,
                fit: BoxFit.cover,
              ),
            ),
            footer: GridTileBar(
              backgroundColor: Colors.white,
              leading: FittedBox(
                child: Text(
                  '${price!} Fbu',
                  style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                    fontSize: 18,
                  ),
                ),
              ),
              trailing: IconButton(
                onPressed: () {},
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
            child: IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.favorite_border,
                color: Colors.black,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
