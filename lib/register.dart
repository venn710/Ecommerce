import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fresh/screens/Homescreen.dart';
import 'package:fresh/women.dart';
import './util.dart';
import './server.dart';
// import 'package:mongo_dart/mongo_dart.dart';
class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final _auth=FirebaseAuth.instance;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // getauth();

  }
  // void getauth()async
  // {
  //  await Firebase.initializeApp;
  // }
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
          ElevatedButton
          (
            child:Text("register"),
            onPressed:() async
            {
  var user = await _auth.createUserWithEmailAndPassword(
    email: mail,
    password: pass,
  );
  // var res=user.user.emailVerified;
  if(user!=null)
  {
    print("VERIFIED");
    print("start done");
    var coll=onlydb.collection('users');
    print("fetchimg done");
    await coll.save({
      'id':user.user.uid,
      'email':mail,
      'pass':pass
      }

    );
      print("doneeeeeeeeeeeeeeeeeeeeeeeeeeeeee");
      Navigator.push(context,MaterialPageRoute(builder: (context)
      {
return HomePage();
      }));
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