import 'package:flutter/material.dart';
import 'package:fresh/loading.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:fresh/screens/Homescreen.dart';
import 'package:fresh/welcome.dart';
import 'package:shared_preferences/shared_preferences.dart';
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var _email=prefs.getString('email');
  runApp(MyApp(tar:_email==null));
}
class MyApp extends StatelessWidget {
  final bool tar;
  MyApp({this.tar});
  @override
  Widget build(BuildContext context){
    return MaterialApp(
      debugShowCheckedModeBanner: false,
        home:(tar)?welcome():HomePage()
      );
  }
}
