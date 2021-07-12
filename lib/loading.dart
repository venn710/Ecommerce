import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fresh/util.dart';
import 'package:fresh/welcome.dart';
import 'package:http/http.dart';
import 'package:mongo_dart/mongo_dart.dart' show Db,DbCollection;
class Loading extends StatefulWidget {
  @override
  _LoadingState createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getdata();
  }
  void getdata() async
  {
  Navigator.pushReplacement(context,MaterialPageRoute(builder: (context)=>welcome()));
  }
  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(
        backgroundColor: Colors.red,
      )
      
    );
  }
}