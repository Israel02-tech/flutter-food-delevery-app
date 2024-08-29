// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

class FoodCategory extends StatelessWidget {
  FoodCategory({super.key, required this.image});
  String image;
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      elevation: 5.0,
      borderRadius: BorderRadius.circular(10),
      child: Container(
        padding: const EdgeInsets.all(8),
        child: Image.asset(
          image,
          height: 50,
          width: 50,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
