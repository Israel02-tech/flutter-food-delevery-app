import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery_app/widget/widget_support.dart';

import 'home_admin.dart';

class AdminLogin extends StatefulWidget {
  const AdminLogin({super.key});

  @override
  State<AdminLogin> createState() => _AdminLoginState();
}

class _AdminLoginState extends State<AdminLogin> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  TextEditingController adminnamecontroller = new TextEditingController();
  TextEditingController adminpasswordcontroller = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFededeb),
      body: SingleChildScrollView(
        child: Container(
          child: Stack(
            children: [
              Container(
                margin: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height / 2.2,
                ),
                padding: EdgeInsets.only(
                  top: 45.0,
                  left: 20.0,
                  right: 20.0,
                ),
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Color.fromARGB(255, 69, 69, 69),
                      Color.fromARGB(255, 0, 0, 0),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.vertical(
                    top: Radius.elliptical(
                        MediaQuery.of(context).size.width, 110.0),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 30.0, right: 30.0, top: 60.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      Text(
                        "Let's Start with\nAdmin",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 25,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 30.0),
                      SingleChildScrollView(
                        child: Material(
                          elevation: 10.0,
                          borderRadius: BorderRadius.circular(20),
                          child: Container(
                            height: MediaQuery.of(context).size.height / 2.0,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Column(
                              children: [
                                SizedBox(height: 50),
                                Container(
                                  padding: EdgeInsets.only(
                                    left: 5.0,
                                    top: 5.0,
                                    bottom: 5.0,
                                  ),
                                  margin:
                                      EdgeInsets.symmetric(horizontal: 20.0),
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: Color.fromARGB(255, 160, 160, 147),
                                    ),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Center(
                                    child: TextFormField(
                                      decoration: InputDecoration(
                                        border: InputBorder.none,
                                        hintText: "Username",
                                        hintStyle: TextStyle(
                                          fontFamily: "Poppins",
                                          fontSize: 18,
                                          color: Color.fromARGB(
                                              255, 160, 160, 147),
                                        ),
                                        prefixIcon:
                                            Icon(Icons.person_3_rounded),
                                      ),
                                      controller: adminnamecontroller,
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return "Please Enter Your Username";
                                        }
                                      },
                                    ),
                                  ),
                                ),
                                SizedBox(height: 40),
                                Container(
                                  padding: EdgeInsets.only(
                                    left: 5.0,
                                    top: 5.0,
                                    bottom: 5.0,
                                  ),
                                  margin:
                                      EdgeInsets.symmetric(horizontal: 20.0),
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: Color.fromARGB(255, 160, 160, 147),
                                    ),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Center(
                                    child: TextFormField(
                                      obscureText: true,
                                      decoration: InputDecoration(
                                        border: InputBorder.none,
                                        hintText: "Password",
                                        hintStyle: TextStyle(
                                          fontFamily: "Poppins",
                                          fontSize: 18,
                                          color: Color.fromARGB(
                                              255, 160, 160, 147),
                                        ),
                                        prefixIcon:
                                            Icon(Icons.password_rounded),
                                      ),
                                      controller: adminpasswordcontroller,
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return "Please Enter Your Password";
                                        }
                                      },
                                    ),
                                  ),
                                ),
                                SizedBox(height: 40.0),
                                GestureDetector(
                                  onTap: () {
                                    LoginAdmin();
                                  },
                                  child: Container(
                                    width:
                                        MediaQuery.of(context).size.width / 1.4,
                                    padding: EdgeInsets.all(15),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12),
                                      color: Colors.black,
                                    ),
                                    child: Center(
                                      child: Text(
                                        "LogIn",
                                        style: TextStyle(
                                          fontSize: 18,
                                          color: Colors.white,
                                          fontFamily: "Poppins",
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  LoginAdmin() {
    FirebaseFirestore.instance.collection("Admin").get().then((snapshot) {
      snapshot.docs.forEach((result) {
        if (result.data()["id"] != adminnamecontroller.text.trim()) {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              backgroundColor: Colors.orangeAccent,
              content: Text("Your Id is Incorrect",
                  style: TextStyle(fontSize: 20.0))));
        } else if (result.data()["password"] !=
            adminpasswordcontroller.text.trim()) {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              backgroundColor: Colors.orangeAccent,
              content: Text("Your Password is Incorrect",
                  style: TextStyle(fontSize: 20.0))));
        } else {
          Route route = MaterialPageRoute(
            builder: (context) => HomeAdmin(),
          );
          Navigator.pushReplacement(context, route);
        }
      });
    });
  }
}
