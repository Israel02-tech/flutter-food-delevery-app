// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:food_delivery_app/pages/details.dart';
import 'package:food_delivery_app/widget/show_item.dart';
import 'package:food_delivery_app/widget/widget_support.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool icecream = false, pizza = false, salad = false, burger = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              Container(
                margin: EdgeInsets.only(right: 15),
                child: ShowItem(),
              ),

              SizedBox(height: 20),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: ((context) => Details()),
                          ),
                        );
                      },
                      child: Container(
                        margin: EdgeInsets.all(4),
                        child: Material(
                          borderRadius: BorderRadius.circular(15),
                          elevation: 10,
                          child: Container(
                            padding: EdgeInsets.all(14),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Image.asset(
                                  "images/salad4.png",
                                  height: 150,
                                  width: 150,
                                  fit: BoxFit.cover,
                                ),
                                Text(
                                  "Veggie Taco Mash",
                                  style: Appwidget.SemiBoldTextFieldStyle(),
                                ),
                                Text(
                                  "Fresh and Healthy",
                                  style: Appwidget.LightTextFieldStyle(),
                                ),
                                SizedBox(height: 5),
                                Text(
                                  "\$25",
                                  style: Appwidget.SemiBoldTextFieldStyle(),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    Container(
                      margin: EdgeInsets.all(4),
                      child: Material(
                        borderRadius: BorderRadius.circular(15),
                        elevation: 10,
                        child: Container(
                          padding: EdgeInsets.all(14),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Image.asset(
                                "images/salad2.png",
                                height: 150,
                                width: 150,
                                fit: BoxFit.cover,
                              ),
                              Text(
                                "Veggie Taco Mash",
                                style: Appwidget.SemiBoldTextFieldStyle(),
                              ),
                              Text(
                                "Fresh and Healthy",
                                style: Appwidget.LightTextFieldStyle(),
                              ),
                              SizedBox(height: 5),
                              Text(
                                "\$25",
                                style: Appwidget.SemiBoldTextFieldStyle(),
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Container(
                margin: EdgeInsets.only(right: 15),
                child: Material(
                  borderRadius: BorderRadius.circular(20),
                  elevation: 10.0,
                  child: Container(
                    padding: EdgeInsets.all(5),
                    margin: EdgeInsets.only(right: 9),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          child: Image.asset(
                            "images/salad2.png",
                            height: 130,
                            width: 130,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: MediaQuery.of(context).size.width / 2.0,
                              child: Text(
                                "Mediterrenaen Chicken Salad",
                                style: Appwidget.SemiBoldTextFieldStyle(),
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width / 2.0,
                              child: Text(
                                "Honey goot Cheese",
                                style: Appwidget.LightTextFieldStyle(),
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width / 2.0,
                              child: Text(
                                "\$30",
                                style: Appwidget.SemiBoldTextFieldStyle(),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                margin: EdgeInsets.only(right: 15),
                child: Material(
                  borderRadius: BorderRadius.circular(20),
                  elevation: 10.0,
                  child: Container(
                    padding: EdgeInsets.all(5),
                    margin: EdgeInsets.only(right: 9),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          child: Image.asset(
                            "images/salad2.png",
                            height: 130,
                            width: 130,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: MediaQuery.of(context).size.width / 2.0,
                              child: Text(
                                "Mediterrenaen Chicken Salad",
                                style: Appwidget.SemiBoldTextFieldStyle(),
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width / 2.0,
                              child: Text(
                                "Honey goot Cheese",
                                style: Appwidget.LightTextFieldStyle(),
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width / 2.0,
                              child: Text(
                                "\$30",
                                style: Appwidget.SemiBoldTextFieldStyle(),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
