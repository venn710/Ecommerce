import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:fresh/login.dart';
import 'package:fresh/register.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:http/http.dart';

class welcome extends StatefulWidget {
  @override
  _welcomeState createState() => _welcomeState();
}

class _welcomeState extends State<welcome> {
  List items = [];
  FirebaseMessaging _fc = FirebaseMessaging.instance;
  @override
  void initState() {
    super.initState();
    _fc.subscribeToTopic('Events');
  }
  void gettoken() async {
    var res = await _fc.getToken(
        vapidKey:
            "BI_Hfdbf-4fW41ksPY8nrV5mAxyibBlPkmFpmgKiq0ApogwWUGnt5ht-9w16dfmTDZ9ezMeZUXvQOBVJdhp422Y");
    var resp = await post(
        Uri.parse('https://fresh48.herokuapp.com/notification/general'));
    print(res);
    _fc.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(40, 80, 160, 1),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Row(
              children: <Widget>[
                Hero(
                  tag: 'logo',
                  child: Container(
                    child: Image.asset('assets/images/online-shopping.png'),
                    height: 200,
                  ),
                ),
                Text(
                  "ECOMMERCE",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
            SizedBox(
              height: 48.0,
            ),
            Buttons(
              rt: '1',
              col: Color.fromRGBO(235, 66, 63, 1),
              name: 'Log In',
            ),
            Buttons(
              rt: '2',
              col: Color.fromRGBO(247, 176, 48, 1),
              name: 'Register',
            ),
          ],
        ),
      ),
    );
  }
}

class Buttons extends StatelessWidget {
  Color col;
  String name;
  String rt;
  Buttons({this.rt, this.col, this.name});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: Material(
        elevation: 5.0,
        color: col,
        borderRadius: BorderRadius.circular(30.0),
        child: MaterialButton(
          onPressed: () {
            if (rt == '1') {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return Login();
              }));
            } else if (rt == '2')
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return Register();
              }));
          },
          minWidth: 200.0,
          height: 42.0,
          child: Text(
            name,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
