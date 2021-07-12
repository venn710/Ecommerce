import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fresh/models/product.dart';
import 'package:http/http.dart';
class Cart extends StatefulWidget {
  String user;
  Cart({this.user});
  @override
  _CartState createState() => _CartState();
}

class _CartState extends State<Cart> {
  bool _load=true;
  List<Product>_cartresults=[];
  void initState()
  {
    super.initState();
    _cartresults=[];
    getcart();

  }
  void getcart()async
  {
    var response=await get(Uri.parse('https://fresh48.herokuapp.com/cart/${widget.user}'));
    var result=jsonDecode(response.body);
    var prods=result[0]['products'];
    for(var item in prods)
    {
      print(item['brand']);
      _cartresults.add(
        Product(
          brand: item['brand'],
          id: item['id'],
          desc: item['description'],
          image: item['image'],
          price: item['price'],
          size: item['size'],
          title: item['title'],
        )
      );
    }
    print(result[0]['usermail']);
    setState(() {
          _load=false;
        });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: (_load)?Center(child: CircularProgressIndicator()):ListView.builder
        (
          itemCount: _cartresults.length,
          itemBuilder:(context,index)
          {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical:8),
              child: Material(
                elevation: 10,
                borderRadius: BorderRadius.circular(20),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical:10),
                  child: ListTile(
                    leading:Image.memory(base64Decode(_cartresults[index].image)),
                    title: Text(_cartresults[index].brand),
                    subtitle: Text("₹"+_cartresults[index].price.toString()),
                    trailing: Icon(Icons.delete,
                    color: Colors.red,
                    ),
                  ),
                ),
              ),
            );
          }
          
        ),
      ),
    );
  }
}