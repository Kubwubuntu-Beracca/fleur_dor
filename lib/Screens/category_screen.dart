import 'package:fleur_d_or/models/variables.dart';
import 'package:fleur_d_or/providers/products_providers.dart';
import 'package:fleur_d_or/widgets/cat_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({Key? key}) : super(key: key);
  static const routeName = '/category-screen';

  @override
  Widget build(BuildContext context) {
    final catName = ModalRoute.of(context)!.settings.arguments as String;
    final products =
        Provider.of<ProductsProvider>(context).findByCategory(catName);
    return Scaffold(
        appBar: Variables.appBar,
        body: ListView.builder(
          itemCount: products.length,
          itemBuilder: (ctx, index) => ChangeNotifierProvider.value(
            value: products[index],
            child: CategoryItem(),
          ),
        ));
  }
}
