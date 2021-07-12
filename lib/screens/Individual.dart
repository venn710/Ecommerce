import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:fresh/models/product.dart';
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
                        // colorFilter: ColorFilter.mode()),
                        // mode(                          
                          // Colors.blue,BlendMode.colorBurn),
                        image:MemoryImage(base64Decode(widget.p1.image)),
                        fit: BoxFit.cover
                      )
                    ),
                    width: double.infinity,
                  ),
                ),
                Positioned(
                  top:MediaQuery.of(context).size.height-MediaQuery.of(context).size.height/2.4,
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
                      children: [
                        Expanded(
                          child: Column(
                            children: [
                              Text(widget.p2.title),
                              Text(widget.p2.brand)
                            ],
                          ),
                        ),
                        Expanded(child: Text(widget.p2.desc)),
                        Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Text("Quantity"),
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
                                    Text(quant.toString()),
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
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                Expanded(
                                  flex:5,
                                  child:Material(borderRadius: BorderRadius.circular(30),child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: ListTile(
                                    leading:Image.asset("assets/images/cart3.png",fit: BoxFit.contain,scale: 1.4),
                                    title: Text("Add to Cart"),
                                  )
                                ),)),
                                Expanded(
                                  flex: 5,
                                  child:GestureDetector(
                                    onTap: ()
                                    {
                                      print("ji");
                                    },
                                    child: Material(borderRadius: BorderRadius.circular(30),child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: ListTile(  
                                      leading:Image.asset("assets/images/buy.gif",fit: BoxFit.contain,),
                                      title: Text("Buy Now"),
                                    
                                    ),
                                ),),
                                  ))
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  );
  }
}