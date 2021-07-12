import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:fresh/screens/Homescreen.dart';
import 'package:fresh/server.dart';
import 'package:http/http.dart';
import './util.dart';
class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    String mail;
    String pass;
    return Scaffold(
      body: Column(
        children: [
                    SizedBox(
            height: 200,
          ),
                    TextField(
          style: TextStyle(color:Colors.black),
          textAlign: TextAlign.center,
          onChanged: (value) {
            mail=value;

            //Do something with the user input.
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
            //Do something with the user input.
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
        ElevatedButton(onPressed:()async
        {
          String _email;
          String _pass;
          print("Login clicked");
          var _res1=await get(Uri.parse("https://fresh48.herokuapp.com/users"));
          var bod=jsonDecode(_res1.body);
          for(var w in bod)
          {
            if(w['email']==mail && w['pass']==pass)
          {
            final prefs = await SharedPreferences.getInstance();
            prefs.setString('email',mail);
            prefs.setString('pass', pass);           
          Navigator.push(context,MaterialPageRoute(builder: (context)
          {
            return HomePage();
          }));
          }
          else
          continue;
          }
          print("Enter COrrect Details");
        } ,
         child: Text("Log In"))
        ],
      ),
    );
  }
}