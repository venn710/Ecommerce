import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fresh/models/product.dart';
import 'package:http/http.dart';
class Orders extends StatefulWidget {
  String user;
  Orders({this.user});
  @override
  _OrdersState createState() => _OrdersState();
}

class _OrdersState extends State<Orders> {
  bool _load=true;
  List<Product>_orderresults=[];
  void initState()
  {
    super.initState();
    getorders();

  }
  void getorders()async
  {

    var response=await get(Uri.parse('https://fresh48.herokuapp.com/orders/${widget.user}'));
    // print("https://fresh48.herokuapp.com/cart/${widget.user}");
    var result=jsonDecode(response.body);
    var prods=result[0]['products'];
    for(var item in prods)
    {
      // String brand=item['image'];
      // print(brand);
      _orderresults.add(
        Product(
          brand: item['brand'].toString(),
          id: item['id'].toString(),
          desc: item['description'].toString(),
          image: item['image'].toString(),
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
          itemCount: _orderresults.length,
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
                    // leading:Image.memory(base64Decode(_orderresults[index].image)),
                    title: Text(_orderresults[index].brand),
                    subtitle: Text("₹"+_orderresults[index].price.toString()),
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