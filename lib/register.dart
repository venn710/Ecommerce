import 'dart:convert';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fresh/addressform.dart';
import 'package:fresh/screens/Homescreen.dart';
import 'package:http/http.dart';
import 'package:pointycastle/digests/sha256.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import 'package:mongo_dart/mongo_dart.dart';
class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final _form = GlobalKey<FormState>();
  String _val;
  String pass;
  String mail;
  List<String> options = ['Customer', 'Admin'];
  bool _loader = false;
  final _auth = FirebaseAuth.instance;
  @override
  void initState() {
    super.initState();
    getauth();
  }

  void getauth() async {
    await Firebase.initializeApp;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(children: [
          SizedBox(
            height: 50,
          ),
          Container(
            height: MediaQuery.of(context).size.height / 2,
            child: Image.asset('assets/images/online-shopping.png'),
          ),
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
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: DropdownButton<String>(
              focusColor: Colors.white,
              value: _val,
              elevation: 5,
              style: TextStyle(color: Colors.white),
              iconEnabledColor: Colors.black,
              items: options.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(
                    value,
                    style: TextStyle(color: Colors.black),
                  ),
                );
              }).toList(),
              hint: Text(
                "Please choose Registration type",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                    fontWeight: FontWeight.w500),
              ),
              onChanged: (String value) {
                setState(() {
                  this._val = value;
                  this.mail = mail;
                  this.pass = pass;
                });
              },
            ),
          ),
          (_loader)
              ? CircularProgressIndicator()
              : ElevatedButton(
                  child: Text("register"),
                  onPressed: () async {
                    print(mail);
                    print(pass);
                    if (_form.currentState.validate()) {
                      setState(() {
                        _loader = true;
                      });
                      try {
                        var user = await _auth.createUserWithEmailAndPassword(
                            email: mail, password: pass);
                        if (user != null) {
                          final passss = pass;
                          var utfdata = utf8.encode(passss);
                          final d = new SHA256Digest();
                          var _restt = d.process(utfdata);
                          var _obj = {
                            'email': mail,
                            'pass': _restt.toString(),
                            'isadmin': (_val == null || _val == 'Customer')
                                ? false
                                : true,
                            'address': {}
                          };
                          var _res = jsonEncode(_obj);
                          var resuu = await post(
                              Uri.parse(
                                "https://fresh48.herokuapp.com/user",
                              ),
                              body: _res,
                              headers: {"Content-Type": "application/json"});
                          final prefs = await SharedPreferences.getInstance();
                          prefs.setString('email', mail);
                          prefs.setBool(
                              'isadmin',
                              (_val == null || _val == 'Customer')
                                  ? false
                                  : true);
                        }
                        if (mail != null && pass != null)
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return HomePage();
                          }));
                        setState(() {
                          _loader = false;
                        });
                      } on FirebaseAuthException catch (e) {
                        setState(() {
                          _loader = false;
                        });
                        showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20)),
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
                                content: Text(e.message),
                              );
                            });
                      }
                    }
                  })
        ]),
      ),
    );
  }
}
