import 'package:flutter/material.dart';
import 'package:food_delivery_app/widget/widget_support.dart';

class Addmoney extends StatelessWidget {
  String price;
   Addmoney({super.key, required this.price});

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(5),
        decoration: BoxDecoration(
          border: Border.all(color: Color(0xFFE9E2E2)),
          borderRadius: BorderRadius.circular(5),
        ),
        child: Text(
          price,
          style: Appwidget.SemiBoldTextFieldStyle(),
        ));
  }
}
