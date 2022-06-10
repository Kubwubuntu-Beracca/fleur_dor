// ignore_for_file: deprecated_member_use, unnecessary_null_comparison

import 'package:fleur_d_or/Screens/category_screen.dart';
import 'package:fleur_d_or/Screens/splash_screen.dart';
import 'package:fleur_d_or/widgets/cat_item.dart';

import '../providers/auth.dart';
import '../Screens/auth_screen.dart';
import '../Screens/cart_screen.dart';
import '../Screens/company_products_screen.dart';
import '../Screens/display_by_category.dart';
import '../Screens/edit_product_screen.dart';
import '../Screens/orders_screen.dart';
import '../Screens/product_details_screen.dart';
import '../providers/cart.dart';
import '../providers/orders.dart';
import '../providers/products_providers.dart';
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
          ChangeNotifierProvider(create: (ctx) => Auth()),
          ChangeNotifierProxyProvider<Auth, ProductsProvider>(
            create: (_) => ProductsProvider(null, null, []),
            update: (ctx, auth, previousProducts) => ProductsProvider(
                auth.token,
                auth.userId,
                previousProducts!.items == null ? [] : previousProducts.items),
          ),
          ChangeNotifierProvider(
            create: (ctx) => Cart(),
          ),
          ChangeNotifierProxyProvider<Auth, Orders>(
            create: (_) => Orders(null, null, []),
            update: (ctx, auth, previousProducts) => Orders(
                auth.token,
                auth.userId,
                previousProducts!.orders == null
                    ? []
                    : previousProducts.orders),
          ),
        ],
        child: Consumer<Auth>(
          builder: (ctx, auth, _) => MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Flutter Demo',
            theme: ThemeData(
              primarySwatch: Colors.amber,
              primaryColor: Colors.white,
              accentColor: Colors.black,
              fontFamily: 'Roboto',
              iconTheme: const IconThemeData(color: Colors.black),
            ),
            home: auth.isAuth
                ? ProductsOverView()
                : FutureBuilder(
                    future: auth.tryAutoLogin(),
                    builder: (ctx, autoLoginResultSnapShot) =>
                        autoLoginResultSnapShot.connectionState ==
                                ConnectionState.waiting
                            ? SplashScreen()
                            : AuthScreen(),
                  ),
            routes: {
              ProductDetailScreen.routeName: (ctx) => ProductDetailScreen(),
              DisplayByCategory.routeName: (ctx) => DisplayByCategory(),
              CategoryScreen.routeName: (ctx) => const CategoryScreen(),
              CartScreen.routeName: (ctx) => CartScreen(),
              OrderScreen.routeName: (ctx) => OrderScreen(),
              CompanyProductsScreen.routeName: (ctx) => CompanyProductsScreen(),
              EditProductScreen.routeName: (ctx) => EditProductScreen(),
            },
          ),
        ));
  }
}
