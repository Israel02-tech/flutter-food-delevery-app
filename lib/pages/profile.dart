// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery_app/pages/login.dart';
import 'package:food_delivery_app/pages/signUp.dart';
import 'package:food_delivery_app/service/auth.dart';
import 'package:food_delivery_app/service/shared_preference.dart';
import 'package:image_picker/image_picker.dart';
import 'package:random_string/random_string.dart';

import '../service/database.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  String? profile, name, email;
  bool isLoading = false;

  getthesharedpreference() async {
    profile = await SharedPreferenceHelper().getUserProfile();
    name = await SharedPreferenceHelper().getUserName();
    email = await SharedPreferenceHelper().getUserEmail();
    setState(() {});
  }

  ontheload() async {
    await getthesharedpreference();
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    ontheload();
  }

  final ImagePicker _picker = ImagePicker();
  File? selectedImage;
//Create the function for the Image Picker
  Future getImage() async {
    var image = await _picker.pickImage(source: ImageSource.gallery);
    selectedImage = File(image!.path);
    setState(() {
      uploaduserimage();
    });
  }

// Creating the function to save the Item Information to the Firebase Storage
  uploaduserimage() async {
    if (selectedImage != null) {
      setState(() {
        isLoading = true;
      });
      String addId = randomAlphaNumeric(10);

      Reference firebaseStorageRef =
          FirebaseStorage.instance.ref().child("blogImages").child(addId);
      final UploadTask task = firebaseStorageRef.putFile(selectedImage!);

      var downloadUrl = await (await task).ref.getDownloadURL();
      await SharedPreferenceHelper().saveUserProfile(downloadUrl);
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: name == null
          ? Center(child: CircularProgressIndicator())
          : Container(
              child: Column(
                children: [
                  Stack(
                    children: [
                      Container(
                        padding: EdgeInsets.only(top: 45.0, left: 20.0),
                        height: MediaQuery.of(context).size.height / 4.3,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.vertical(
                            bottom: Radius.elliptical(
                              MediaQuery.of(context).size.width,
                              105.0,
                            ),
                          ),
                        ),
                      ),
                      Center(
                        child: Container(
                          margin: EdgeInsets.only(
                            top: MediaQuery.of(context).size.height / 6.5,
                          ),
                          child: Material(
                            elevation: 10.0,
                            borderRadius: BorderRadius.circular(60),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(60),
                              child: selectedImage == null
                                  ? GestureDetector(
                                      onTap: () {
                                        getImage();
                                      },
                                      child: profile == null
                                          ? Image.asset(
                                              "images/profile.jpg",
                                              height: 110,
                                              width: 110,
                                              fit: BoxFit.cover,
                                            )
                                          : Image.network(
                                              profile!,
                                              height: 120,
                                              width: 120,
                                              fit: BoxFit.cover,
                                            ),
                                    )
                                  : Image.file(selectedImage!),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          top: 70.0,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              name!,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 28.0,
                                fontWeight: FontWeight.bold,
                                // fontFamily: "Poppins",
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 15),
                  Container(
                    margin: EdgeInsets.only(
                      right: 12,
                      left: 12,
                    ),
                    height: 70,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      // color: Colors.white,
                    ),
                    child: Material(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      elevation: 10,
                      child: Container(
                        padding: EdgeInsets.all(10),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.person_rounded,
                              color: Colors.black,
                              size: 30,
                            ),
                            SizedBox(width: 18),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Name",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    // fontFamily: "Poppins",
                                  ),
                                ),
                                Text(
                                  name!,
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    // fontFamily: "Poppins",
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Container(
                    margin: EdgeInsets.only(
                      right: 12,
                      left: 12,
                    ),
                    height: 70,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      // color: Colors.white,
                    ),
                    child: Material(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      elevation: 10,
                      child: Container(
                        padding: EdgeInsets.all(10),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.email_rounded,
                              color: Colors.black,
                              size: 30,
                            ),
                            SizedBox(width: 18),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Email",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    // fontFamily: "Poppins",
                                  ),
                                ),
                                Text(
                                  email!,
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    // fontFamily: "Poppins",
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Container(
                    margin: EdgeInsets.only(
                      right: 12,
                      left: 12,
                    ),
                    height: 70,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      // color: Colors.white,
                    ),
                    child: Material(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      elevation: 10,
                      child: Container(
                        padding: EdgeInsets.all(10),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.description_rounded,
                              color: Colors.black,
                              size: 30,
                            ),
                            SizedBox(width: 18),
                            Text(
                              "Terms and Condition",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                // fontFamily: "Poppins",
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  GestureDetector(
                    onTap: () {
                      AuthMethods().deleteuser();
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Signup(),
                        ),
                      );
                    },
                    child: Container(
                      margin: EdgeInsets.only(
                        right: 12,
                        left: 12,
                      ),
                      height: 70,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        // color: Colors.white,
                      ),
                      child: Material(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        elevation: 10,
                        child: Container(
                          padding: EdgeInsets.all(10),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.delete_rounded,
                                color: Colors.black,
                                size: 30,
                              ),
                              SizedBox(width: 18),
                              Text(
                                "Delete Account",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  // fontFamily: "Poppins",
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  GestureDetector(
                    onTap: () {
                      AuthMethods().logOut();
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Login(),
                        ),
                      );
                    },
                    child: Container(
                      margin: EdgeInsets.only(
                        right: 12,
                        left: 12,
                      ),
                      height: 70,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        // color: Colors.white,
                      ),
                      child: Material(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        elevation: 10,
                        child: Container(
                          padding: EdgeInsets.all(10),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.arrow_circle_right_outlined,
                                color: Colors.black,
                                size: 30,
                              ),
                              SizedBox(width: 18),
                              Text(
                                "LogOut",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  // fontFamily: "Poppins",
                                ),
                              ),
                            ],
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
}
