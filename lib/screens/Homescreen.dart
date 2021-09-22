import 'dart:convert';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'package:fresh/add.dart';
import 'package:fresh/address.dart';
import 'package:fresh/cart.dart';
import 'package:fresh/footwear.dart';
import 'package:fresh/orders.dart';
import 'package:fresh/welcome.dart';
import 'package:fresh/women.dart';
import 'package:http/http.dart';
import 'package:mongo_dart/mongo_dart.dart' show Db;
import 'package:pointycastle/digests/sha256.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../men.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String usermail = '';
  bool _loader = false;
  bool isadmin = false;
  List finres;
  void initState() {
    super.initState();
    getauth();
  }

  void getauth() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      usermail = prefs.getString('email');
      isadmin = prefs.getBool('isadmin');
      
    });
  }

  @override
  Widget build(BuildContext context) {
    print(isadmin);
    return Scaffold(
      appBar: AppBar(
        title: Text("EComm"),
        centerTitle: true,
        backgroundColor: Colors.black45,
        elevation: 30,
        toolbarHeight: 60,
        actions: [
          GestureDetector(
              onTap: () {
                (usermail == '')
                    ? null
                    : Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                        return Cart(user: usermail);
                      }));
              },
              child: Image.asset('assets/images/cart3.png'))
        ],
        shape: Border(bottom: BorderSide(style: (BorderStyle.solid))),
      ),
      drawer: Drawer(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(top: 20.0),
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(20),
                      topRight: Radius.circular(20))),
              width: MediaQuery.of(context).size.width / 1.3,
              child: Column(
                children: [
                  (isadmin)
                      ? TextButton(
                          onPressed: () => Navigator.push(context,
                              MaterialPageRoute(builder: (context) => Add())),
                          child: Center(
                            child: Text("Wanna ADD your product"),
                          ))
                      : Container(),
                  GestureDetector(
                      onTap: () => Navigator.of(context).pop(),
                      child: Drawercard(
                        imgpath: 'assets/images/home.png',
                        name: "HOME",
                      )),
                  GestureDetector(
                      onTap: () async {
                        var res = await get(Uri.parse(
                            'https://fresh48.herokuapp.com/address/$usermail'));
                        finres = jsonDecode(res.body);
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return AddressDetails(
                            fun: null,
                            uname: usermail,
                          );
                        }));
                      },
                      child: Drawercard(
                        imgpath: 'assets/images/home-address.png',
                        name: "ADDRESS",
                      )),
                  GestureDetector(
                      onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Orders(user: usermail),
                          )),
                      child: Drawercard(
                        imgpath: 'assets/images/order.png',
                        name: "ORDERS",
                      )),
                  GestureDetector(
                    onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Cart(user: usermail),
                        )),
                    child: Drawercard(
                      imgpath: 'assets/images/carts.png',
                      name: "CART",
                    ),
                  ),
                  GestureDetector(
                    onTap: () async{
                      SharedPreferences prefs = await SharedPreferences.getInstance();
                      prefs.clear();
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (BuildContext context) => welcome(),
                        ),
                        (route) => false,
                      );
                    },
                    child: Drawercard(
                      imgpath: "assets/images/logout.png",
                      name: "LOGOUT",
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
      backgroundColor: Colors.cyan[100],
      body: (_loader)
          ? CircularProgressIndicator()
          : SafeArea(
              child: ListView(
                children: [
                  SizedBox(
                    height: 50,
                  ),
                  CarouselSlider(
                    items: [
                      GestureDetector(
                          onTap: () => Navigator.push(context,
                              MaterialPageRoute(builder: (context) => Men())),
                          child: Carouselcard(
                            imgpath: 'assets/images/beard.png',
                            title: 'MEN',
                          )),
                      GestureDetector(
                          onTap: () => Navigator.push(context,
                              MaterialPageRoute(builder: (context) => Women())),
                          child: Carouselcard(
                            imgpath: 'assets/images/woman.png',
                            title: 'WOMEN',
                          )),
                      GestureDetector(
                          onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Footwear())),
                          child: Carouselcard(
                            imgpath: 'assets/images/footwear.png',
                            title: 'FOOTWEAR',
                          ))
                    ],
                    options: CarouselOptions(
                      height: 220,
                      enlargeCenterPage: true,
                      autoPlay: true,
                      aspectRatio: 16 / 9,
                      autoPlayCurve: Curves.fastOutSlowIn,
                      enableInfiniteScroll: true,
                      autoPlayAnimationDuration: Duration(milliseconds: 800),
                      viewportFraction: 0.8,
                    ),
                  ),
                  Container(
                    child: Card(
                      color: Colors.cyan[200],
                      child: Column(
                        children: [
                          Text(
                            "FASHION",
                            style: TextStyle(
                                fontSize: 30, fontWeight: FontWeight.bold),
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: GestureDetector(
                                    onTap: () => Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => Men())),
                                    child: Container(
                                      height: 200,
                                      decoration: BoxDecoration(
                                          color: Colors.grey[400],
                                          image: DecorationImage(
                                              image: AssetImage(
                                                  'assets/images/beard.png'))),
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: GestureDetector(
                                  onTap: () => Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => Women())),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      height: 200,
                                      decoration: BoxDecoration(
                                          color: Colors.grey[400],
                                          image: DecorationImage(
                                              image: AssetImage(
                                                  'assets/images/woman.png'))),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: GestureDetector(
                                  onTap: () => Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => Footwear())),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      height: 200,
                                      decoration: BoxDecoration(
                                          color: Colors.grey[400],
                                          image: DecorationImage(
                                              image: AssetImage(
                                                  'assets/images/footwear.png'))),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}

class Carouselcard extends StatelessWidget {
  String imgpath;
  String title;
  Carouselcard({this.imgpath, this.title});
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Expanded(
        flex: 5,
        child: Container(
          margin: EdgeInsets.only(left: 6.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.0),
            color: Color.fromRGBO(220, 20, 60, 1),
            image: DecorationImage(
              image: AssetImage(imgpath),
              fit: BoxFit.fill,
            ),
          ),
        ),
      ),
      Expanded(
          child: Text(
        title,
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ))
    ]);
  }
}

class Drawercard extends StatelessWidget {
  String imgpath;
  String name;
  Drawercard({this.imgpath, this.name});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListTile(
          leading: Image.asset(imgpath),
          title: Text(name,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold))),
    );
  }
}
