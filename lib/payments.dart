import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fresh/models/product.dart';
import 'package:http/http.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';
class Paymants extends StatefulWidget {
  Product data;
  Paymants({this.data});
  @override
  _PaymantsState createState() => _PaymantsState();
}

class _PaymantsState extends State<Paymants> {
  String hno,state,district,mobileno,name,village;
      SharedPreferences _Prefs;
  final _formKey = GlobalKey<FormState>();
  Razorpay _razorpay;
  bool fl;
  bool _loader=true;
  List resp1=[];
  @override
  void initState() {
    super.initState();
    _razorpay=Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS,paymentsuccesshandler);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR,paymentfailurehandler);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET,externaleventhandler);
    getaddress();
  }
  void getaddress()async{
    var res=await get(Uri.parse('https://fresh48.herokuapp.com/address/testingforaddressfin10@gmail.com'));
    resp1=jsonDecode(res.body);
    print("###################################################################");
    if(resp1.length==0)
    setState(() {
      fl=true;
      _loader=false;
    });
    else
    setState(() {
      fl=false;
      _loader=false;
    });
    print(resp1);
    print("###################################################################");
  }
  void paymentsuccesshandler(PaymentSuccessResponse res) async
  {
    final FlutterSecureStorage storage = FlutterSecureStorage();
    await storage.deleteAll();
      print(res.orderId);
      print(res.paymentId);
      print(res.signature);
      _Prefs= await SharedPreferences.getInstance();
      var _obj={
      "usermail":_Prefs.getString('email'),
      "products":[
      {
      "brand":widget.data.brand,"id":widget.data.id,"description":widget.data.desc,"image":widget.data.image,"size":widget.data.size,"title":widget.data.title,"price":widget.data.price
      }
      ]
      };
      var _res=jsonEncode(_obj);
      print(_res);
      await post(Uri.parse('https://fresh48.herokuapp.com/orders',),body:_res,headers: {
      "Content-Type": "application/json"
      });
      print("ORDER PllllllACED");
  

  }
  void paymentfailurehandler(PaymentFailureResponse res1)
  {
      print(res1);
  }
  void externaleventhandler(ExternalWalletResponse res3)
  {
      print(res3);
  }
    void _pay()async
  {
    String basicAuth ='Basic ' + base64Encode(utf8.encode('rzp_test_2o37GOSgU8fnii:WrIvOYWzLz1PcTEXfEr5z7Ff'));
    _Prefs= await SharedPreferences.getInstance();
    var url = "https://api.razorpay.com/v1/orders";
    var response=await http.post(Uri.parse(url),   
    headers: {"content-type":"application/json","authorization":basicAuth},
    body:jsonEncode({
    "amount": (widget.data.price)*100,
    "currency": "INR",
    "receipt": "rcptid_2021"
  }),
    );
var res1=await jsonDecode(response.body)['id'];
var res2=(res1.toString());
var img=(base64Decode(widget.data.image)).toString();
    var options=
    {
      'key':'rzp_test_2o37GOSgU8fnii',
      'name':widget.data.title,
      'description':widget.data.desc,
      'order_id':res2,
      'theme':
      {
        'hide_topbar':true,
        'color':'#66f4eb',

      },
      'prefill':
      {
        'email':_Prefs.getString('email')
      },
    };
    try
    {
      _razorpay.open(options);
    }
    catch(e)
    {
      print(e);
    }
  }
   @override
  void dispose() {
    super.dispose();
    _razorpay.clear();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: (_loader)?CircularProgressIndicator():SafeArea(
        child: (fl)?ListView(
          children: [
            Text("IT seems you have not added any address addd now"),
            Form(
              key: _formKey,
              child:Column(
              children: [
          TextFormField(
          style: TextStyle(color:Colors.black),
          textAlign: TextAlign.center,
          validator: (value)
          {
            if(value==null || value.isEmpty)
            return 'Please Enter required fields';
            return null;
          },
          onChanged: (value) {
            if(value!=null){
              hno=value;
            }
            //Do something with the user input.
          },
          decoration: DECORATION("Enter Your H NO"),
        ),
                  TextFormField(
          style: TextStyle(color:Colors.black),
          textAlign: TextAlign.center,
          validator: (value)
          {
            if(value==null || value.isEmpty)
            return 'Please Enter required fields';
            return null;
          },
          onChanged: (value) {
            if(value!=null){
              hno=value;
            }
            //Do something with the user input.
          },
          decoration: DECORATION("ENter Your Name"),
        ),
                  TextFormField(
          style: TextStyle(color:Colors.black),
          textAlign: TextAlign.center,
          validator: (value)
          {
            if(value==null || value.isEmpty)
            return 'Please Enter required fields';
            return null;
          },
          onChanged: (value) {
            if(value!=null){
              name=value;
            }
            //Do something with the user input.
          },
          decoration: DECORATION("ENter Your Mobile number"),
        ),
                  TextFormField(
          style: TextStyle(color:Colors.black),
          textAlign: TextAlign.center,
          validator: (value)
          {
            if(value==null || value.isEmpty)
            return 'Please Enter required fields';
            return null;
          },
          onChanged: (value) {
            if(value!=null){
              mobileno=value;
            }
            //Do something with the user input.
          },
          decoration: DECORATION("ENter Your villagename"),
        ),
                  TextFormField(
          style: TextStyle(color:Colors.black),
          textAlign: TextAlign.center,
          validator: (value)
          {
            if(value==null || value.isEmpty)
            return 'Please Enter required fields';
            return null;
          },
          onChanged: (value) {
            if(value!=null){
              village=value;
            }
            //Do something with the user input.
          },
          decoration: DECORATION("ENter Your District Name"),
        ),
          TextFormField(
          style: TextStyle(color:Colors.black),
          textAlign: TextAlign.center,
          validator: (value)
          {
            if(value==null || value.isEmpty)
            return 'Please Enter required fields';
            return null;
          },
          onChanged: (value) {
            if(value!=null){
              district=value;
            }
            //Do something with the user input.
          },
          decoration: DECORATION("ENter Your State"),
        )
              ],
            )),
            Container(
            child: ElevatedButton(child: Text("Save and PAYYYYYYYYYYYYY"),onPressed:()async
            {
              if(_formKey.currentState.validate())
              {
                   var _obj={
                  "usermail":"testingforaddressfin10@gmail.com",
                  "address":
                  {
                    "HNO":hno,
                    "Village":village,
                    "State":state,
                    "District":district,
                    "Mobile NUmber":mobileno,
                    "Name":name
                  }
                   };
                    var _res=jsonEncode(_obj);
                    print(_res);
                    var resss=await post(Uri.parse('https://fresh48.herokuapp.com/address',),body:_res,headers: {
                    "Content-Type": "application/json"
                    });
                    // print(jsonDecode(resss.body));
                    print("ADDRESS posted");
                _pay();
              }
            },),
          ),]
        ):Column(
          children: [
            Material(
              borderRadius: BorderRadius.circular(20),
              color: Colors.cyan,
              child: Column(
                children: [
                  Rowcard(resp2: resp1,st1: "HNO",),
                  Rowcard(resp2: resp1,st1:"Village"),
                  Rowcard(resp2: resp1,st1: "State",),
                  Rowcard(resp2: resp1,st1: "District",),
                  Rowcard(resp2: resp1,st1: "Mobile NUmber",),
                  Rowcard(resp2: resp1,st1: "Name",),
                ],
              ),
            ),
            ElevatedButton(onPressed: _pay, child:Text("PAYYYY"))
          ],
        ),
      ),
    );
  }

  InputDecoration DECORATION(String text) {
    return InputDecoration(
          hintText: text,
          hintStyle: TextStyle(color:Colors.black),
          contentPadding:
              EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(32.0)),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.blueAccent, width: 1.0),
            borderRadius: BorderRadius.all(Radius.circular(32.0)),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.blueAccent, width: 2.0),
            borderRadius: BorderRadius.all(Radius.circular(32.0)),
          ),
        );
  }
}

class Rowcard extends StatelessWidget {
  String st1;
  List resp2;
  Rowcard({this.st1,this.resp2});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Text(st1),
          Text('  :  '+resp2[0]['address'][st1]),
        ],
      ),
    );
  }
}
class Address {
@required String hno;
@required String village;
@required String state;
@required String district;
@required int mobilenumber;
@required String name;
Address({this.district,this.hno,this.mobilenumber,this.name,this.state,this.village});
}