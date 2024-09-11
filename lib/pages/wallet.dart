// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:food_delivery_app/pages/addmoney.dart';
import 'package:food_delivery_app/service/database.dart';
import 'package:food_delivery_app/service/shared_preference.dart';
import 'package:food_delivery_app/widget/widget_support.dart';
import 'package:http/http.dart' as http;

import '../widget/app_constraint.dart';

class Wallet extends StatefulWidget {
  const Wallet({super.key});

  @override
  State<Wallet> createState() => _WalletState();
}

class _WalletState extends State<Wallet> {
  //create a nullable variable for the wallet, since we are storing the wallet that is the amount in the wallet as string
  String? wallet;
  String? id;

  // creating a variable for update the current amount in the wallet, that is adding the initial value to the value that has just been added by the user
  int? add;
// A TextEditing controller to take and store the user input in the dialog box
  TextEditingController amountcontroller = new TextEditingController();

  // Calling the shared preference Method to get all the info that has been locally saved, specifically getting the user wallet using the getUserWallet function in the Sharedpreference Method
  getthesharedpref() async {
    wallet = await SharedPreferenceHelper().getUserWallet();
    id = await SharedPreferenceHelper().getUserId();
    setState(() {});
  }

//  This is an ontheload function that will be called immidiately the wallet page is opened, this get all the data ready immdediately the page is open, the ontheload functio is put in the initState because the initState function is called immediately the page is open
  onthelaod() async {
    await getthesharedpref();
    setState(() {});
  }

  @override
  void initState() {
    onthelaod();
    super.initState();
  }

  Map<String, dynamic>? paymentIntent;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: wallet == null
            ? CircularProgressIndicator()
            : Container(
                margin: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height / 23,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Material(
                      elevation: 2.0,
                      child: Container(
                        // padding: EdgeInsets.only(bottom: 5.0),
                        child: Center(
                          child: Text(
                            "Wallet",
                            style: Appwidget.HeaderTextFieldStyle(),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        color: Color(0xFFF2F2F2),
                      ),
                      child: Row(
                        children: [
                          Image.asset(
                            "images/wallet.png",
                            fit: BoxFit.cover,
                            height: 60,
                            width: 60,
                          ),
                          SizedBox(width: 40),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Your Wallet",
                                style: Appwidget.LightTextFieldStyle(),
                              ),
                              SizedBox(height: 5.0),
                              Text(
                                "\$${wallet!}",
                                style: Appwidget.SemiBoldTextFieldStyle(),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20.0),
                      child: Text(
                        "Add money",
                        style: Appwidget.SemiBoldTextFieldStyle(),
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 15, right: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onTap: () {
                              makePayment("\$100");
                            },
                            child: Addmoney(price: "\$100"),
                          ),
                          GestureDetector(
                            onTap: () {
                              makePayment("\$500");
                            },
                            child: Addmoney(price: "\$500"),
                          ),
                          GestureDetector(
                            onTap: () {
                              makePayment("\$1000");
                            },
                            child: Addmoney(price: "\$1000"),
                          ),
                          GestureDetector(
                            onTap: () {
                              makePayment("\$2000");
                            },
                            child: Addmoney(price: "\$2000"),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    GestureDetector(
                      onTap: () {
                        openEdit();
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 12),
                        margin: EdgeInsets.symmetric(horizontal: 20.0),
                        width: MediaQuery.of(context).size.width,
                        height: 50,
                        decoration: BoxDecoration(
                          color: Color(0xFF008080),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Center(
                          child: Text(
                            "Add Money",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16.0,
                              fontFamily: "Poppins",
                              fontWeight: FontWeight.bold,
                            ),
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

  Future<void> makePayment(String amount) async {
    try {
      print("Creating payment intent......");
      paymentIntent = await createPaymentIntent(amount, "USD");
      print("Payment intent created: $paymentIntent");
      await Stripe.instance
          .initPaymentSheet(
              paymentSheetParameters: SetupPaymentSheetParameters(
            paymentIntentClientSecret: paymentIntent?['client_secret'],
            style: ThemeMode.dark,
            merchantDisplayName: 'Israel',
          ))
          .then((value) {});

      await displayPaymentSheet(amount);
    } catch (e, s) {
      print("Exception in makePayment:$e\n$s");
    }
  }

  Future<void> displayPaymentSheet(String amount) async {
    //Uploding the details of the order placed to the firebase
    try {
      // adding the initial amount in the user wallet to the amount the user has added using the payment gate way and the saving it back to the local Storage that has been created which is the sharedpreference or let's say updating the data of the user wallet
      // Also since the wallet is been saved in form of string then we have to parse it in order to add them together

      await Stripe.instance.presentPaymentSheet().then((value) async {
//Sice we are passing the amount as a string with a dollar sign (e.g., "\$100"), so when we parse this for adding to the wallet, it still contains the dollar sign. The parsing function (add = int.parse(wallet!) + int.parse(amount)) will fail if the string isn't a pure number. The Solution to this is to Clean the amount string before parsing it, by using a function(replaceAll(RegExp(r'[^0-9]'), '')) to remove non-numeric characters:
        add = int.parse(wallet!) +
            int.parse(amount.replaceAll(RegExp(r'[^0-9]'), ''));

        // Here the wallet update is done, if a setState is used then the wallet amount wont be updated, and also if wed don't store the value of the add that is the addition of the amount in the wallet varaible then it isn't going to show that money has been adde dto the wallet, these are issues i faced while doing this
        await SharedPreferenceHelper().saveUserWallet(add.toString());
        setState(() {
          wallet = add.toString();
        });

        await DatabaseMethods().UpdateUserwallet(id!, add.toString());

        // Map<String, dynamic> orderInfoMap = {
        //   "Product": widget.name,
        //   "Price": widget.price,
        //   "Name": name,
        //   "Email": email,
        //   "Image": image,
        //   "ProductImage": widget.image,
        //   "Status": "On the Way",
        // };
        //Saving the oderdetails to the database the database
        // await DatabaseMethods().orderDetails(orderInfoMap);
        showDialog(
            context: context,
            builder: (_) => AlertDialog(
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.check_circle, color: Colors.green),
                          Text("Payment Succesfull"),
                        ],
                      ),
                    ],
                  ),
                ));

        // After the dialogBox for a successfull payment has been showed then we updated the wallet again, by calling the getthesharedpref function use for getting the wallet data from the local Storage
        await getthesharedpref();

        paymentIntent = null;
      }).onError((error, stackTrace) {
        print("Error presentPaymentSheet :-------> $error $stackTrace");
      });
    } on StripeException catch (e) {
      print("StripeException in displayPaymentSheet: $e");
      showDialog(
          context: context,
          builder: (_) => AlertDialog(
                content: Text("Cancelled"),
              ));
    } catch (e) {
      print("Exception in displayPaymentSheet:$e");
    }
  }

  Future<Map<String, dynamic>> createPaymentIntent(
      String amount, String currency) async {
    try {
      String cleanAmount = amount.replaceAll(RegExp(r'[^0-9]'), '');
      Map<String, dynamic> body = {
        "amount": calculateAmount(cleanAmount),
        "currency": currency,
        "payment_method_types[]": "card"
      };

      var response = await http.post(
        Uri.parse("https://api.stripe.com/v1/payment_intents"),
        headers: {
          "Authorization": "Bearer $secretKey",
          "Content-Type": "application/x-www-form-urlencoded",
        },
        body: body.map((key, value) => MapEntry(key, value.toString())),
      );
      return jsonDecode(response.body);
    } catch (err) {
      print("Error creating payment intent: ${err.toString()}");
      throw err;
    }
  }

  calculateAmount(String amount) {
    final int calculatedAmount = int.parse(amount) * 100;
    return calculatedAmount.toString();
  }

// Creatin a Dialof Box for the Add money button. so the user can add anyy amount of their choice
  Future openEdit() => showDialog(
      context: context,
      builder: (context) => AlertDialog(
              content: SingleChildScrollView(
            child: Container(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Icon(Icons.cancel),
                    ),
                    SizedBox(width: 60.0),
                    Center(
                      child: Text(
                        "Add Money",
                        style: TextStyle(
                          color: Color(0xFF008080),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20.0),
                Text("Amount"),
                SizedBox(height: 10.0),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10.0),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black38, width: 2.0),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: TextField(
                      controller: amountcontroller,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "Enter Amount",
                      )),
                ),
                SizedBox(height: 20),
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                    makePayment(amountcontroller.text);
                  },
                  child: Center(
                    child: Container(
                      width: 100,
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        color: Color(0xFF008080),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(
                        child: Text(
                          "Pay",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            )),
          )));
}
