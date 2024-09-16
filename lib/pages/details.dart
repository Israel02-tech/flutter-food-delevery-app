// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:food_delivery_app/service/database.dart';
import 'package:food_delivery_app/service/shared_preference.dart';
import 'package:food_delivery_app/widget/widget_support.dart';

class Details extends StatefulWidget {
  String image, name, details, price;
  Details(
      {super.key,
      required this.image,
      required this.name,
      required this.details,
      required this.price});

  @override
  State<Details> createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  int a = 1;
  int total = 0;
  String? id;

  getsharedpreference() async {
    id = await SharedPreferenceHelper().getUserId();
    setState(() {});
  }

  onthelaod() async {
    await getsharedpreference();
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    total = int.parse(widget.price);
    onthelaod();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: const EdgeInsets.only(
          top: 40.0,
          left: 10.0,
          right: 10.0,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: const Icon(
                Icons.arrow_back_ios_new_rounded,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 10),
            Material(
              elevation: 15,
              borderRadius: BorderRadius.circular(50),
              child: Padding(
                padding: const EdgeInsets.only(
                  left: 10.0,
                  right: 10.0,
                  top: 10.0,
                  bottom: 10.0,
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(50),
                  child: Image.network(
                    widget.image,
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height / 2.5,
                    fit: BoxFit.fill,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 15),
            Text(
              widget.name,
              style: Appwidget.SemiBoldTextFieldStyle(),
              maxLines:
                  3, // Limits the text to 1 line and truncates with ellipsis if too long
              overflow:
                  TextOverflow.ellipsis, // Adds ellipsis if text is too long
            ),
            SizedBox(height: 25),
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.details,
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontSize: 15,
                          fontFamily: "Poppins",
                          fontWeight: FontWeight.w500,
                          color: Colors.black54,
                        ),
                        maxLines: 5, // Adjust this based on your design
                        overflow: TextOverflow
                            .ellipsis, // Adds ellipsis if text is too long
                      ),
                    ],
                  ),
                ),
                Spacer(),
                GestureDetector(
                  onTap: () {
                    if (a > 1) {
                      --a;
                      total = total - int.parse(widget.price);
                    }

                    setState(() {});
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(8)),
                    child: const Icon(Icons.remove, color: Colors.white),
                  ),
                ),
                const SizedBox(width: 15),
                Text(a.toString(), style: Appwidget.SemiBoldTextFieldStyle()),
                const SizedBox(width: 15),
                GestureDetector(
                  onTap: () {
                    ++a;
                    total = total + int.parse(widget.price);
                    setState(() {});
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(8)),
                    child: const Icon(Icons.add, color: Colors.white),
                  ),
                )
              ],
            ),
            const SizedBox(height: 30.0),
            const Row(
              children: [
                Text(
                  "Delivery Time",
                  style: TextStyle(
                    fontSize: 15,
                    fontFamily: "Poppins",
                    fontWeight: FontWeight.w500,
                    color: Colors.black87,
                  ),
                ),
                Spacer(),
                Icon(Icons.alarm_add_rounded),
                SizedBox(width: 5),
                Text(
                  "30 min",
                  style: TextStyle(
                    fontSize: 15,
                    fontFamily: "Poppins",
                    fontWeight: FontWeight.w500,
                    color: Colors.black87,
                  ),
                ),
              ],
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.only(bottom: 40.0),
              child: Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Total Price",
                        style: Appwidget.SemiBoldTextFieldStyle(),
                      ),
                      Text(
                        "\$${total.toString()}",
                        style: Appwidget.HeaderTextFieldStyle(),
                      ),
                    ],
                  ),
                  const Spacer(),
                  GestureDetector(
                    onTap: () async {
                      Map<String, dynamic> addFoodtoCart = {
                        "Name": widget.name,
                        "Quantity": a.toString(),
                        "Total": total.toString(),
                        "Image": widget.image,
                      };
                      await DatabaseMethods().addFoodToCart(addFoodtoCart, id!);
                      ScaffoldMessenger.of(context).showSnackBar(
                          (const SnackBar(
                              backgroundColor: Colors.redAccent,
                              content: Text("Item Added Successfully",
                                  style: TextStyle(fontSize: 20.0)))));
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      width: MediaQuery.of(context).size.width / 2.0,
                      padding: const EdgeInsets.all(10),
                      child: Row(
                        children: [
                          const Text(
                            "Add to cart",
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                              fontFamily: "Poppins",
                            ),
                          ),
                          const Spacer(),
                          Container(
                            padding: const EdgeInsets.all(3),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10)),
                            child: const Icon(
                                Icons.shopping_cart_checkout_rounded,
                                color: Colors.black),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
