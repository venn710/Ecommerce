import 'package:flutter/material.dart';
import 'package:fresh/login.dart';
import 'package:fresh/register.dart';
class welcome extends StatefulWidget {
  @override
  _welcomeState createState() => _welcomeState();
}

class _welcomeState extends State<welcome> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
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
                    child: Image.asset('assets/images/bat.jpg'),
                    height: 200,
                  ),
                ),
                Text("Flash Chat"),
              ],
            ),
            SizedBox(
              height: 48.0,
            ),
            Buttons(rt:'1',col: Colors.grey[900],name: 'Log In',),
            Buttons(rt:'2',col: Colors.blueAccent,name: 'Register',),
           
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
Buttons({this.rt,this.col,this.name});
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
            if(rt=='1')
            {
              Navigator.push(context,MaterialPageRoute(builder: (context)
              {
                return Login();
              }));
            }
            else if(rt=='2')
            Navigator.push(context,MaterialPageRoute(builder: (context)
            {
              return Register();
            }));
          },
          minWidth: 200.0,
          height: 42.0,
          child: Text(
            name,
          ),
        ),
      ),
    );
  }
}
