import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ListScreen extends StatefulWidget {
  @override
  _ListScreenState createState() => _ListScreenState();
}

class _ListScreenState extends State<ListScreen> {
  Color primarycolor = Color(0xff18203d);
  Color secondarycolor = Color(0xff232c51);
  Color logoGreen = Color(0xff25bcbb);

  TextEditingController nameController = TextEditingController();
  TextEditingController brandController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController imageUrlController = TextEditingController();

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

  CollectionReference collectionReference =
      FirebaseFirestore.instance.collection('products');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Products",
          style: TextStyle(color: Colors.green, fontSize: 26),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      backgroundColor: primarycolor,
      body: StreamBuilder(
        stream: collectionReference.snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasData) {
            return ListView(
              children: snapshot.data.docs
                  .map((e) => ListTile(
                        leading: IconButton(
                          icon: Icon(Icons.edit),
                          color: Colors.white,
                          onPressed: () {
                            nameController.text = e['name'];
                            brandController.text = e['brand'];
                            priceController.text = e['price'];
                            imageUrlController.text = e['imageUrl'];

                            showDialog(
                                context: context,
                                builder: (context) => Dialog(
                                      child: Container(
                                        color: primarycolor,
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: ListView(
                                            shrinkWrap: true,
                                            children: <Widget>[
                                              _buildTextField(
                                                  nameController, "Name"),
                                              SizedBox(
                                                height: 20,
                                              ),
                                              _buildTextField(
                                                  brandController, "Brand"),
                                              SizedBox(
                                                height: 20,
                                              ),
                                              _buildTextField(
                                                  priceController, "Price"),
                                              SizedBox(
                                                height: 20,
                                              ),
                                              _buildTextField(
                                                  imageUrlController,
                                                  "Image Url"),
                                              SizedBox(
                                                height: 20,
                                              ),
                                              FlatButton(
                                                child: Text("Update Product",
                                                    style: TextStyle(
                                                        color: Colors.green,
                                                        fontSize: 30)),
                                                onPressed: () async {
                                                  await collectionReference
                                                      .doc(
                                                          '3TAKtiW97fFfzPUoIRwQ')
                                                      .update({
                                                    "name": nameController.text,
                                                    "brand":
                                                        brandController.text,
                                                    "price":
                                                        priceController.text,
                                                    "imageUrl":
                                                        imageUrlController.text,
                                                  }).then((value) =>
                                                          Navigator.pop(
                                                              context));
                                                },
                                              ),
                                              SizedBox(
                                                height: 20,
                                              ),
                                              FlatButton(
                                                child: Text("Delete Product",
                                                    style: TextStyle(
                                                        color: Colors.red,
                                                        fontSize: 30)),
                                                onPressed: () async {
                                                  await collectionReference
                                                      .doc(
                                                          '3TAKtiW97fFfzPUoIRwQ')
                                                      .delete()
                                                      .then((value) =>
                                                          print('delete'));
                                                },
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ));
                          },
                        ),
                        title: Text(
                          e['name'],
                          style: TextStyle(color: Colors.blue),
                        ),
                        subtitle: Column(
                          children: <Widget>[
                            Text(
                              e['brand'],
                              style: TextStyle(color: Colors.orange),
                            ),
                            Text(
                              e['price'],
                              style: TextStyle(color: Colors.green),
                            ),
                          ],
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                        ),
                        trailing: Image.network(
                          e['imageUrl'],
                          height: 50,
                          fit: BoxFit.cover,
                          width: 70,
                        ),
                      ))
                  .toList(),
            );
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
