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
  int subtot=0;
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
      print(item['price']);
      subtot=subtot+(item['quantity']*item['price']);
      // print(item['quantity']);
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
          unique_id: item['unique_id'].toString()
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
        child: (_load)?Center(child: CircularProgressIndicator()):Column(
          children: [
            Expanded(
              flex:10,
              child:ListView(
                children:_cartresults.map((e)
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
                                    child: Image.memory(base64Decode(e.image)),
                                  ),),
                                  Expanded(
                                    flex: 4,
                                    child:Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                     Text(e.title),
                                     Text(e.brand),
                                     Text("₹"+((e.price)).toString())
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
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                                FloatingActionButton(
                                                heroTag: 'btn1',
                                                mini: true,
                                                onPressed: ()async
                                                {
                                                  if(e.quant>1)
                                                  {
                                                  var obj={
                                                    "usermail":"vee@email.com",
                                                    "uni_id":e.unique_id,
                                                    "updatedquant":e.quant-1
                                                  };
                                                  var _resu=jsonEncode(obj);
                                                  print(_resu);
                                                  await put(Uri.parse('https://fresh48.herokuapp.com/cart'),body:_resu,headers: {
                                                    "Content-Type": "application/json"
                                                  });
                                                  setState(() {
                                                    e.quant=e.quant-1;     
                                                      subtot=subtot-e.price;                                   
                                                  });
                                                  }
                                                },
                                                child: Icon(Icons.remove,
                                                size: 20,
                                                )),
                                      SizedBox(width:2,),
                                      Text(e.quant.toString(),style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
                                      SizedBox(width:2,),
                                      FloatingActionButton(
                                                heroTag: 'btn2',
                                                mini: true,
                                                onPressed: ()async
                                                {
                                                  var _obj2={
                                                    "usermail":"vee@email.com",
                                                    "uni_id":e.unique_id,
                                                    "updatedquant":e.quant+1
                                                  };
                                                  var _resu=jsonEncode(_obj2);
                                                  print(_resu);
                                                  await put(Uri.parse('https://fresh48.herokuapp.com/cart'),body:_resu,headers: {
                                                    "Content-Type": "application/json"
                                                  });                                              
                                                  setState(() {
                                                    e.quant=e.quant+1;        
                                                    subtot=subtot+e.price;                                 
                                                  });
                                                },
                                                child: Icon(Icons.add)),
                                                ElevatedButton(onPressed: ()async
                                                {
                                                  var _obj3={
                                                    "usermail":"vee@email.com",
                                                     "uni_id":e.unique_id
                                                  };
                                                  var _res3=jsonEncode(_obj3);
                                                  print(_res3);
                                                  await delete(Uri.parse('https://fresh48.herokuapp.com/cart'),body: _res3,headers: {
                                                    "Content-Type": "application/json"
                                                  });
                                                  setState(() {
                                                    print("index is index");
                                                   _cartresults.removeWhere((element) => element.unique_id==e.unique_id);
                                                    subtot=subtot-(e.price)*(e.quant);
                                                  });
                                                  print("Deleted Successfiully");
                                                }, child: Text("DELETE"))
                                ],),
                                Text("Total Price : ₹"+((e.price)*(e.quant)).toString(),style: TextStyle(fontSize: 25),)
                              ],
                            ),
                          ),
                        )
                          ],
                        ) 
                      ),
                    ),
                  );              
                  // Column(
                  //   children: [
                  //     Card(child:Text(e.quant.toString())),
                  //     TextButton(onPressed: (){
                  //       setState(() {
                  //       _cartresults.removeWhere((element) => element.unique_id==e.unique_id);
                  //       });
                  //     }, child:Text("DELETE"))
                  //   ],
                  // );
                }).toList(),
              ) 
              // ListView.builder
              // (
              //   shrinkWrap: true,
              //   itemCount: _cartresults.length,
              //   itemBuilder:(context,index)
              //   {
              //     return Padding(
              //       padding: const EdgeInsets.symmetric(vertical:8),
              //       child: Material(
              //         elevation: 10,
              //         borderRadius: BorderRadius.circular(20),
              //         child: Padding(
              //           padding: const EdgeInsets.symmetric(vertical:10),
              //           child:Column(
              //             children: [
              //             Padding(
              //               padding: const EdgeInsets.all(8.0),
              //               child: Material(
              //                 elevation: 10,
              //                 // color: Colors.teal,
              //                 borderRadius: BorderRadius.circular(20),
              //                 child:Row(
              //                   children: [
              //                     Expanded(
              //                       flex: 3,
              //                       child: Padding(
              //                       padding: const EdgeInsets.all(15.0),
              //                       child: Image.memory(base64Decode(_cartresults[index].image)),
              //                     ),),
              //                     Expanded(
              //                       flex: 4,
              //                       child:Column(
              //                         mainAxisAlignment: MainAxisAlignment.start,
              //                         crossAxisAlignment: CrossAxisAlignment.start,
              //                       children: [
              //                        Text(_cartresults[index].title),
              //                        Text(_cartresults[index].brand),
              //                        Text("₹"+((_cartresults[index].price)).toString())
              //                       ],
              //                     ))
              //                   ],
              //                 ) 
              //                 ),),
              //           Padding(
              //             padding: const EdgeInsets.all(8.0),
              //             child: Material(
              //               // color: Colors.teal[100],
              //               borderRadius:BorderRadius.only(bottomLeft: Radius.circular(20),bottomRight: Radius.circular(20)),
              //               child: Column(
              //                 children: [
              //                   Row(
              //                     children: [
              //                                   FloatingActionButton(
              //                                   heroTag: 'btn1',
              //                                   mini: true,
              //                                   onPressed: ()async
              //                                   {
              //                                     if(fin[index]>1)
              //                                     {
              //                                     var obj={
              //                                       "usermail":"vee@email.com",
              //                                       "uni_id":_cartresults[index].unique_id,
              //                                       "updatedquant":fin[index]-1
              //                                     };
              //                                     var _resu=jsonEncode(obj);
              //                                     print(_resu);
              //                                     await put(Uri.parse('https://fresh48.herokuapp.com/cart'),body:_resu,headers: {
              //                                       "Content-Type": "application/json"
              //                                     });
              //                                     setState(() {
              //                                       if(fin[index]>1)
              //                                       fin[index]=fin[index]-1;     
              //                                         subtot=subtot-_cartresults[index].price;                                   
              //                                     });
              //                                     }
              //                                   },
              //                                   child: Icon(Icons.remove,
              //                                   size: 20,
              //                                   )),
              //                         SizedBox(width:2,),
              //                         Text(fin[index].toString(),style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
              //                         SizedBox(width:2,),
              //                         FloatingActionButton(
              //                                   heroTag: 'btn2',
              //                                   mini: true,
              //                                   onPressed: ()async
              //                                   {
              //                                     var _obj2={
              //                                       "usermail":"vee@email.com",
              //                                       "uni_id":_cartresults[index].unique_id,
              //                                       "updatedquant":fin[index]+1
              //                                     };
              //                                     var _resu=jsonEncode(_obj2);
              //                                     print(_resu);
              //                                     await put(Uri.parse('https://fresh48.herokuapp.com/cart'),body:_resu,headers: {
              //                                       "Content-Type": "application/json"
              //                                     });                                              
              //                                     setState(() {
              //                                       fin[index]=fin[index]+1;        
              //                                       subtot=subtot+_cartresults[index].price;                                 
              //                                     });
              //                                   },
              //                                   child: Icon(Icons.add)),
              //                                   ElevatedButton(onPressed: ()async
              //                                   {
              //                                     var _obj3={
              //                                       "usermail":"vee@email.com",
              //                                        "uni_id":_cartresults[index].unique_id
              //                                     };
              //                                     var _res3=jsonEncode(_obj3);
              //                                     print(_res3);
              //                                     await delete(Uri.parse('https://fresh48.herokuapp.com/cart'),body: _res3,headers: {
              //                                       "Content-Type": "application/json"
              //                                     });

              //                                     // setState(() {
              //                                     setState(() {
              //                                       print("index is $index");
              //                                       _cartresults.removeAt(index);
              //                                       subtot=subtot-(_cartresults[index].price)*(_cartresults[index].quant);
              //                                     });
              //                                     // });
                                                  
              //                                     print("Deleted Successfiully");
              //                                   }, child: Text("DELETE"))
              //                   ],),
              //                   Text("Total Price : ₹"+((_cartresults[index].price)*(fin[index])).toString(),style: TextStyle(fontSize: 25),)
              //                 ],
              //               ),
              //             ),
              //           )
              //             ],
              //           ) 
              //         ),
              //       ),
              //     );
              //   }
              // ),
            ),
            Expanded(child: Row(
              children: [
                Expanded(child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text("SubTotal is\n"+"  ₹"+subtot.toString(),style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),),
                )),
                Expanded(child: ElevatedButton(onPressed: (){},child: Text("PROCEED AND BUY"),)),
              ],
            ))
          ],
        ),
      ),
    );
  }
}