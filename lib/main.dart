import 'dart:io';

import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:fresh/models/Hiveaddress.dart';
// import 'package:fresh/models/addresses.dart';
import 'package:fresh/models/cart.dart';
import 'package:fresh/models/orders.dart';
import 'package:fresh/screens/Homescreen.dart';
import 'package:fresh/welcome.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  Directory dir=await getExternalStorageDirectory();
  await Hive.init(dir.path);
  Hive.registerAdapter(CARTAdapter());
  Hive.registerAdapter(ADDRESSAdapter());
  Hive.registerAdapter(ORDERSAdapter());
  await Hive.openBox<CART>('carts');
  await Hive.openBox<ADDRESS>('addresses');
  await Hive.openBox<ORDERS>('orders');
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
