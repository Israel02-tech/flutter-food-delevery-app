import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery_app/service/database.dart';
import 'package:food_delivery_app/widget/widget_support.dart';
import 'package:image_picker/image_picker.dart';
import 'package:random_string/random_string.dart';

class AddFood extends StatefulWidget {
  const AddFood({super.key});

  @override
  State<AddFood> createState() => _AddFoodState();
}

class _AddFoodState extends State<AddFood> {
  final List<String> Items = [
    "Icecream",
    "Pizza",
    "Salad",
    "Burger",
  ];
  String? value;
  TextEditingController itemnamecontroller = new TextEditingController();
  TextEditingController itempricecontroller = new TextEditingController();
  TextEditingController itemdetailcontroller = new TextEditingController();
  bool isLoading = false;

  final ImagePicker _picker = ImagePicker();
  File? selectedImage;
//Create the function for the Image Picker
  Future getImage() async {
    var image = await _picker.pickImage(source: ImageSource.gallery);
    selectedImage = File(image!.path);
    setState(() {});
  }

// Creating the function to save the Item Information to the Firebase Storage
  uploadItem() async {
    if (selectedImage != null &&
        itemnamecontroller.text != "" &&
        itempricecontroller.text != "" &&
        itemdetailcontroller != "") {
      setState(() {
        isLoading = true;
      });
      String addId = randomAlphaNumeric(10);

      Reference firebaseStorageRef =
          FirebaseStorage.instance.ref().child("blogImages").child(addId);
      final UploadTask task = firebaseStorageRef.putFile(selectedImage!);

      var downloadUrl = await (await task).ref.getDownloadURL();

      Map<String, dynamic> addItemDetails = {
        "Image": downloadUrl,
        "Name": itemnamecontroller.text,
        "Price": itempricecontroller.text,
        "Detail": itemdetailcontroller.text,
      };
      await DatabaseMethods()
          .addFoodItemDetail(addItemDetails, value!)
          .then((value) async {
        setState(() {
          isLoading = true;
        });
        // Setting the variables to null and empty, so that after adding an item and it has been succesfully then the input field and the image field becomes empty,so we can add more product wihout having to refresh the page
        selectedImage = null;
        itemnamecontroller.text = "";
        itemdetailcontroller.text = "";
        itempricecontroller.text = "";
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            backgroundColor: Colors.orangeAccent,
            content: Text(
              "Food Item has been Added Successfully",
              style: TextStyle(fontSize: 20.0),
            ),
          ),
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back_ios_new_rounded,
            color: Color(0xFF373866),
          ),
        ),
        centerTitle: true,
        title: Text(
          "Add Item",
          style: Appwidget.HeaderTextFieldStyle(),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin:
              EdgeInsets.only(left: 20.0, right: 20.0, top: 20.0, bottom: 50.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Upload the Item Picture",
                style: Appwidget.SemiBoldTextFieldStyle(),
              ),
              SizedBox(height: 20.0),
              selectedImage == null
                  ? GestureDetector(
                      onTap: () {
                        getImage();
                      },
                      child: Center(
                        child: Material(
                          elevation: 5.0,
                          borderRadius: BorderRadius.circular(20),
                          child: Container(
                            width: 150,
                            height: 150,
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.black,
                                width: 1.5,
                              ),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Icon(
                              Icons.camera_alt_outlined,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                    )
                  : Center(
                      child: Material(
                        elevation: 5.0,
                        borderRadius: BorderRadius.circular(20),
                        child: Container(
                          width: 150,
                          height: 150,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.black,
                              width: 1.5,
                            ),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: Image.file(
                              selectedImage!,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                    ),
              SizedBox(height: 30.0),
              Text(
                "Item Name",
                style: Appwidget.SemiBoldTextFieldStyle(),
              ),
              SizedBox(height: 10.0),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: Color(0xFFececf8),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: TextField(
                  controller: itemnamecontroller,
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "Enter the Item Name",
                      hintStyle: Appwidget.LightTextFieldStyle()),
                ),
              ),
              SizedBox(height: 30.0),
              Text(
                "Item Price",
                style: Appwidget.SemiBoldTextFieldStyle(),
              ),
              SizedBox(height: 10.0),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: Color(0xFFececf8),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: TextField(
                  controller: itempricecontroller,
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "Enter the Item Price",
                      hintStyle: Appwidget.LightTextFieldStyle()),
                ),
              ),
              SizedBox(height: 30.0),
              Text(
                "Item Detail",
                style: Appwidget.SemiBoldTextFieldStyle(),
              ),
              SizedBox(height: 10.0),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: Color(0xFFececf8),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: TextField(
                  controller: itemdetailcontroller,
                  maxLines: 6,
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "Enter the Item Detail",
                      hintStyle: Appwidget.LightTextFieldStyle()),
                ),
              ),
              SizedBox(height: 30),
              Text(
                "Item Category",
                style: Appwidget.SemiBoldTextFieldStyle(),
              ),
              SizedBox(
                height: 10.0,
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                width: MediaQuery.of(context).size.width /
                    0.8, // Adjust width here
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 226, 226, 226),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    items: Items.map(
                      (item) => DropdownMenuItem(
                        value: item,
                        child: Text(
                          item,
                          style: TextStyle(
                            fontSize: 18.0,
                            fontFamily: "Poppins",
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ).toList(),
                    onChanged: (value) => setState(() {
                      this.value = value;
                    }),
                    dropdownColor: Colors.white,
                    hint: Text(
                      'Select Category',
                      style: Appwidget.LightTextFieldStyle(),
                    ),
                    iconSize: 36,
                    icon: Icon(
                      Icons.arrow_drop_down_rounded,
                      color: Colors.black,
                    ),
                    value: value,
                  ),
                ),
              ),
              SizedBox(height: 25),
              GestureDetector(
                onTap: () {
                  uploadItem();
                },
                child: Center(
                  child: Material(
                    elevation: 6.0,
                    borderRadius: BorderRadius.circular(10),
                    child: Container(
                      width: MediaQuery.of(context).size.width / 2,
                      padding: EdgeInsets.symmetric(vertical: 12),
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(
                        child: Text(
                          "Add",
                          style: TextStyle(
                            fontFamily: "Poppins",
                            fontSize: 22,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
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
}
