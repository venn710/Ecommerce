
import 'dart:convert';

import 'package:fresh/screens/Individual.dart';
import 'package:fresh/statelift.dart';
import 'package:fresh/util.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
int _finindex=0;
  List<String>_catos=["Dresses","Footwear","Jewellary","Handbags"];
class Women extends StatefulWidget {
  @override
  _WomenState createState() => _WomenState();
}

class _WomenState extends State<Women> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create:(context)=>LiftState(1),
      child: SafeArea(
            child: Scaffold(
          body:Column(
            children:
            [
              Expanded(
                flex: 1,
                child: Text("WOMEN",style: TextStyle(fontSize:30,color: Colors.pink[200],fontWeight: FontWeight.bold),)),
              Expanded(
                flex:10,
                child: Cate()),
            ]
          ),
    
        ),
      ),
    );
  }
}
class Cate extends StatefulWidget {
  @override
  _CateState createState() => _CateState();
}

class _CateState extends State<Cate> {
  int _index=0;
  @override
  Widget build(BuildContext context) {
    LiftState _finkey=Provider.of<LiftState>(context);
    return Column(
    children: [
      Expanded(
        flex: 1,
        child: SizedBox(
          width:double.infinity ,
          // height: 60,
          child: ListView.builder(
    itemCount: _catos.length,
    scrollDirection: Axis.horizontal,
    shrinkWrap: true,
    itemBuilder: (context,ind)
    {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            children: [
              TextButton(
              onPressed: ()
              {
                setState(() {
                  _index=ind;
                  _finindex=ind;
                });
              },
              child: Text("${_catos[ind]}",style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize:18
                ),
                ),
              ),
                Center(
                  child: Container(
                  height:(ind==_index)?5:0,
                  width:(ind==_index)?38:0,
                  color: Colors.black,

              ),
                )
            ],
          ),
        );
    }   
    ),
        ),
      ),
      Expanded(
        flex: 10,
        child: Prods())
    ],
        );
  }
}
class Prods extends StatefulWidget {
  @override
  _ProdsState createState() => _ProdsState();
}

class _ProdsState extends State<Prods> {
  @override
  Widget build(BuildContext context) {
    return (wp[_catos[_finindex]]==null)?Center(child: CircularProgressIndicator()):
    (wp[_catos[_finindex]].length==0)?Center(child: Text("No Products are added")):GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: 2,
        ),
        itemCount: wp[_catos[_finindex]].length,
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemBuilder: (context,ind1)
      {
        return GestureDetector(
          onTap: ()=>Navigator.push(context,MaterialPageRoute(builder: (context)
          {
            return Indi(p1:wp[_catos[_finindex]][ind1]);
          })),
          child: Padding(
    padding: const EdgeInsets.all(8.0),
    child: Container(
      decoration: BoxDecoration(
          borderRadius:BorderRadius.circular(20)
      ),
      height: 800,
      width: 100,
      child: Padding(
          padding: const EdgeInsets.symmetric(vertical:5.0),
          child: Column(
          children: [
            Expanded(flex: 1,child:Text(wp[_catos[_finindex]][ind1].unique_id)),
            Expanded(flex:1,child: Text(wp[_catos[_finindex]][ind1].title)),
            Expanded(flex:10,child:Image.memory(base64Decode(wp[_catos[_finindex]][ind1].image))
              ),
          ],
    ),
      )
      ),
          ),
        );
      }
      );
  }
}