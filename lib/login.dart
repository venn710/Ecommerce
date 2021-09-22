import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fresh/address.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:fresh/screens/Homescreen.dart';
import 'package:http/http.dart';
import './util.dart';
import "package:pointycastle/export.dart" as encrypter;
import 'dart:typed_data';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  String mail;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final _form = GlobalKey<FormState>();
  String pass;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            SizedBox(
              height: 50,
            ),
            Container(
                height: MediaQuery.of(context).size.height / 2,
                child: Image.asset('assets/images/online-shopping.png')),
            Form(
                key: _form,
                child: Column(
                  children: [
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
                            mail = value;
                          }
                        },
                        decoration: DECORATION("Enter Your Mail"),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        obscureText: true,
                        style: TextStyle(color: Colors.black),
                        validator: (value) {
                          if (value == null || value.isEmpty)
                            return 'Please Enter required fields';
                          return null;
                        },
                        onChanged: (value) {
                          if (value != null) {
                            pass = value;
                          }
                        },
                        decoration: DECORATION("Enter Your Password"),
                      ),
                    ),
                  ],
                )),
            ElevatedButton(
                onPressed: () async {
                  if (_form.currentState.validate()) {
                    print(pass);
                    print(mail);
                    final passss = pass;
                    var utfdata = utf8.encode(passss);
                    final d = new encrypter.SHA256Digest();
                    var restt = d.process(utfdata);
                    print("Login clicked");
                    try{
                    await _auth.signInWithEmailAndPassword(email: mail, password: pass);
                        final prefs = await SharedPreferences.getInstance();
                     var _res1 = await get(
                        Uri.parse("https://fresh48.herokuapp.com/users"));
                    var bod = jsonDecode(_res1.body);
                    for (var w in bod) {
                      if (w['email'] == mail && w['pass'] == restt.toString()) {
                        prefs.setString('email', mail);
                        prefs.setBool('isadmin', w['isadmin']);
                        Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                        return HomePage();
                        }));
                      }
                      }
                    } 
                    on FirebaseAuthException catch(e){
                      showDialog(context: context, builder: (context){
                        return AlertDialog(
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                          title: Text("Uh-oh!"),
                          // titlePadding: EdgeInsets.all(15),
                          elevation: 10,
                          backgroundColor: Colors.red[200],  
                          actions: [
                            TextButton(onPressed: ()=>Navigator.of(context).pop(), child:Text("try_again",style: TextStyle(fontSize:18,color: Colors.white)))
                          ],
                          content: Text(e.message),
                        );
                      });
                    }
                  }
                },
                child: Text("Log In"))
          ],
        ),
      ),
    );
  }
}
