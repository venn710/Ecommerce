import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fresh/boxes.dart';
import 'package:fresh/models/cart.dart';
import 'package:fresh/payments.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TESTINGCART extends StatefulWidget {
  @override
  _TESTINGCARTState createState() => _TESTINGCARTState();
}

class _TESTINGCARTState extends State<TESTINGCART> {
  int subtot = 0;
  bool fl = false;
  bool _load = true;
  @override
  void initState() {
    super.initState();
    print("Number1");
    if (BOXES().getcart().values.length == 0) {
      print("Number2");
      getcart();
    } else {
      _load = false;
      for (var i in BOXES().getcart().values)
        subtot = subtot + (i.quant * i.price);
    }
  }

  void getcart() async {
    print("Number3");
    String uname;
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    uname = _prefs.getString('email');
    var response =
        await get(Uri.parse('https://fresh48.herokuapp.com/cart/$uname'));
    print("https://fresh48.herokuapp.com/cart/$uname");
    List result = jsonDecode(response.body);
    print(result);
    if (result.length == 0 && mounted) {
      setState(() {
        _load = false;
        fl = true;
      });
    } else {
      var prods = result[0]['products'];
      for (var item in prods) {
        subtot = subtot + (item['quantity'] * item['price']);
        print(subtot);
        CART _cartitem = CART()
          ..brand = item['brand']
          ..desc = item['description']
          ..id = item['id']
          ..image = item['image']
          ..price = item['price']
          ..quant = item['quantity']
          ..size = item['size']
          ..title = item['title']
          ..unique_id = item['unique_id']
          ..usermail = uname;
        final _cart = BOXES().getcart();
        _cart.add(_cartitem);
      }
      if (mounted)
        setState(() {
          _load = false;
        });
    }
  }

  @override
  Widget build(BuildContext context) {
    return (_load)
        ? Scaffold(body: Center(child: CircularProgressIndicator()))
        : (BOXES().getcart().length == 0)
            ? Scaffold(
              appBar: AppBar(
                title: Text("CART"),
                centerTitle: true,
              ),              
              body: Center(child: Text("No products are there")))
            : Scaffold(
              appBar: AppBar(
                title: Text("CART"),
                centerTitle: true,
              ),
                body: SafeArea(
                    child: Column(
                children: [
                  Expanded(
                    flex: 10,
                    child: ListView(
                        children: BOXES()
                            .getcart()
                            .values
                            .map((e) => Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 8),
                                  child: Material(
                                    elevation: 10,
                                    borderRadius: BorderRadius.circular(20),
                                    child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 10),
                                        child: Column(
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Material(
                                                  elevation: 10,
                                                  borderRadius:
                                                      BorderRadius.circular(20),
                                                  child: Row(
                                                    children: [
                                                      Expanded(
                                                        flex: 3,
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(15.0),
                                                          child: Image.memory(
                                                            base64Decode(
                                                                e.image),
                                                            gaplessPlayback:
                                                                true,
                                                          ),
                                                        ),
                                                      ),
                                                      Expanded(
                                                          flex: 4,
                                                          child: Column(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .start,
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Text(e.title),
                                                              Text(e.brand),
                                                              Text("₹" +
                                                                  ((e.price))
                                                                      .toString())
                                                            ],
                                                          ))
                                                    ],
                                                  )),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Material(
                                                borderRadius: BorderRadius.only(
                                                    bottomLeft:
                                                        Radius.circular(20),
                                                    bottomRight:
                                                        Radius.circular(20)),
                                                child: Column(
                                                  children: [
                                                    Row(
                                                      children: [
                                                        FloatingActionButton(
                                                            heroTag:
                                                                Text('btn1'),
                                                            mini: true,
                                                            onPressed:
                                                                () async {
                                                              if (mounted)
                                                                setState(() {
                                                                  if (e.quant >
                                                                      1) {
                                                                    e.quant =
                                                                        e.quant -
                                                                            1;
                                                                    subtot =
                                                                        subtot -
                                                                            e.price;
                                                                  }
                                                                });

                                                              if (e.quant >=
                                                                  1) {
                                                                var obj = {
                                                                  "usermail": e
                                                                      .usermail,
                                                                  "uni_id": e
                                                                      .unique_id,
                                                                  "updatedquant":
                                                                      e.quant
                                                                };
                                                                var _resu =
                                                                    jsonEncode(
                                                                        obj);
                                                                print(_resu);
                                                                await put(
                                                                    Uri.parse(
                                                                        'https://fresh48.herokuapp.com/cart'),
                                                                    body: _resu,
                                                                    headers: {
                                                                      "Content-Type":
                                                                          "application/json"
                                                                    });
                                                              }
                                                            },
                                                            child: Icon(
                                                              Icons.remove,
                                                              size: 20,
                                                            )),
                                                        SizedBox(
                                                          width: 2,
                                                        ),
                                                        Text(
                                                          e.quant.toString(),
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              fontSize: 20),
                                                        ),
                                                        SizedBox(
                                                          width: 2,
                                                        ),
                                                        FloatingActionButton(
                                                            heroTag:
                                                                Text('btn2'),
                                                            mini: true,
                                                            onPressed:
                                                                () async {
                                                              if (mounted)
                                                                setState(() {
                                                                  e.quant =
                                                                      e.quant +
                                                                          1;
                                                                  subtot =
                                                                      subtot +
                                                                          e.price;
                                                                });
                                                              var _obj2 = {
                                                                "usermail":
                                                                    e.usermail,
                                                                "uni_id":
                                                                    e.unique_id,
                                                                "updatedquant":
                                                                    e.quant
                                                              };
                                                              var _resu =
                                                                  jsonEncode(
                                                                      _obj2);
                                                              print(_resu);
                                                              await put(
                                                                  Uri.parse(
                                                                      'https://fresh48.herokuapp.com/cart'),
                                                                  body: _resu,
                                                                  headers: {
                                                                    "Content-Type":
                                                                        "application/json"
                                                                  });
                                                            },
                                                            child: Icon(
                                                                Icons.add)),
                                                        ElevatedButton(
                                                            onPressed:
                                                                () async {
                                                              var _obj3 = {
                                                                "usermail":
                                                                    e.usermail,
                                                                "uni_id":
                                                                    e.unique_id
                                                              };
                                                              var _res3 =
                                                                  jsonEncode(
                                                                      _obj3);
                                                              print(_res3);
                                                              await delete(
                                                                  Uri.parse(
                                                                      'https://fresh48.herokuapp.com/cart'),
                                                                  body: _res3,
                                                                  headers: {
                                                                    "Content-Type":
                                                                        "application/json"
                                                                  });
                                                              if (mounted)
                                                                setState(() {
                                                                  subtot=subtot-(e.quant*e.price);
                                                                  e.delete();
                                                                });
                                                              print(
                                                                  "Deleted Successfiully");
                                                            },
                                                            child:
                                                                Text("DELETE"))
                                                      ],
                                                    ),
                                                    Text(
                                                      "Total Price : ₹" +
                                                          ((e.price) *
                                                                  (e.quant))
                                                              .toString(),
                                                      style: TextStyle(
                                                          fontSize: 25),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            )
                                          ],
                                        )),
                                  ),
                                ))
                            .toList()),
                  ),
                  Expanded(
                      child: Row(
                    children: [
                      Expanded(
                          child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "SubTotal is\n" + "  ₹" + subtot.toString(),
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.bold),
                        ),
                      )),
                      Expanded(
                          child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            var _num = 0;
                            print(BOXES().getcart().values.length);
                            for (var w in BOXES().getcart().values)
                              _num = _num + w.quant;
                            return Paymants(
                              finprods:BOXES().getcart().values.toList(),
                              number_of_products: _num,
                              total_amount: subtot,
                            );
                          }));
                        },
                        child: Text("PROCEED AND BUY"),
                      )),
                    ],
                  ))
                ],
              )));
  }
}
