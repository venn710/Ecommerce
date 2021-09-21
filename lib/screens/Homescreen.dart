import 'dart:convert';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:fresh/add.dart';
import 'package:fresh/cart.dart';
import 'package:fresh/footwear.dart';
import 'package:fresh/women.dart';
import 'package:mongo_dart/mongo_dart.dart' show Db;
import 'package:pointycastle/digests/sha256.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../men.dart';
class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String usermail='';
  void initState()
  {
    super.initState();
    getauth();
  }
  void getauth()async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
    usermail=prefs.getString('email');          
        });

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("EComm"),centerTitle: true,
      backgroundColor: Colors.black45,
      elevation: 30,
      toolbarHeight: 60,
      actions: [
        GestureDetector(
          onTap: ()
          {
            (usermail=='')?null:Navigator.push(context,MaterialPageRoute(builder: (context)
            {
              return Cart(user:usermail);
            }));
          },
          child: Image.asset('assets/images/cart3.png'))
      ],
      shape: Border(
bottom: BorderSide(style:(BorderStyle.solid))
      ),
      ),
      drawer: Drawer(
        child: SafeArea(
          child:Padding(
            padding: const EdgeInsets.only(top:20.0),
            child: Container(
              decoration:BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(bottomRight: Radius.circular(20),topRight: Radius.circular(20))
            ),
            width:MediaQuery.of(context).size.width/1.3,
            child:Column(
            children: [
              Text(usermail),
              TextButton(
                onPressed: ()=>Navigator.push(context,MaterialPageRoute(builder: (context)=>Add())),
                child: Center(child: Text("Wanna ADD your product"),)),
                
            ],
          ),
            ),
            ), 
        ),
      ),
backgroundColor: Colors.cyan[100],
      body:SafeArea(
              child: ListView(
          children: [
            Container(
              color: Colors.cyan[100],
              height:60,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    GestureDetector(
                      onTap: (){
                        final passss="venn@213ghjkjmb1";
            var utfdata=utf8.encode(passss);
            print(utfdata);
            final d=new SHA256Digest();
            var restt=d.process(utfdata);
            // var decdata=utf8.decode(restt);
            // print(decdata);
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30),
                        child: Column(children: [Icon(Icons.all_inbox),Text("ALL")]),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      child: Column(children: [Icon(Icons.all_inbox),Text("Men")]),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      child: Column(children: [Icon(Icons.all_inbox),Text("Women")]),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      child: Column(children: [Icon(Icons.all_inbox),Text("Electronics")]),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      child: Column(children: [Icon(Icons.all_inbox),Text("Furniture")]),
                    ),
                  ],
              ),
                ),
            ),
            CarouselSlider(
              items: [
                Container(
                margin: EdgeInsets.only(left:6.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                  image: DecorationImage(
                    image: AssetImage('assets/images/bat.jpg'),
                    fit: BoxFit.fill,
                  ),
                ),
              ),
                Container(
                margin: EdgeInsets.all(6.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                  image: DecorationImage(
                    image: AssetImage('assets/images/dress1.jfif'),
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              ],
              options: CarouselOptions(
              height: 180.0,
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
                Text("FASHION",style: TextStyle(
                  fontSize: 30,fontWeight: FontWeight.bold
                ),),
                Row(
                  children: [
                    Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: GestureDetector(
                            onTap:()=>Navigator.push(context,MaterialPageRoute(builder:(context)=>Men())),
                            child: Container(
                              height: 200,
                            decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          bottomRight:Radius.circular(80),
                          bottomLeft: Radius.elliptical(20,50)),
                        color: Colors.grey[400],
                          image:DecorationImage(
                            image: AssetImage('assets/images/bat.jpg')) 
                      ),
                            child: Text("For men"),
                      ),
                          ),
                        ),
                    ),
                    Expanded(
                    child: GestureDetector(
                        onTap: ()=>Navigator.push(context,MaterialPageRoute(builder:(context)=>Women())),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                          height: 200,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          bottomRight:Radius.elliptical(20,50),
                          bottomLeft: Radius.circular(80)),
                        color: Colors.grey[400],
                          image:DecorationImage(
                            image: AssetImage('assets/images/bat.jpg')) 
                      ),
                      child: Text("For women"),
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
                          onTap: ()=>Navigator.push(context,MaterialPageRoute(builder: (context)=>Footwear())),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              height: 200,
                            decoration:  BoxDecoration(
                          borderRadius: BorderRadius.only(
                            bottomRight:Radius.circular(80),
                            bottomLeft: Radius.elliptical(20,50)),
                          color: Colors.grey[400],
                            image:DecorationImage(
                              image: AssetImage('assets/images/bat.jpg')) 
                                              ),
                            child: Text("Footwear"),
                                              ),
                          ),
                        ),
                    ),
                    Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            height: 200,
                          decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          bottomRight:Radius.elliptical(20,50),
                          bottomLeft: Radius.circular(80)),
                        color: Colors.grey[400],
                          image:DecorationImage(
                            image: AssetImage('assets/images/bat.jpg')) 
                      ),
                          child: Text("Furniture"),
                      ),
                        ),
                    )
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