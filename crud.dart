import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fireb/listScreen.dart';
import 'package:flutter/material.dart';

class Crud extends StatefulWidget {
  @override
  _CrudState createState() => _CrudState();
}

class _CrudState extends State<Crud> {
  Color primarycolor = Color(0xff18203d);
  Color secondarycolor = Color(0xff232c51);
  Color logoGreen = Color(0xff25bcbb);

  TextEditingController nameController = TextEditingController();
  TextEditingController brandController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController imageUrlController = TextEditingController();

  Map<String, dynamic> productToAdd;
  CollectionReference collectionReference =
      FirebaseFirestore.instance.collection("products");

  addProduct() {
    productToAdd = {
      "name": nameController.text,
      "brand": brandController.text,
      "price": priceController.text,
      "imageUrl": imageUrlController.text,
    };

    collectionReference
        .add(productToAdd)
        .whenComplete(() => print('Added to the Database'));
  }

  _buildTextField(TextEditingController controller, String labelText) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
          color: secondarycolor, border: Border.all(color: Colors.blue)),
      child: TextField(
        controller: controller,
        style: TextStyle(color: Colors.white),
        decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(horizontal: 10),
            labelText: labelText,
            labelStyle: TextStyle(color: Colors.white),
            border: InputBorder.none),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.folder_open, color: Colors.blue),
            onPressed: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (_) => ListScreen()));
            },
          )
        ],
      ),
      backgroundColor: primarycolor,
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            Text("Mobile",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 28,
                ),
                textAlign: TextAlign.center),
            SizedBox(
              height: 50,
            ),
            _buildTextField(nameController, "Name"),
            SizedBox(
              height: 20,
            ),
            _buildTextField(brandController, "Brand"),
            SizedBox(
              height: 20,
            ),
            _buildTextField(priceController, "Price"),
            SizedBox(
              height: 20,
            ),
            _buildTextField(imageUrlController, "Image Url"),
            SizedBox(
              height: 20,
            ),
            FlatButton(
              child: Text("Add Product",
                  style: TextStyle(color: Colors.green, fontSize: 30)),
              onPressed: () {
                addProduct();
              },
            ),
          ],
        ),
      ),
    );
  }
}
