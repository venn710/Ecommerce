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
  int _quant=1;
  List<int> fin=[];
  List<Product>_cartresults=[];
  void initState()
  {
    super.initState();
    _cartresults=[];
    getcart();

  }
  void getcart()async
  {

    var response=await get(Uri.parse('https://fresh48.herokuapp.com/cart/vee@email.com'));
    print("https://fresh48.herokuapp.com/cart/${widget.user}");
    var result=jsonDecode(response.body);
    var prods=result[0]['products'];
    // print(prods);
    for(var item in prods)
    {
      fin.add(item['quantity']);
      print(item['quantity']);
      // String brand=item['image'];[]
      // print(brand);
      _cartresults.add(
        Product(
          quant: item['quantity'],
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
                  child:Column(
                    children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Material(
                        elevation: 10,
                        // color: Colors.teal,
                        borderRadius: BorderRadius.circular(20),
                        child:Row(
                          children: [
                            Expanded(
                              flex: 3,
                              child: Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Image.memory(base64Decode(_cartresults[index].image)),
                            ),),
                            Expanded(
                              flex: 4,
                              child:Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                               Text(_cartresults[index].title),
                               Text(_cartresults[index].brand),
                               Text("₹"+((_cartresults[index].price)).toString())
                              ],
                            ))
                          ],
                        ) 
                        ),),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Material(
                      // color: Colors.teal[100],
                      borderRadius:BorderRadius.only(bottomLeft: Radius.circular(20),bottomRight: Radius.circular(20)),
                      child: ButtonBar(
                        // alignment: MainAxisAlignment.end,
                        children: [
                                      FloatingActionButton(
                                      heroTag: 'btn1',
                                      mini: true,
                                      onPressed: ()
                                      {
                                        setState(() {
                                          if(fin[index]>1)
                                          fin[index]=fin[index]-1;                                        
                                        });
                                      },
                                      child: Icon(Icons.remove,
                                      size: 20,
                                      )),
                            SizedBox(width:2,),
                            Text(fin[index].toString(),style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
                            SizedBox(width:2,),
                            FloatingActionButton(
                                      heroTag: 'btn2',
                                      mini: true,
                                      onPressed: ()
                                      {
                                        setState(() {
                                          fin[index]=fin[index]+1;                                        
                                        });
                                      },
                                      child: Icon(Icons.add)),
                            Text("Total Price : ₹"+((_cartresults[index].price)*(fin[index])).toString(),style: TextStyle(fontSize: 25),)
                      ],),
                    ),
                  )
                    ],
                  ) 
                ),
              ),
            );
          }
          
        ),
      ),
    );
  }
}