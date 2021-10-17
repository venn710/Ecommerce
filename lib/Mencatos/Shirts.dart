
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:fresh/models/product.dart';
import 'package:fresh/screens/Individual.dart';
import 'package:http/http.dart';

import '../util.dart';

class Shirts extends StatefulWidget {
  @override
  ShirtsState createState() => ShirtsState();
}

class ShirtsState extends State<Shirts> {
  int page=1;
  bool _isempty=false;
  List<Product>_finallist=[];
  bool _loader=true;
  bool _loader1=false;
  ScrollController _controller=new ScrollController();
void getprods(int page) async{
    try
    {
      var resp=await get(Uri.parse('https://fresh48.herokuapp.com/Products/Men/Shirt?page=$page'));
      List ress=(jsonDecode(resp.body));
      if(mounted)
      setState(() {
      if(ress.length==0 &&  mp['Shirts']==null)
      _isempty=true;
      else
{      for(var w in ress)
      _finallist.add(
        Product(
         title: w['title'],
         desc: w['description'],
         id: w['id'],
         image: w['image'],
         price: w['price'],
         size: w['size'],
         brand: w['brand'],
         unique_id:w['_id']
          ),
        );  
                mp.update('Shirts', (value) =>_finallist);
        }
        _loader=false;
        _loader1=false;
      });
    }
    on SocketException
    {
      return Future.error("Server Error");
    }
  }
  @override
  void initState() {
    super.initState();
    getprods(1);
    _controller.addListener(() {
      if(_controller.position.pixels==_controller.position.maxScrollExtent && mounted)
      {

        setState(() {
          page=page+1;
          _loader1=true;
        });
        getprods(page);
      }
    });
  }
    @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controller.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child:Column(
        children: [
          Expanded(
            child:(_loader)?Center(child: CircularProgressIndicator()):
    (_isempty)?Center(child: Text("No Products are added")):GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        controller: _controller,
        itemBuilder: (context,ind)
     {
        return GestureDetector(
          onTap: ()=>Navigator.push(context,MaterialPageRoute(builder: (context)
          {
            return Indi(p1:mp['Shirts'][ind]);
          })),
          child: Padding(
    padding: const EdgeInsets.all(8.0),
    child: Container(
      decoration: BoxDecoration(
          borderRadius:BorderRadius.circular(20)
      ),
      height: 800,
      width: 100,
      child: Padding(
          padding: const EdgeInsets.symmetric(vertical:5.0),
          child: Column(
          children: [
            Expanded(flex:10,child:Image.memory(base64Decode(mp['Shirts'][ind].image))),
            Expanded(flex: 1,child:Text(mp['Shirts'][ind].brand)),
            Expanded(flex:1,child: Text(mp['Shirts'][ind].title)),
            Expanded(flex:1,child: Text("₹"+mp['Shirts'][ind].price.toString())),
          ],
    ),
      )
      ),
          ),
        );
      },
      itemCount:_finallist.length,
      )
          
          ),
          Container(
            height: _loader1 ? 50.0 : 0,
            color: Colors.transparent,
            child: Center(
              child: new CircularProgressIndicator(),
            ),
          )
        ],
      )
    );
  }
}