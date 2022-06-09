// ignore_for_file: deprecated_member_use, sized_box_for_whitespace, prefer_const_constructors_in_immutables, use_key_in_widget_constructors

import 'package:fleur_d_or/Screens/edit_product_screen.dart';
import 'package:fleur_d_or/providers/products_providers.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CompProdItem extends StatelessWidget {
  final String id;
  final String? title;
  final String? imageUrl;
  CompProdItem(
    this.id,
    this.title,
    this.imageUrl,
  );

  @override
  Widget build(BuildContext context) {
    final scaffold = ScaffoldMessenger.of(context);
    return ListTile(
        title: Text(title!),
        leading: CircleAvatar(
          backgroundImage: NetworkImage(imageUrl!),
        ),
        trailing: Container(
          width: 100,
          child: Row(
            children: <Widget>[
              IconButton(
                icon: const Icon(Icons.edit),
                onPressed: () {
                  Navigator.of(context)
                      .pushNamed(EditProductScreen.routeName, arguments: id);
                },
                color: Theme.of(context).accentColor,
              ),
              IconButton(
                icon: Icon(
                  Icons.delete,
                  color: Theme.of(context).errorColor,
                ),
                onPressed: () async {
                  try {
                    await Provider.of<ProductsProvider>(context, listen: false)
                        .deleteProduct(id);
                  } catch (error) {
                    //of context can't wait run after the build has already run
                    //because dart is not sure if the context still refer to the same widget
                    scaffold.showSnackBar(
                      const SnackBar(
                        content: Text('Deleting failed'),
                      ),
                    );
                  }
                },
              ),
            ],
          ),
        ));
  }
}
