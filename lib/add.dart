import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fresh/address.dart';
import 'package:http/http.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

class Add extends StatefulWidget {
  @override
  _AddState createState() => _AddState();
}

class _AddState extends State<Add> {
  String baseimage;
  int price;
  String desc;
  String id;
  List<int> imageBytes;
  String base;
  ImageProvider provider;
  String brand;
  int size;
  String dbimage;
  List<String> _mencatos = ["Jeans", "Shirt", "Footwear", "Hoodies", "Others"];
  List<String> _womencatos = [
    "Dresses",
    "Footwear",
    "Jewellary",
    "Handbags",
    "Others"
  ];
  List<String> _options = ["Men", "Women"];
  // String gender;
  String title;
  File image1;
  bool flag = false;
  File image2;
  final picker = ImagePicker();
  final _form1 = GlobalKey<FormState>();
  Future getimage() async {
    final pickedFile = await picker.getImage(
        source: ImageSource.gallery, imageQuality: 50, maxHeight: 500);
    image1 = File(pickedFile.path);
    imageBytes = image1.readAsBytesSync();
    baseimage = base64Encode(imageBytes);
    setState(() {
      image1 = File(pickedFile.path);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: SafeArea(
          child: Container(
            child: ListView(
              children: [
                Form(
                    key: _form1,
                    child: Column(children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          style: TextStyle(color: Colors.black),
                          validator: (value) {
                            if (value == null || value.isEmpty)
                              return 'Please Enter required fields';
                            return null;
                          },
                          onChanged: (value) {
                            if (value != null) {
                              brand = value;
                            }
                          },
                          decoration:
                              DECORATION("Enter Your Product Brand name"),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          style: TextStyle(color: Colors.black),
                          validator: (value) {
                            if (value == null || value.isEmpty)
                              return 'Please Enter required fields';
                            return null;
                          },
                          onChanged: (value) {
                            if (value != null) {
                              desc = value;
                            }
                          },
                          decoration:
                              DECORATION("Enter Your Product Description"),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: DropdownButton<String>(
                          focusColor: Colors.white,
                          value: id,
                          elevation: 5,
                          style: TextStyle(color: Colors.white),
                          iconEnabledColor: Colors.black,
                          items: _options
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(
                                value,
                                style: TextStyle(color: Colors.black),
                              ),
                            );
                          }).toList(),
                          hint: Text(
                            "Please choose gender",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 14,
                                fontWeight: FontWeight.w500),
                          ),
                          onChanged: (String value) {
                            setState(() {
                              this.title = title;
                              this.brand = brand;
                              this.desc = desc;
                              this.id = value;
                              this.price = price;
                              this.size = size;
                            });
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: DropdownButton<String>(
                          focusColor: Colors.white,
                          value: title,
                          elevation: 5,
                          style: TextStyle(color: Colors.white),
                          iconEnabledColor: Colors.black,
                          items: ((id == "Men") ? (_mencatos) : (_womencatos))
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(
                                value,
                                style: TextStyle(color: Colors.black),
                              ),
                            );
                          }).toList(),
                          hint: Text(
                            "Please choose Product type",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 14,
                                fontWeight: FontWeight.w500),
                          ),
                          onChanged: (String value) {
                            setState(() {
                              this.title = value;
                              this.brand = brand;
                              this.desc = desc;
                              this.id = id;
                              this.price = price;
                              this.size = size;
                            });
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          keyboardType: TextInputType.number,
                          style: TextStyle(color: Colors.black),
                          validator: (value) {
                            if (value == null || value.isEmpty)
                              return 'Please Enter required fields';
                            return null;
                          },
                          onChanged: (value) {
                            if (value != null) {
                              price = int.parse(value);
                            }
                          },
                          decoration: DECORATION("Enter Your Product Price"),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          keyboardType: TextInputType.number,
                          style: TextStyle(color: Colors.black),
                          validator: (value) {
                            if (value == null || value.isEmpty)
                              return 'Please Enter required fields';
                            return null;
                          },
                          onChanged: (value) {
                            if (value != null) {
                              size = int.parse(value);
                            }
                          },
                          decoration: DECORATION("Enter Your Product Size"),
                        ),
                      ),
                    ])),
                SafeArea(
                  child: Container(
                    child: Column(
                      children: [
                        image1 == null
                            ? Text("no Image Selected")
                            : Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Image.file(image1),
                              ),
                        // base == null
                        //     ? Text("No image found")
                        //     : Padding(
                        //       padding: const EdgeInsets.all(20.0),
                        //       child: Image.memory(base64Decode(base)),
                        //     ),
                        Center(
                          child: TextButton(
                              onPressed: getimage,
                              child: Icon(Icons.add_a_photo)),
                        ),
                      ],
                    ),
                  ),
                ),
                (flag && _form1.currentState.validate() && image1 != null)
                    ? Center(child: CircularProgressIndicator())
                    : ElevatedButton(
                        onPressed: () async {
                          setState(() {
                            flag = true;
                          });
                          if (_form1.currentState.validate()) {
                            if (image1 == null) {
                              showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(20)),
                                      title: Text("Uh-oh!"),
                                      elevation: 10,
                                      backgroundColor: Colors.red[200],
                                      actions: [
                                        TextButton(
                                            onPressed: () =>
                                                Navigator.of(context).pop(),
                                            child: Text("try_again",
                                                style: TextStyle(
                                                    fontSize: 18,
                                                    color: Colors.white)))
                                      ],
                                      content: Text(
                                          "Try to add the image and try again"),
                                    );
                                  });
                            } else {
                              print(title);
                              print(id);
                              var _obj = {
                                "id": id,
                                "products": {
                                  "id": id,
                                  "brand": brand,
                                  "description": desc,
                                  "image": baseimage,
                                  "size": size,
                                  "title": title,
                                  "price": price
                                }
                              };
                              var _res = jsonEncode(_obj);
                              if (id == "Men") {
                                print("came to men");
                                var resuu = await post(
                                    Uri.parse(
                                      "https://fresh48.herokuapp.com/Men",
                                    ),
                                    body: _res,
                                    headers: {
                                      "Content-Type": "application/json"
                                    });
                                print("posted");
                                setState(() {
                                  flag = false;
                                });
                              } else if (id == 'Women') {
                                var resuu = await post(
                                    Uri.parse(
                                      "https://fresh48.herokuapp.com/Women",
                                    ),
                                    body: _res,
                                    headers: {
                                      "Content-Type": "application/json"
                                    });
                                print("posted");
                                setState(() {
                                  flag = false;
                                });
                              }
                              Navigator.of(context).pop();
                              var _obj1 = {
                                "event": "Events",
                                "title": "New Arrivals",
                                "body": "New Products were added do checkout"
                              };
                              var _respp1 = jsonEncode(_obj1);
                              await post(
                                  Uri.parse(
                                      'https://fresh48.herokuapp.com/notification/general'),
                                  body: _respp1,
                                  headers: {
                                    "Content-Type": "application/json"
                                  });
                              print("sent notification");
                            }
                          }
                        },
                        child: Text("ADD"),
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
