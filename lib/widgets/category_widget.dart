// ignore_for_file: use_key_in_widget_constructors

import 'package:fleur_d_or/Screens/display_by_category.dart';
import 'package:flutter/material.dart';

class CategoryWidget extends StatelessWidget {
  const CategoryWidget({
    required this.id,
    required this.image,
    required this.name,
  });
  final String id;
  final String? image;
  final String? name;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      child: Column(children: <Widget>[
        Container(
          width: 100,
          height: 100,
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: Colors.black12, width: 2)),
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: GestureDetector(
              onTap: () {
                Navigator.of(context)
                    .pushNamed(DisplayByCategory.routeName, arguments: name);
              },
              child: Image.asset(
                image!,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        Text('$name',
            style: const TextStyle(
              fontSize: 13,
              //letterSpacing: 1,
            )),
      ]),
    );
  }
}
