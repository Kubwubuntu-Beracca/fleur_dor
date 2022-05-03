import 'package:fleur_d_or/Screens/cart_screen.dart';
import 'package:fleur_d_or/Screens/display_by_category.dart';
import 'package:fleur_d_or/Screens/orders_screen.dart';
import 'package:fleur_d_or/Screens/product_details_screen.dart';
import 'package:fleur_d_or/providers/cart.dart';
import 'package:fleur_d_or/providers/orders.dart';
import 'package:fleur_d_or/providers/product.dart';
import 'package:fleur_d_or/providers/products_providers.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'Screens/products_over_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (ctx) => ProductsProvider(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => Cart(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => Orders(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primaryColor: Colors.white,
          fontFamily: 'Roboto',
        ),
        home: ProductsOverView(),
        routes: {
          ProductDetailScreen.routeName: (ctx) => ProductDetailScreen(),
          DisplayByCategory.routeName: (ctx) => DisplayByCategory(),
          CartScreen.routeName: (ctx) => CartScreen(),
          OrderScreen.routeName: (ctx) => OrderScreen(),
        },
      ),
    );
  }
}
