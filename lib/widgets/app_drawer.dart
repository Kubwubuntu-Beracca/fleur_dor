// ignore_for_file: sized_box_for_whitespace, prefer_const_constructors, prefer_const_literals_to_create_immutables, unnecessary_new, unused_field, prefer_final_fields, body_might_complete_normally_nullable, avoid_print

import 'dart:math';

import 'package:fleur_d_or/Screens/orders_screen.dart';
import 'package:fleur_d_or/providers/auth.dart';
import 'package:fleur_d_or/providers/products_providers.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Screens/company_products_screen.dart';

class AppDrawer extends StatefulWidget {
  @override
  State<AppDrawer> createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  bool _switchToAdmin = false;
  TextEditingController _code = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey();
  Map<String, String> _secretCodeData = {
    'code': '',
  };

  void _submitCode() {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    _formKey.currentState!.save();

    Provider.of<ProductsProvider>(context, listen: false)
        .secretCode(_secretCodeData['code']);
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          AppBar(
            backgroundColor: Theme.of(context).primaryColor,
            title: const Text('Hello Friend'),
            automaticallyImplyLeading: false,

            //never add a back button
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.shop),
            title: const Text('Shop'),
            onTap: () {
              Navigator.of(context).pushReplacementNamed('/');
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.payment),
            title: const Text('Orders'),
            onTap: () {
              Navigator.of(context).pushReplacementNamed(OrderScreen.routeName);
            },
          ),
          const Divider(),
          ExpansionTile(
            leading: const Icon(Icons.edit),
            title: Text('Manage'),
            children: <Widget>[
              ListTile(
                onTap: () {
                  Navigator.of(context)
                      .pushReplacementNamed(CompanyProductsScreen.routeName);
                },
                leading: const Text('Products'),
              ),
              ListTile(
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (ctx) => AlertDialog(
                      title: const Text('Modify the secret code'),
                      content: SizedBox(
                          height: 180,
                          child: Form(
                            key: _formKey,
                            child: Column(
                              children: <Widget>[
                                TextFormField(
                                  obscureText: true,
                                  decoration:
                                      const InputDecoration(labelText: 'Code'),
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Field empty!';
                                    }
                                    if (value.length < 7) {
                                      return 'Code too weak!';
                                    }
                                    if (!value.contains(RegExp(
                                        r"(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*\W)"))) {
                                      return 'Must conatain Capital letter symbols and number';
                                    }
                                  },
                                  controller: _code,
                                  onSaved: (value) {
                                    _secretCodeData['code'] = value!;
                                  },
                                ),
                                TextFormField(
                                  obscureText: true,
                                  decoration: const InputDecoration(
                                      labelText: 'Retype Code'),
                                  validator: (value) {
                                    if (value != _code.text) {
                                      return 'Codes do not match';
                                    }
                                  },
                                ),
                              ],
                            ),
                          )),
                      actions: [
                        TextButton(
                          onPressed: () {
                            _submitCode();

                            Navigator.of(context).pop();
                          },
                          child: const Text('Submit'),
                        )
                      ],
                    ),
                  );
                },
                leading: const Text('Admin'),
              )
            ],
          ),
          const Divider(),
          ExpansionTile(
            leading: const Icon(Icons.settings),
            title: Text('Settings'),
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(
                  left: 7,
                ),
                child: ListTile(
                    onTap: () {},
                    leading: const Text(
                      'Switch to Admin',
                      style: TextStyle(color: Colors.blueGrey),
                    ),
                    // trailing: Switch(
                    //   value: _switchToAdmin,
                    //   onChanged: (val) {
                    //     _switchToAdmin = val;
                    //     final aaa =
                    //         Provider.of<ProductsProvider>(context, listen: false)
                    //             .code;
                    //     print(aaa);
                    //   },
                    // ),
                    trailing: TextButton(
                      onPressed: () {
                        final aaa = Provider.of<ProductsProvider>(context,
                                listen: false)
                            .getCode;
                        print(aaa);
                      },
                      child: Text('check'),
                    )),
              ),
            ],
          ),
          const Divider(),
          ListTile(
              leading: const Icon(Icons.exit_to_app),
              title: const Text('Logout'),
              onTap: () {
                Navigator.of(context).pop();
                Navigator.of(context).pushReplacementNamed('/');
                Provider.of<Auth>(context, listen: false).logout();
              }),
        ],
      ),
    );
  }
}
