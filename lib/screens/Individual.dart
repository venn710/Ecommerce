import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fresh/boxes.dart';
import 'package:fresh/cartfin.dart';
import 'package:fresh/models/cart.dart';
import 'package:fresh/models/product.dart';
import 'package:fresh/payments.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

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
        body: SafeArea(
      child: Stack(
        children: [
          Positioned(
            top: 0,
            bottom: MediaQuery.of(context).size.height / 5.2,
            left: 0,
            right: 0,
            child: Container(
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: MemoryImage(base64Decode(widget.p1.image)),
                      fit: BoxFit.cover)),
              width: double.infinity,
            ),
          ),
          Positioned(
            top: MediaQuery.of(context).size.height -
                MediaQuery.of(context).size.height / 3.8,
            bottom: 0,
            left: 0,
            right: 0,
            child: BottomCard(p2: widget.p1),
          )
        ],
      ),
    ));
  }
}

class BottomCard extends StatefulWidget {
  final Product p2;
  BottomCard({this.p2});
  @override
  _BottomCardState createState() => _BottomCardState();
}

class _BottomCardState extends State<BottomCard>{
  int quant = 1;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showModalBottomSheet(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(20),
              ),
            ),
            // enableDrag: true,
            // transitionAnimationController: _controller,
            backgroundColor: Colors.red,
            context: context,
            builder: (context) {
              return Bottsheet(p3: widget.p2);
            });
      },
      child: Material(
        color: Colors.red,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(28),
          topRight: Radius.circular(28),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Center(
                    child: Icon(Icons.arrow_drop_up_sharp,
                        size: 30, color: Colors.white)),
              ),
              Expanded(
                  flex: 2,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'PRICE   :   ' + '₹' + widget.p2.price.toString(),
                      style:
                          TextStyle(fontSize: 25, fontWeight: FontWeight.w600),
                    ),
                  )),
              Expanded(
                  flex: 2,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(widget.p2.brand,
                        style: TextStyle(
                            fontSize: 25, fontWeight: FontWeight.bold)),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}

class Bottsheet extends StatefulWidget {
  final Product p3;
  Bottsheet({this.p3});
  @override
  _BottsheetState createState() => _BottsheetState();
}

class _BottsheetState extends State<Bottsheet> {
  int quant = 1;
  String usermail;
  bool _loader=false;
        void showInSnackbar(BuildContext ctx)
  {
    ScaffoldMessenger.of(ctx).showSnackBar(SnackBar(content: Text('Uh-oh!Seems like you have not added address yet')));
  }
  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20), topRight: Radius.circular(20)),
      color: Colors.red,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'PRICE   :   ' + '₹' + widget.p3.price.toString(),
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.w600),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(widget.p3.brand,
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(widget.p3.desc,
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Text(
                    "Quantity",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800),
                  ),
                ),
                Container(
                  height: 100,
                  child: Row(
                    children: [
                      FloatingActionButton(
                          heroTag: 'btn1',
                          mini: true,
                          onPressed: () {
                            setState(() {
                              if (quant > 1) quant = quant - 1;
                            });
                          },
                          child: Icon(
                            Icons.remove,
                            size: 20,
                          )),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        quant.toString(),
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      FloatingActionButton(
                          heroTag: 'btn2',
                          mini: true,
                          onPressed: () {
                            setState(() {
                              quant = quant + 1;
                            });
                          },
                          child: Icon(Icons.add))
                    ],
                  ),
                )
              ],
            ),
            Row(
              children: [
                Expanded(
                    flex: 5,
                    child: GestureDetector(
                      onTap: () async {
                        var uuid = Uuid();
                      String _obj1=uuid.v1().toString();
                        SharedPreferences prefs =
                        await SharedPreferences.getInstance();
                        usermail=prefs.getString('email');
                        final item=CART()
                        ..title=widget.p3.title
                        ..brand=widget.p3.brand
                        ..desc=widget.p3.desc
                        ..id=widget.p3.id
                        ..image=widget.p3.image
                        ..price=widget.p3.price
                        ..quant=quant
                        ..usermail=prefs.getString('email')
                        ..size=widget.p3.size
                        ..unique_id=_obj1;
                        final box=BOXES().getcart(); 
                        box.add(item);
                        setState(() {
                          _loader=true;
                        });
                        var _obj = {
                          "usermail": prefs.getString('email'),
                          "products": {
                            "quantity": quant,
                            "brand": widget.p3.brand,
                            "id": widget.p3.id,
                            "description": widget.p3.desc,
                            "image": widget.p3.image,
                            "size": widget.p3.size,
                            "title": widget.p3.title,
                            "price": widget.p3.price,
                            "unique_id":_obj1
                          }
                        };
                        var _res = jsonEncode(_obj);
                        // print(_res);
                        await post(
                            Uri.parse(
                              'https://fresh48.herokuapp.com/cart',
                            ),
                            body: _res,
                            headers: {"Content-Type": "application/json"});
                            setState(() {
                              _loader=false;
                            });
                            showDialog(context: context, builder:(ctx)
                            {
                              return AlertDialog(
                                content: Text("Product Added to Cart"),
                                actions:[
                                  TextButton(onPressed: ()async{
                            SharedPreferences prefs =await SharedPreferences.getInstance();
                            Navigator.push(context,MaterialPageRoute(builder: (context)
                            {
                              return Cart(user: prefs.getString('email'),); 
                            }));    
                                  }, child: Text("Go to Cart")),
                                  TextButton(onPressed: (){
                                    Navigator.of(context).pop();
                                  }, child: Text("Continue Shopping")),

                                ]
                              );
                            });
                            // showInSnackbar(context);
                        print("cart posted");
                      },
                      child: Material(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(30),
                        child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ListTile(
                              leading: Image.asset("assets/images/cart3.png",
                                  fit: BoxFit.contain, scale: 1.4),
                              title: Text("Add To Cart",
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w700)),
                            )),
                      ),
                    )),
                Expanded(
                    flex: 5,
                    child: GestureDetector(
                      onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Paymants(
                                    finprods: [
                                      CART(
                                          brand: widget.p3.brand,
                                          desc: widget.p3.desc,
                                          price: widget.p3.price,
                                          title: widget.p3.title,
                                          id: widget.p3.id,
                                          image: widget.p3.image,
                                          size: widget.p3.size,
                                          quant: quant,
                                          unique_id: Uuid().v1(),
                                          usermail:usermail,
                                          )
                                    ],
                                    number_of_products: quant,
                                    total_amount: (widget.p3.price) * (quant),
                                  ))),
                      child: Material(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(30),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ListTile(
                            leading: ColorFiltered(
                                colorFilter: ColorFilter.mode(
                                    Colors.white70, BlendMode.darken),
                                child: Image.asset(
                                  "assets/images/buy.gif",
                                  fit: BoxFit.contain,
                                )),
                            title: Center(
                                child: Text(
                              "Buy Now",
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.w700),
                            )),
                          ),
                        ),
                      ),
                    ))
              ],
            ),
            _loader?Center(child: CircularProgressIndicator()):Container()
          ],
        ),
      ),
    );
  }
}
