import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fresh/address.dart';
import 'package:fresh/models/product.dart';
import 'package:http/http.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';
SharedPreferences _Prefs;
class Paymants extends StatefulWidget {
  Product data;
  Paymants({this.data});
  @override
  _PaymantsState createState() => _PaymantsState();
}

class _PaymantsState extends State<Paymants> {
  String hno,state,district,mobileno,name,village;
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
  void showInSnackbar(BuildContext ctx)
  {
    ScaffoldMessenger.of(ctx).showSnackBar(SnackBar(content: Text('Uh-oh!Seems like you have not added address yet')));
  }
  void getaddress()async{
    _Prefs=await SharedPreferences.getInstance();
    var _str=_Prefs.getString('email');
    var res=await get(Uri.parse('https://fresh48.herokuapp.com/address/$_str'));
    resp1=jsonDecode(res.body);
    if(resp1.length==0)
    {
    showInSnackbar(context);
    setState(() {
      fl=true;
      _loader=false;
    });
    }
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
      "brand":widget.data.brand,"id":widget.data.id,"description":widget.data.desc,"image":widget.data.image,"size":widget.data.size,"title":widget.data.title,"price":widget.data.price,"quantity":widget.data.quant
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
    "amount": (widget.data.price*widget.data.quant)*100,
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
        child: (fl)?SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: ListView(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text("IT seems you have not added any address add now",textAlign: TextAlign.center,),
                ),
                Form(
                  key: _formKey,
                  child:Column(
                  children: [
              TextFormField(
              style: TextStyle(color:Colors.black),
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
              },
              decoration: DECORATION("Enter Your H NO"),
            ),
            SizedBox(height: 10,),
                      TextFormField(
              style: TextStyle(color:Colors.black),
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
              },
              decoration: DECORATION("Enter Your Name"),
            ),
            SizedBox(height: 10,),
                      TextFormField(
              style: TextStyle(color:Colors.black),
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
              },
              decoration: DECORATION("Enter Your Mobile number"),
            ),
            SizedBox(height: 10,),
                      TextFormField(
              style: TextStyle(color:Colors.black),
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
              },
              decoration: DECORATION("Enter Your villagename"),
            ),
            SizedBox(height: 10,),
                      TextFormField(
              style: TextStyle(color:Colors.black),
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
              },
              decoration: DECORATION("Enter Your District Name"),
            ),
            SizedBox(height: 10,),
              TextFormField(
              style: TextStyle(color:Colors.black),
              validator: (value)
              {
                if(value==null || value.isEmpty)
                return 'Please Enter required fields';
                return null;
              },
              onChanged: (value) {
                if(value!=null){
                  state=value;
                }
              },
              decoration: DECORATION("Enter Your State"),
            )
                  ],
                )),
                Container(
                child: ElevatedButton(child: Text("Save and PAY"),onPressed:()async
                {
                  if(_formKey.currentState.validate())
                  {
                       var _obj={
                      "usermail":_Prefs.getString('email'),
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
            ),
          ),
        ):AddressDetails(li:resp1,fun:_pay)
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
class Address {
@required String hno;
@required String village;
@required String state;
@required String district;
@required int mobilenumber;
@required String name;
Address({this.district,this.hno,this.mobilenumber,this.name,this.state,this.village});
}