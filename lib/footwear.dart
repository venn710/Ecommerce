import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fresh/models/product.dart';
import 'package:fresh/screens/Individual.dart';
import 'package:fresh/util.dart';
import 'package:http/http.dart';

class Footwear extends StatefulWidget {
  @override
  _FootwearState createState() => _FootwearState();
}

class _FootwearState extends State<Footwear> {
  List<Product>_finalproducts=[];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getfootwear();
  }
  getfootwear()async{
    if(mp['Footwear']==null)
    {
      print("Mennnnnnnnnn");
      var _res1= await get(Uri.parse('https://fresh48.herokuapp.com/products/Men/Footwear'));
      var _resp1=jsonDecode(_res1.body);
      _finalproducts.add(
        Product(
         title: _resp1[0]['title'],
         desc: _resp1[0]['description'],
         id: _resp1[0]['id'],
         image: _resp1[0]['image'],
         price: _resp1[0]['price'],
         size: _resp1[0]['size'],
         brand: _resp1[0]['brand'],
         unique_id:_resp1[0]['_id']
       )
      );
    }
    if(wp['Footwear']==null)
    {
      print("WoMennnnnnnnnn");
      var _res2= await get(Uri.parse('https://fresh48.herokuapp.com/products/Women/Footwear'));
      var _resp2=jsonDecode(_res2.body);
      // print(_resp2);
      _finalproducts.add(
        Product(
         title: _resp2[0]['title'],
         desc: _resp2[0]['description'],
         id: _resp2[0]['id'],
         image: _resp2[0]['image'],
         price: _resp2[0]['price'],
         size: _resp2[0]['size'],
         brand: _resp2[0]['brand'],
         unique_id:_resp2[0]['_id']
       )
      );
    }
  }
  @override
  Widget build(BuildContext context) {
    return (_finalproducts.length==0)?CircularProgressIndicator():GridView.builder(
      gridDelegate:SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: 2,
        ),
        itemCount: _finalproducts.length,
      itemBuilder:(context,ind2)
      {
        return GestureDetector(
          onTap: ()=>Navigator.push(context,MaterialPageRoute(builder: (context)
          {
            return Indi(p1:_finalproducts[ind2]);
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
            // Expanded(flex: 1,child:Text(wp[_catos[_finindex]][ind1].unique_id)),
            // Expanded(flex:1,child: Text(wp[_catos[_finindex]][ind1].title)),
            // Expanded(flex:10,child:Image.memory(base64Decode(wp[_catos[_finindex]][ind1].image))
              // ),
          ],
    ),
      )
      ),
          ),
        );
      }
      );
  }
}