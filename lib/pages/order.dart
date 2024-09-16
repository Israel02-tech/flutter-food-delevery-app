import 'dart:async';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery_app/service/database.dart';
import 'package:food_delivery_app/service/shared_preference.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../widget/widget_support.dart';
import 'details.dart';

class Order extends StatefulWidget {
  const Order({super.key});

  @override
  State<Order> createState() => _OrderState();
}

class _OrderState extends State<Order> {
  String? id;
  String? wallet;
  int total = 0;
  int amount2 = 0;

  void startTimer() {
    Timer(Duration(seconds: 1), () {
      amount2 = total;
      setState(() {});
    });
  }

  getthesharedpreference() async {
    id = await SharedPreferenceHelper().getUserId();
    wallet = await SharedPreferenceHelper().getUserWallet();
    setState(() {});
  }

  ontheload() async {
    await getthesharedpreference();
    foodStream = await DatabaseMethods().getFoodCart(id!);
  }

  @override
  void initState() {
    super.initState();
    ontheload();
    startTimer();
  }

  Stream? foodStream;

  Widget foodCart() {
    return StreamBuilder(
        stream: foodStream,
        builder: (context, AsyncSnapshot snapshot) {
          total = 0;
          return snapshot.hasData
              ? ListView.builder(
                  padding: EdgeInsets.zero,
                  itemCount: snapshot.data.docs.length,
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  itemBuilder: (context, index) {
                    DocumentSnapshot ds = snapshot.data.docs[index];
                    total = total + int.parse(ds["Total"]);
                    return Card(
                      // color: Colors.white,
                      margin: EdgeInsets.only(
                        top: 20,
                        right: 20,
                        left: 20,
                        bottom: 5,
                      ),
                      elevation: 5,
                      child: Container(
                        padding: EdgeInsets.only(
                          top: 10,
                          left: 20,
                          right: 20,
                          bottom: 10,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Row(
                          children: [
                            Container(
                              height: 70,
                              width: 35,
                              decoration: BoxDecoration(
                                border: Border.all(),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Center(
                                child: Text(
                                  ds["Quantity"],
                                  style: TextStyle(
                                    fontSize: 18,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            ClipRRect(
                              borderRadius: BorderRadius.circular(60),
                              child: Image.network(
                                ds["Image"],
                                height: 75,
                                width: 75,
                                fit: BoxFit.cover,
                              ),
                            ),
                            SizedBox(
                              width: 15,
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  AutoSizeText(
                                    maxLines:
                                        1, // Set max lines to prevent overflow
                                    ds["Name"],
                                    style: TextStyle(
                                      fontSize: 20,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    "\$" + ds["Total"],
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        color: Color.fromARGB(255, 48, 48, 48)),
                                  ),
                                ],
                              ),
                            ),
                          ],
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
      body: Container(
        margin: EdgeInsets.only(
          top: MediaQuery.of(context).size.height / 23,
        ),
        child: Column(
          children: [
            Material(
              elevation: 5.0,
              child: Container(
                // padding: EdgeInsets.only(bottom: 5.0),
                child: Center(
                  child: Text(
                    "Food Cart",
                    style: Appwidget.HeaderTextFieldStyle(),
                  ),
                ),
              ),
            ),
            SingleChildScrollView(
              child: Container(
                height: MediaQuery.of(context).size.height / 1.518,
                child: foodCart(),
              ),
            ),
            Spacer(),
            Divider(),
            Padding(
              padding: const EdgeInsets.only(right: 10.0, left: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Total Price",
                    style: TextStyle(
                      fontSize: 20.0,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Poppins',
                    ),
                  ),
                  Text(
                    "\$" + total.toString(),
                    style: Appwidget.SlightBoldTextFieldStyle(),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            GestureDetector(
              onTap: () async {
                if (int.parse(wallet!) > amount2) {
                  int amount = int.parse(wallet!) - amount2;
                  await DatabaseMethods()
                      .UpdateUserwallet(id!, amount.toString());
                  await SharedPreferenceHelper()
                      .saveUserWallet(amount.toString());
                } else if (int.parse(wallet!) < amount2) {
                  fundWallet();
                }
                ;
              },
              child: Container(
                margin: EdgeInsets.only(
                  left: 20.0,
                  right: 20.0,
                  bottom: MediaQuery.of(context).size.width / 15,
                ),
                padding: EdgeInsets.symmetric(vertical: 10.0),
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(
                  child: Text(
                    "Check Out",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontFamily: "Poppins",
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future fundWallet() => showDialog(
        context: context,
        builder: (context) => AlertDialog(
          elevation: 10,
          content: SingleChildScrollView(
            child: Container(
              child: Column(
                // crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    alignment: Alignment.topRight,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Icon(
                        Icons.cancel,
                        size: 30,
                        color: const Color.fromARGB(255, 255, 0, 0),
                      ),
                    ),
                  ),
                  SizedBox(height: 15),
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 12),
                    margin: EdgeInsets.symmetric(horizontal: 20.0),
                    width: MediaQuery.of(context).size.width,
                    // height: 50,
                    decoration: BoxDecoration(
                      color: Color(0xFF008080),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                      child: Text(
                        textAlign: TextAlign.center,
                        "Opps!\nInsufficient Fund\nFund Your Wallet",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18.0,
                          // fontFamily: "Poppins",
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
}
