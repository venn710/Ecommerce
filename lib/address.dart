import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fresh/addressform.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
  bool _loader1=false;
class AddressDetails extends StatefulWidget {
  String uname;
  Function fun;
  AddressDetails({this.uname,this.fun});
  @override
  _AddressDetailsState createState() => _AddressDetailsState();
}

class _AddressDetailsState extends State<AddressDetails> {
  SharedPreferences _Prefs;
  List _resp1;
  bool fl;
  bool _loader=true;
  @override
  void initState() {
    super.initState();
    getaddress();
  }
  void dispose(){
    super.dispose();
    _loader1=false;
  }
    void showInSnackbar(BuildContext ctx)
  {
    ScaffoldMessenger.of(ctx).showSnackBar(SnackBar(content: Text('Uh-oh!Seems like you have not added address yet')));
  }
    void getaddress()async{
    _Prefs=await SharedPreferences.getInstance();
    var _str=_Prefs.getString('email');
    var res=await get(Uri.parse('https://fresh48.herokuapp.com/address/${widget.uname}'));
    _resp1=jsonDecode(res.body);
    if(_resp1.length==0)
    {
    showInSnackbar(context);
    if(mounted)
    setState(() {
      fl=true;
      _loader=false;
    });
    }
    else
    if(mounted)
    setState(() {
      fl=false;
      _loader=false;
    });
  }
  @override
  Widget build(BuildContext context) {
    return (_loader1)?Scaffold(body:Center(child: CircularProgressIndicator()),):Scaffold(
      appBar: AppBar(
        title: Text("My Addresses"),
        centerTitle: true,
        backgroundColor: Colors.white70,
        foregroundColor: Colors.black,
      ),
      body:(_loader)?Center(child: CircularProgressIndicator()):(fl)?AddressForm(payment: widget.fun,uname: widget.uname): 
      SafeArea(
        child:
            Column(
              children: [
                Expanded(
                  flex:10,
                  child: ListView.builder(
                  itemCount:_resp1.length,
                   itemBuilder: (context,ind)
                      {
                   return Padding(
                     padding: const EdgeInsets.all(8.0),
                     child: Material(
                       borderRadius: BorderRadius.circular(20),
                       elevation: 20,
                       color: Colors.lightGreenAccent[200],
                       child: Container(
                         margin: EdgeInsets.all(10),
                         height: 220,
                         child: Column(
                         children: [
                         Expanded(child: Rowcard(index:ind,resp2: _resp1,st1: "HNO",)),
                         Expanded(child: Rowcard(index:ind,resp2: _resp1,st1:"Village")),
                         Expanded(child: Rowcard(index:ind,resp2: _resp1,st1: "State",)),
                         Expanded(child: Rowcard(index:ind,resp2: _resp1,st1: "District",)),
                         Expanded(child: Rowcard(index:ind,resp2: _resp1,st1: "Mobile NUmber",)),
                         Expanded(child: Rowcard(index:ind,resp2: _resp1,st1: "Name",)),
                          ],
                         ),
                       ),
                     ),
                   );
                      }
                      ),
                ),
                (widget.fun==null)?Container():Expanded(child: ElevatedButton(onPressed:()async
                {
                  setState(() {
                    _loader1=true;
                  });
                  widget.fun();
                }, child:Text("PAYYYY")))
              ],
            ),
          ),
    );
  }
}
class Rowcard extends StatelessWidget {
  String st1;
  List resp2;
  int index;
  Rowcard({this.index,this.st1,this.resp2});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Text(st1),
          Text('  :  '+resp2[index]['address'][st1]),
        ],
      ),
    );
  }
}
