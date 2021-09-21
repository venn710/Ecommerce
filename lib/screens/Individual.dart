import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:fresh/models/product.dart';
import 'package:fresh/payments.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Indi extends StatefulWidget {
  final Product p1;
  Indi({this.p1});
  @override
  _IndiState createState() => _IndiState();
}

class _IndiState extends State<Indi> {

  // Uint8List bytes = base64Deco
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.cyan,
          body:SafeArea(
            child: Stack(
              children: [
                Positioned(
                  top: 0,
                  bottom: MediaQuery.of(context).size.height/3,
                  left:0,
                  right:0,
                  child: Container(
                    decoration: BoxDecoration(
                      image:DecorationImage(
                        image:
                        // AssetImage(widget.p1.image),
                        MemoryImage(base64Decode(widget.p1.image)),
                        fit: BoxFit.cover
                      )
                    ),
                    width: double.infinity,
                  ),
                ),
                Positioned(
                  top:MediaQuery.of(context).size.height-MediaQuery.of(context).size.height/2.3,
                  bottom: 0,
                  left:0,
                  right:0,
                  child: BottomCard(p2:widget.p1),
                )
              ],
              
            ),
          )
    );
  }
}


class BottomCard extends StatefulWidget {
  final Product p2;
  BottomCard({this.p2});
  @override
  _BottomCardState createState() => _BottomCardState();
}

class _BottomCardState extends State<BottomCard> {
    int quant=1;
  @override
  Widget build(BuildContext context) {
    return Material(
                    color: Colors.red,
                    borderRadius:BorderRadius.only(
                      topLeft: Radius.circular(28),
                      topRight: Radius.circular(28),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                            Expanded(
                            flex:2,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text('PRICE   :   '+'₹'+widget.p2.price.toString(),style: TextStyle(fontSize: 25,fontWeight: FontWeight.w600),),
                            )),
                        Expanded(
                          flex: 2,
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Text(widget.p2.title,style:TextStyle(fontSize: 25,fontWeight: FontWeight.bold)),
                              ),
                        ),
                          Expanded(
                            flex: 2,
                            child: Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Text(widget.p2.brand,style:TextStyle(fontSize: 25,fontWeight: FontWeight.bold)),
                          )),
                        Expanded(
                          flex: 2,
                          child: Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Text(widget.p2.desc,style:TextStyle(fontSize: 15,fontWeight: FontWeight.bold)),
                          )),
                        Expanded(
                          flex: 2,
                          child: Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal:8.0),
                                child: Text("Quantity",style: TextStyle(fontSize:20,fontWeight: FontWeight.w800),),
                              ),
                              Container(
                                height: 100,
                                child: Row(
                                  children: [
                                    FloatingActionButton(
                                      heroTag: 'btn1',
                                      mini: true,
                                      onPressed: ()
                                      {
                                        setState(() {
                                          if(quant>1)
                                          quant=quant-1;                                        
                                        });
                                      },
                                      child: Icon(Icons.remove,
                                      size: 20,
                                      )),
                                      SizedBox(width: 10,),
                                    Text(quant.toString(),style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
                                    SizedBox(width: 10,),
                                    FloatingActionButton(
                                      heroTag: 'btn2',
                                      mini: true,
                                      onPressed: ()
                                      {
                                        setState(() {
                                          quant=quant+1;                                        
                                        });
                                      },
                                      child: Icon(Icons.add))
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                        Expanded(
                          flex: 3,
                          child: Row(
                            children: [
                              Expanded(
                                flex:5,
                                child:GestureDetector(
                                  onTap:() async
                                  {
                                    SharedPreferences prefs = await SharedPreferences.getInstance();
                                    var _obj={
                                      "usermail":prefs.getString('email'),
                                      "products":
                                        {
                                      "quantity":quant,
                                      "brand":widget.p2.brand,"id":widget.p2.id,"description":widget.p2.desc,"image":widget.p2.image,"size":widget.p2.size,"title":widget.p2.title,"price":widget.p2.price
                                        }
                                    };
                                      var _res=jsonEncode(_obj);
                                      // print(_res);
                                      await post(Uri.parse('https://fresh48.herokuapp.com/cart',),body:_res,headers: {
                                        "Content-Type": "application/json"
                                      });
                                      print("cart posted");
                                  },
                                  child: Material(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(30),child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: ListTile(
                                    leading:Image.asset("assets/images/cart3.png",fit: BoxFit.contain,scale: 1.4),
                                    title: Text("Add To Cart",style:TextStyle(fontSize:18,fontWeight: FontWeight.w700)),
                                  )
                                  ),),
                                )),
                              Expanded(
                                flex: 5,
                                child:GestureDetector(
                                  onTap: ()=>Navigator.push(context,MaterialPageRoute(builder: (context)=>Paymants(data:widget.p2))),
                                  child: Material(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(30),child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: ListTile(  
                                    leading:ColorFiltered(
                                      colorFilter: ColorFilter.mode(Colors.white70,BlendMode.darken),
                                      child: Image.asset("assets/images/buy.gif",fit: BoxFit.contain,)),
                                    title: Center(child: Text("Buy Now",style: TextStyle(fontSize:18,fontWeight: FontWeight.w700),)),
                                  
                                  ),
                                  ),),
                                ))
                            ],
                          ),
                        )
                      ],
                    ),
                  );
  }
}