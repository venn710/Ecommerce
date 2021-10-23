import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';

class AddressForm extends StatefulWidget {
  Function payment;
  String uname;
  AddressForm({this.payment, this.uname});
  @override
  _AddressFormState createState() => _AddressFormState();
}

class _AddressFormState extends State<AddressForm> {
  final _formKey = GlobalKey<FormState>();
  bool _loader2 = false;
  String hno, state, district, mobileno, name, village;
  @override
  Widget build(BuildContext context) {
    return (_loader2)
        ? Scaffold(
            body: Center(child: CircularProgressIndicator()),
          )
        : SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: ListView(children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "IT seems you have not added any address add now",
                    textAlign: TextAlign.center,
                  ),
                ),
                Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        TextFormField(
                          style: TextStyle(color: Colors.black),
                          validator: (value) {
                            if (value == null || value.isEmpty)
                              return 'Please Enter required fields';
                            return null;
                          },
                          onChanged: (value) {
                            if (value != null) {
                              hno = value;
                            }
                          },
                          decoration: DECORATION("Enter Your H NO"),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          style: TextStyle(color: Colors.black),
                          validator: (value) {
                            if (value == null || value.isEmpty)
                              return 'Please Enter required fields';
                            return null;
                          },
                          onChanged: (value) {
                            if (value != null) {
                              name = value;
                            }
                          },
                          decoration: DECORATION("Enter Your Name"),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          style: TextStyle(color: Colors.black),
                          validator: (value) {
                            if (value == null || value.isEmpty)
                              return 'Please Enter required fields';
                            return null;
                          },
                          onChanged: (value) {
                            if (value != null) {
                              mobileno = value;
                            }
                          },
                          decoration: DECORATION("Enter Your Mobile number"),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          style: TextStyle(color: Colors.black),
                          validator: (value) {
                            if (value == null || value.isEmpty)
                              return 'Please Enter required fields';
                            return null;
                          },
                          onChanged: (value) {
                            if (value != null) {
                              village = value;
                            }
                          },
                          decoration: DECORATION("Enter Your villagename"),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          style: TextStyle(color: Colors.black),
                          validator: (value) {
                            if (value == null || value.isEmpty)
                              return 'Please Enter required fields';
                            return null;
                          },
                          onChanged: (value) {
                            if (value != null) {
                              district = value;
                            }
                          },
                          decoration: DECORATION("Enter Your District Name"),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          style: TextStyle(color: Colors.black),
                          validator: (value) {
                            if (value == null || value.isEmpty)
                              return 'Please Enter required fields';
                            return null;
                          },
                          onChanged: (value) {
                            if (value != null) {
                              state = value;
                            }
                          },
                          decoration: DECORATION("Enter Your State"),
                        )
                      ],
                    )),
                Container(
                  child: ElevatedButton(
                    child: (widget.payment==null)?Text("Save"):Text("Save and PAY"),
                    onPressed: () async {
                      if (_formKey.currentState.validate()) {
                        setState(() {
                          _loader2 = true;
                        });
                        var _obj = {
                          "usermail": widget.uname,
                          "address": {
                            "HNO": hno,
                            "Village": village,
                            "State": state,
                            "District": district,
                            "Mobile NUmber": mobileno,
                            "Name": name
                          }
                        };
                        var _res = jsonEncode(_obj);
                        print(_res);
                        var resss = await post(
                            Uri.parse(
                              'https://fresh48.herokuapp.com/address',
                            ),
                            body: _res,
                            headers: {"Content-Type": "application/json"});
                        print("ADDRESS posted");
                        setState(() {
                          _loader2=false;
                        });
                        if(widget.payment==null)
                        Navigator.of(context).pop();
                        else
                        widget.payment();
                      }
                    },
                  ),
                ),
              ]),
            ),
          );
  }
}

InputDecoration DECORATION(String text) {
  return InputDecoration(
    hintText: text,
    hintStyle: TextStyle(color: Colors.black),
    contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(32.0)),
    ),
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.blueAccent, width: 1.0),
      borderRadius: BorderRadius.all(Radius.circular(32.0)),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.blueAccent, width: 2.0),
      borderRadius: BorderRadius.all(Radius.circular(32.0)),
    ),
  );
}
