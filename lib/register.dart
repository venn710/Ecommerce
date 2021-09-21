import 'dart:convert';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fresh/login.dart';
import 'package:fresh/screens/Homescreen.dart';
import 'package:fresh/women.dart';
import 'package:http/http.dart';
import 'package:pointycastle/digests/sha256.dart';
import 'package:shared_preferences/shared_preferences.dart';
import './util.dart';
// import 'package:mongo_dart/mongo_dart.dart';
class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final _auth=FirebaseAuth.instance;
  @override
  void initState() {
    super.initState();
    getauth();

  }
  void getauth()async
  {
   await Firebase.initializeApp;
  }
  @override
  Widget build(BuildContext context) {
    String pass;
    String mail;
    return Scaffold(
      body: Column(
        children:
        [      
          SizedBox(
            height: 200,
          ),
          TextField(
          style: TextStyle(color:Colors.black),
          textAlign: TextAlign.center,
          onChanged: (value) {
            mail=value;
          },
          decoration: InputDecoration(
            
            hintText: 'Enter your mail',
            hintStyle: TextStyle(color:Colors.black),
            contentPadding:
                EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
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
          ),
        ),    
          TextField(
          obscureText: true,
          style: TextStyle(color:Colors.black),
          textAlign: TextAlign.center,
          onChanged: (value) {
            pass=value;
          },
          decoration: InputDecoration(
            hintText: 'Enter your password',
            hintStyle: TextStyle(color:Colors.black),
            contentPadding:
                EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
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
          ),
        ),
          ElevatedButton
          (
            child:Text("register"),
            onPressed:() async
            {
              print(mail);
              print(pass);
  var user = await _auth.createUserWithEmailAndPassword(
    email: mail,
    password: pass,
  );
  if(user!=null)
  {
    print("VERIFIED");
            final passss=pass;
            var utfdata=utf8.encode(passss);
            final d=new SHA256Digest();
            var _restt=d.process(utfdata);
              var _obj={
                'email':mail,
                'pass':_restt.toString(),
                'isadmin':false,
                'address':{}
                };
               var _res=jsonEncode(_obj);
                var resuu=await post(Uri.parse("https://fresh48.herokuapp.com/user",),body:_res,headers: {
              "Content-Type": "application/json"
               });
    print("doneeeeeeeeeeeeeeeeeeeeeeeeeeeeee");
        final prefs = await SharedPreferences.getInstance();
        prefs.setString('email',mail);
    if(mail!=null && pass!=null)
      Navigator.push(context,MaterialPageRoute(builder: (context)
      {
return HomePage();
      }));
      else
      print("NULLLLLLLLLLLLLLLLLLLLLLLLL");
  }

  else
  print("NOT VERIFIEd");
          }
          
          )
        ]
      ),
      
    );
  }
}