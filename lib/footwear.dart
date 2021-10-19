import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fresh/models/product.dart';
import 'package:fresh/screens/Individual.dart';
import 'package:fresh/util.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';

class FinFootwear extends StatefulWidget {
  @override
  _FinFootwearState createState() => _FinFootwearState();
}

class _FinFootwearState extends State<FinFootwear> {
  List<Product> _finalproducts = [];
  List<Product> _temp = [];
  List<Product> _temp1 = [];
  bool _loader = true;
  @override
  void initState() {
    super.initState();
    getfootwear();
    // print(mp['Footwear'].length);
  }

  @override
  void dispose() {
    _temp = [];
    _temp1 = [];
    super.dispose();
  }

  getfootwear() async {
    if (mp['Footwear'] == null) {
      print("Mennnnnnnnnn");
      var _res1 = await get(
          Uri.parse('https://fresh48.herokuapp.com/products/Men/Footwear'));
      var _resp1 = jsonDecode(_res1.body);
      for (var data in _resp1) {
          _temp.add(Product(
              title: data['title'],
              desc: data['description'],
              id: data['id'],
              image: data['image'],
              price: data['price'],
              size: data['size'],
              brand: data['brand'],
              unique_id: data['_id']));
      }
      setState(() {
              mp.update("Footwear", (value) => _temp);
              // _finalproducts.addAll(mp['Footwear']);
      });
    }
    if(wp['Footwear'] == null) {
      print("WoMennnnnnnnnn");
      var _res2 = await get(
          Uri.parse('https://fresh48.herokuapp.com/products/Women/Footwear'));
      var _resp2 = jsonDecode(_res2.body);
        for (var _data in _resp2) {
          _temp1.add(Product(
              title: _data['title'],
              desc: _data['description'],
              id: _data['id'],
              image: _data['image'],
              price: _data['price'],
              size: _data['size'],
              brand: _data['brand'],
              unique_id: _data['_id']));
        }
        setState(() {
          wp.update("Footwear", (value) => _temp1);
          // _finalproducts.addAll(wp['Footwear']);
        });
    } 
    if(mp['Footwear']!=null){
      print("came here");
      if (mounted)
        setState(() {
          _loader = false;
          print(mp['Footwear'].length);
          _finalproducts.addAll(mp['Footwear']);
          print("length is_${_finalproducts.length}");
        });
    }
      if(wp['Footwear']!=null){
      print("came here");
      if (mounted)
        setState(() {
          _loader = false;
          print(mp['Footwear'].length);
          _finalproducts.addAll(wp['Footwear']);
          // _finalproducts.addAll(mp['Footwear']);
          print("length is_${_finalproducts.length}");
        });
    }
    setState(() {
      _loader = false;
    });
    print("length is_${_finalproducts.length}");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: (_loader)
            ? Center(child: CircularProgressIndicator())
            : SafeArea(
                child: Column(
                  children: [
                    Expanded(
                        child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "FOOTWEAR",
                        style: TextStyle(
                            color: Color.fromRGBO(220, 60, 20, 1),
                            fontSize: 30,
                            fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      ),
                    )),
                    (_finalproducts.length == 0)
                        ? Expanded(
                            flex: 10,
                            child:
                                Center(child: (Text("No Products are added"))))
                        : Expanded(
                            flex: 10,
                            child: GridView.builder(
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                ),
                                itemCount: _finalproducts.length,
                                itemBuilder: (context, ind2) {
                                  return GestureDetector(
                                    onTap: () => Navigator.push(context,
                                        MaterialPageRoute(builder: (context) {
                                      return Indi(p1: _finalproducts[ind2]);
                                    })),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Container(
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(20)),
                                          height: 800,
                                          width: 100,
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 5.0),
                                            child: Column(
                                              children: [
                                                Expanded(
                                                    flex: 10,
                                                    child: Image.memory(
                                                        base64Decode(
                                                            _finalproducts[ind2]
                                                                .image))),
                                                Expanded(
                                                    flex: 1,
                                                    child: Text(
                                                        _finalproducts[ind2]
                                                            .brand)),
                                                Expanded(
                                                    flex: 1,
                                                    child: Text(
                                                        _finalproducts[ind2]
                                                            .title)),
                                                Expanded(
                                                    flex: 1,
                                                    child: Text("₹" +
                                                        _finalproducts[ind2]
                                                            .price
                                                            .toString())),
                                              ],
                                            ),
                                          )),
                                    ),
                                  );
                                }),
                          ),
                  ],
                ),
              ));
  }
}
