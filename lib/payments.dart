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
  Razorpay _razorpay;
  bool fl;
  String _username;
  bool _loader=true;
  List resp1=[];
  @override
  void initState() {
    super.initState();
    _razorpay=Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS,paymentsuccesshandler);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR,paymentfailurehandler);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET,externaleventhandler);
    getuname();
  }
  void getuname() async
  {
    _Prefs=await SharedPreferences.getInstance();
    var str=_Prefs.getString('email');
    setState(() {
      _loader=false;
      _username=str;
    });

  }
  // void showInSnackbar(BuildContext ctx)
  // {
  //   ScaffoldMessenger.of(ctx).showSnackBar(SnackBar(content: Text('Uh-oh!Seems like you have not added address yet')));
  // }
  // void getaddress()async{
  //   _Prefs=await SharedPreferences.getInstance();
  //   var _str=_Prefs.getString('email');
  //   var res=await get(Uri.parse('https://fresh48.herokuapp.com/address/$_str'));
  //   resp1=jsonDecode(res.body);
  //   if(resp1.length==0)
  //   {
  //   showInSnackbar(context);
  //   setState(() {
  //     fl=true;
  //     _loader=false;
  //   });
  //   }
  //   else
  //   setState(() {
  //     fl=false;
  //     _loader=false;
  //   });
  //   print(resp1);
  //   print("###################################################################");
  // }
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
      body:(_loader)?Center(child: CircularProgressIndicator()):SafeArea(
        child:AddressDetails(fun: _pay,uname:_username,)
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