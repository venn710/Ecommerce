import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fresh/boxes.dart';
import 'package:fresh/models/orders.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Hiveorders extends StatefulWidget {
  @override
  _HiveordersState createState() => _HiveordersState();
}

class _HiveordersState extends State<Hiveorders> {
  bool fl = false;
  bool _load = true;
  @override
  void initState() {
    // BOXES().getorders().deleteAll(BOXES().getorders().keys);
    // TODO: implement initState
    super.initState();
    if (BOXES().getorders().values.length == 0) {
      print("Number2");
      getorders();
    } else {
      _load = false;
    }
  }

  void getorders() async {
    print("Number3");
    String uname;
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    uname = _prefs.getString('email');
    var response =
        await get(Uri.parse('https://fresh48.herokuapp.com/orders/$uname'));
    print('https://fresh48.herokuapp.com/orders/$uname');
    List result = jsonDecode(response.body);
    if (result.length == 0 && mounted) {
      setState(() {
        _load = false;
        fl = true;
      });
    } else {
      var prods = result[0]['products'];
      for (var item in prods) {
        ORDERS _orderitem = ORDERS()
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
        final _orders = BOXES().getorders();
        _orders.add(_orderitem);
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
        ? Scaffold(body: Center(child: (CircularProgressIndicator())))
        : (BOXES().getorders().length == 0)
            ? Scaffold(
                appBar: AppBar(
                  title: Text("ORDERS"),
                  centerTitle: true,
                ),
                body: Center(child: Text("No products are there")))
            : Scaffold(
                appBar: AppBar(
                  title: Text("ORDERS"),
                  centerTitle: true,
                ),
                body: ListView(
                  children: BOXES().getorders().values.map((e) {
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
                                    SizedBox(
                                      height: 4,
                                    ),
                                    Text("Price:${e.price}"),
                                    SizedBox(
                                      height: 4,
                                    ),
                                    Text(
                                      "Total :" +
                                          (e.quant * e.price).toString(),
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  }).toList(),
                ),
              );
  }
}
