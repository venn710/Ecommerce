import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
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
    return Scaffold(
      appBar: AppBar(
        title: Text("My Addresses"),
        centerTitle: true,
        backgroundColor: Colors.white70,
        foregroundColor: Colors.black,
      ),
      body:(_loader)?Center(child: CircularProgressIndicator()):(fl)?addressform(widget.fun,widget.uname): 
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
                (widget.fun==null)?Container():Expanded(child: ElevatedButton(onPressed: widget.fun, child:Text("PAYYYY")))
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
Widget addressform(Function _payment,String uname)
{
    final _formKey = GlobalKey<FormState>();
      String hno,state,district,mobileno,name,village;
return SafeArea(
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
                      "usermail":uname,
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
                    _payment();
                  }
                },),
              ),]
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