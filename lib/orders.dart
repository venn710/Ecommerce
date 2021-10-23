import 'dart:convert';

import 'package:flutter/cupertino.dart';
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
  bool fl=false;
  List<Product>_orderresults=[];
  void initState()
  {
    super.initState();
    getorders();

  }
  void dispose()
  {
    super.dispose();
  }
  void getorders()async
  {

    var response=await get(Uri.parse('https://fresh48.herokuapp.com/orders/${widget.user}'));
    List result=jsonDecode(response.body);
    if(result.length==0 && mounted)
    {
      setState(() {
        _load=false;
        fl=true;
      });
    }
    else{
    var prods=result[0]['products'];
    for(var item in prods)
    {
      _orderresults.add(
        Product(
          brand: item['brand'].toString(),
          id: item['id'].toString(),
          desc: item['description'].toString(),
          image: item['image'].toString(),
          price: item['price'],
          size: item['size'],
          title: item['title'],
          quant: item['quantity']
        )
      );
    }
    print(result[0]['usermail']);
    if(mounted)
    setState(() {
          _load=false;
        });
  }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor:Color.fromRGBO(220, 20, 60, 1),
        title: Text("Orders"),
        centerTitle: true,
      ),
      body: Container(
        child: (_load)?Center(child: CircularProgressIndicator()):
        (fl)?Noorders():ListView(
          children:
          _orderresults.map((e){
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Material(
              borderRadius: BorderRadius.circular(20),
              elevation: 10,
              child: Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: Image.memory(base64Decode(e.image))),
                  Expanded(
                    flex: 4,
                    child: ListTile(
                      title: Text(e.title),
                      subtitle: Text(e.desc),
                      trailing: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Quantity:${e.quant}"),
                          SizedBox(height: 4,),
                          Text("Price:${e.price}"),
                          SizedBox(height: 4,),
                          Text("Total :"+(e.quant*e.price).toString(),style: TextStyle(fontWeight: FontWeight.bold),),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        }).toList(),
        )
      ),
    );
  }
}
class Noorders extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(child: Text("You have no orders"),),
    );
  }
}