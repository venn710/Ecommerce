import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fresh/models/product.dart';
import 'package:fresh/payments.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Cart extends StatefulWidget {
  String user;
  Cart({this.user});
  @override
  _CartState createState() => _CartState();
}

class _CartState extends State<Cart> {
  bool _load = true;
  int subtot = 0;
  int _quant = 1;
  SharedPreferences _prefs;
  List<int> fin = [];
  List<Product> _cartresults = [];
  bool fl = false;
  void initState() {
    super.initState();
    _cartresults = [];
    getcart();
  }

  void dispose() {
    super.dispose();
  }

  void getcart() async {
    var response = await get(
        Uri.parse('https://fresh48.herokuapp.com/cart/${widget.user}'));
    print("https://fresh48.herokuapp.com/cart/${widget.user}");
    List result = jsonDecode(response.body);
    if (result.length == 0 && mounted) {
      setState(() {
        _load = false;
        fl = true;
      });
    } else {
      var prods = result[0]['products'];
      for (var item in prods) {
        fin.add(item['quantity']);
        print(item['quantity']);
        print(item['price']);
        subtot = subtot + (item['quantity'] * item['price']);
        _cartresults.add(Product(
            quant: item['quantity'],
            brand: item['brand'].toString(),
            id: item['id'].toString(),
            desc: item['description'].toString(),
            image: item['image'].toString(),
            price: item['price'],
            size: item['size'],
            title: item['title'],
            unique_id: item['unique_id'].toString()));
      }
      print(result[0]['usermail']);
      if (mounted)
        setState(() {
          _load = false;
        });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Cart"),
        centerTitle: true,
        backgroundColor: Color.fromRGBO(220, 20, 60, 0.6),
      ),
      body: Container(
        child: (_load)
            ? Center(child: CircularProgressIndicator())
            : (fl)
                ? Noitems()
                : Column(
                    children: [
                      Expanded(
                          flex: 10,
                          child: ListView(
                            children: _cartresults.map((e) {
                              return Padding(
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
                                            padding: const EdgeInsets.all(8.0),
                                            child: Material(
                                                elevation: 10,
                                                // color: Colors.teal,
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
                                                          base64Decode(e.image),
                                                          gaplessPlayback: true,
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
                                            padding: const EdgeInsets.all(8.0),
                                            child: Material(
                                              // color: Colors.teal[100],
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
                                                          heroTag: Text('btn1'),
                                                          mini: true,
                                                          onPressed: () async {
                                                            _prefs =
                                                                await SharedPreferences
                                                                    .getInstance();
                                                            if (e.quant > 1) {
                                                              var obj = {
                                                                "usermail": _prefs
                                                                    .getString(
                                                                        'email'),
                                                                "uni_id":
                                                                    e.unique_id,
                                                                "updatedquant":
                                                                    e.quant - 1
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
                                                              if (mounted)
                                                                setState(() {
                                                                  e.quant =
                                                                      e.quant -
                                                                          1;
                                                                  subtot =
                                                                      subtot -
                                                                          e.price;
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
                                                                FontWeight.bold,
                                                            fontSize: 20),
                                                      ),
                                                      SizedBox(
                                                        width: 2,
                                                      ),
                                                      FloatingActionButton(
                                                          heroTag: Text('btn2'),
                                                          mini: true,
                                                          onPressed: () async {
                                                            _prefs =
                                                                await SharedPreferences
                                                                    .getInstance();
                                                            var _obj2 = {
                                                              "usermail": _prefs
                                                                  .getString(
                                                                      'email'),
                                                              "uni_id":
                                                                  e.unique_id,
                                                              "updatedquant":
                                                                  e.quant + 1
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
                                                            if (mounted)
                                                              setState(() {
                                                                e.quant =
                                                                    e.quant + 1;
                                                                subtot =
                                                                    subtot +
                                                                        e.price;
                                                              });
                                                          },
                                                          child:
                                                              Icon(Icons.add)),
                                                      ElevatedButton(
                                                          onPressed: () async {
                                                            var _obj3 = {
                                                              "usermail":
                                                                  widget.user,
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
                                                                _cartresults.removeWhere(
                                                                    (element) =>
                                                                        element
                                                                            .unique_id ==
                                                                        e.unique_id);
                                                                subtot = subtot -
                                                                    (e.price) *
                                                                        (e.quant);
                                                              });
                                                            print(
                                                                "Deleted Successfiully");
                                                          },
                                                          child: Text("DELETE"))
                                                    ],
                                                  ),
                                                  Text(
                                                    "Total Price : ₹" +
                                                        ((e.price) * (e.quant))
                                                            .toString(),
                                                    style:
                                                        TextStyle(fontSize: 25),
                                                  )
                                                ],
                                              ),
                                            ),
                                          )
                                        ],
                                      )),
                                ),
                              );
                            }).toList(),
                          )),
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
                                print(_cartresults.length);
                                for (var w in _cartresults)
                                  _num = _num + w.quant;
                                return Paymants(
                                  finprods: _cartresults,
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
                  ),
      ),
    );
  }
}

class Noitems extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text("You have no items in the cart"),
      ),
    );
  }
}
