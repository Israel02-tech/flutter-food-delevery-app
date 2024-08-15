// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:food_delivery_app/widget/food_category.dart';
import 'package:food_delivery_app/widget/widget_support.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.only(top: 50.0, left: 15, right: 15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Hello Israel,',
                  style: Appwidget.BoldTextFieldStyle(),
                ),
                Container(
                  padding: EdgeInsets.all(3),
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(
                    Icons.shopping_cart,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 20.0,
            ),
            Text(
              "Delicious Food",
              style: Appwidget.HeaderTextFieldStyle(),
            ),
            // SizedBox(
            //   height: 10.0,
            // ),
            Text(
              "Discover and Get Great Food",
              style: Appwidget.LightTextFieldStyle(),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                FoodCategory(image: "images/Ice Cream1.jpeg"),
                FoodCategory(image: "images/Pizza3.jpeg"),
                FoodCategory(image: "images/Salad4.jpeg"),
                FoodCategory(image: "images/Burger4.jpeg"),
              ],
            )
          ],
        ),
      ),
    );
  }
}
