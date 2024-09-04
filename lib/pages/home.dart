// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery_app/pages/details.dart';
import 'package:food_delivery_app/widget/show_item.dart';
import 'package:food_delivery_app/widget/widget_support.dart';

import '../service/database.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
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

// Creating a stream builder to generate the food details
  Widget allItems() {
    return StreamBuilder(
        stream: foodItemStream,
        builder: (context, AsyncSnapshot snapshot) {
          return snapshot.hasData
              ? ListView.builder(
                  padding: EdgeInsets.zero,
                  itemCount: snapshot.data.docs.length,
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    DocumentSnapshot ds = snapshot.data.docs[index];
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: ((context) => Details(details: ds["Detail"], name: ds["Name"], price: ds["Price"], image: ds["Image"],)),
                          ),
                        );
                      },
                      child: Container(
                        width: 220,
                        margin: EdgeInsets.all(8),
                        child: Material(
                          borderRadius: BorderRadius.circular(15),
                          elevation: 10,
                          child: Container(
                            padding: EdgeInsets.only(
                              left: 12,
                              right: 12,
                              top: 16,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(15),
                                  child: Image.network(
                                    ds["Image"],
                                    height: 150,
                                    width: 150,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                SizedBox(height: 10),
                                Center(
                                  child: Text(overflow: TextOverflow.ellipsis,
                                    ds["Name"],
                                    style: Appwidget.SemiBoldTextFieldStyle(),
                                  ),
                                ),
                                Center(
                                  child: Text(
                                    overflow: TextOverflow.ellipsis,
                                    ds["Detail"],
                                    style: Appwidget.LightTextFieldStyle(),
                                  ),
                                ),
                                SizedBox(height: 0),
                                Text(
                                  "\$" + ds["Price"],
                                  style: Appwidget.SemiBoldTextFieldStyle(),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                )
              : Center(child: CircularProgressIndicator());
        });
  }

  Widget allItemsVertically() {
    return StreamBuilder(
        stream: foodItemStream,
        builder: (context, AsyncSnapshot snapshot) {
          return snapshot.hasData
              ? ListView.builder(
                  padding: EdgeInsets.zero,
                  itemCount: snapshot.data.docs.length,
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  itemBuilder: (context, index) {
                    DocumentSnapshot ds = snapshot.data.docs[index];
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: ((context) => Details(details: ds["Detail"], name: ds["Name"], price: ds["Price"], image: ds["Image"],)),
                          ),
                        );
                      },
                      child: Container(
                        margin: EdgeInsets.only(
                          top: 5,
                          bottom: 15,
                          right: 10,
                          left: 5,
                        ),
                        child: Material(
                          borderRadius: BorderRadius.circular(20),
                          elevation: 10.0,
                          child: Container(
                            padding: EdgeInsets.all(10),
                            margin: EdgeInsets.only(right: 5),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(20),
                                    child: Image.network(
                                      ds["Image"],
                                      height: 130,
                                      width: 130,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                SizedBox(width: 10),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width /
                                          2.0,
                                      child: Text(
                                        ds["Name"],
                                        style:
                                            Appwidget.SemiBoldTextFieldStyle(),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width /
                                          2.0,
                                      child: Text(
                                        ds["Detail"],
                                        style: Appwidget.LightTextFieldStyle(),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width /
                                          2.0,
                                      child: Text(
                                        "\$" + ds["Price"],
                                        style:
                                            Appwidget.SemiBoldTextFieldStyle(),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                )
              : Center(child: CircularProgressIndicator());
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff2f2f2),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.only(
            top: 35.0,
            left: 15.0,
            bottom: 30.0,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.only(right: 20),
                child: Row(
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
              ),
              SizedBox(
                height: 10.0,
              ),
              Text(
                "Delicious Food",
                style: Appwidget.HeaderTextFieldStyle(),
              ),
              SizedBox(
                height: 5.0,
              ),
              Text(
                "Discover and Get Great Food",
                style: Appwidget.LightTextFieldStyle(),
              ),

              SizedBox(height: 15),

              //food categories
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () async {
                      icecream = true;
                      pizza = false;
                      salad = false;
                      burger = false;
                      foodItemStream =
                          await DatabaseMethods().getFoodItem("Icecream");
                      setState(() {});
                    },
                    child: Material(
                      color: icecream ? Colors.white : Colors.black,
                      elevation: 5.0,
                      borderRadius: BorderRadius.circular(10),
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: icecream ? Colors.black : Colors.white,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Image.asset(
                          "images/IceCream1.png",
                          height: 50,
                          width: 50,
                          fit: BoxFit.cover,
                          color: icecream ? Colors.white : Colors.black,
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () async {
                      icecream = false;
                      pizza = true;
                      salad = false;
                      burger = false;
                      foodItemStream =
                          await DatabaseMethods().getFoodItem("Pizza");
                      setState(() {});
                    },
                    child: Material(
                      color: pizza ? Colors.white : Colors.black,
                      elevation: 5.0,
                      borderRadius: BorderRadius.circular(10),
                      child: Container(
                        decoration: BoxDecoration(
                          color: pizza ? Colors.black : Colors.white,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        padding: const EdgeInsets.all(8),
                        child: Image.asset(
                          "images/Pizza3.png",
                          height: 50,
                          width: 50,
                          fit: BoxFit.cover,
                          color: pizza ? Colors.white : Colors.black,
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () async {
                      icecream = false;
                      pizza = false;
                      salad = true;
                      burger = false;
                      foodItemStream =
                          await DatabaseMethods().getFoodItem("Salad");
                      setState(() {});
                    },
                    child: Material(
                      color: salad ? Colors.white : Colors.black,
                      elevation: 5.0,
                      borderRadius: BorderRadius.circular(10),
                      child: Container(
                        decoration: BoxDecoration(
                          color: salad ? Colors.black : Colors.white,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        padding: const EdgeInsets.all(8),
                        child: Image.asset(
                          "images/Salad1.png",
                          height: 50,
                          width: 50,
                          fit: BoxFit.cover,
                          color: salad ? Colors.white : Colors.black,
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () async {
                      icecream = false;
                      pizza = false;
                      salad = false;
                      burger = true;

                      foodItemStream =
                          await DatabaseMethods().getFoodItem("Burger");
                      setState(() {});
                    },
                    child: Material(
                      color: burger ? Colors.white : Colors.black,
                      elevation: 5.0,
                      borderRadius: BorderRadius.circular(10),
                      child: Container(
                        decoration: BoxDecoration(
                          color: burger ? Colors.black : Colors.white,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        padding: const EdgeInsets.all(8),
                        child: Image.asset(
                          "images/Burger1.png",
                          height: 50,
                          width: 50,
                          fit: BoxFit.cover,
                          color: burger ? Colors.white : Colors.black,
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              SizedBox(height: 30),
              // calling the function to get the food details
              Container(
                height: 270,
                child: allItems(),
              ),

              SizedBox(
                height: 20,
              ),
              allItemsVertically(),
            ],
          ),
        ),
      ),
    );
  }
}
