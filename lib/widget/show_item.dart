import 'package:flutter/material.dart';

import '../service/database.dart';

class ShowItem extends StatefulWidget {
  const ShowItem({super.key});

  @override
  State<ShowItem> createState() => _ShowItemState();
}

class _ShowItemState extends State<ShowItem> {
  bool icecream = false, pizza = false, salad = false, burger = false;

  Stream? foodItemStream;
//Calling too function created in the database.dart, in order to get the details of the food item
  ontheload() async {
    foodItemStream = await DatabaseMethods().getFoodItem("Icecream");
    setState(() {});
  }

  @override
  void initState() {
    ontheload();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
