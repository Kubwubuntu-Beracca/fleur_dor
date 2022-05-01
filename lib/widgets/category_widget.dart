import 'package:flutter/material.dart';

class CategoryWidget extends StatelessWidget {
  const CategoryWidget({required this.image, required this.name});
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
            child: Image.asset(
              image!,
              fit: BoxFit.cover,
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
