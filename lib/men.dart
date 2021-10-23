import 'package:flutter/material.dart';
import 'package:fresh/Mencatos/Jeans.dart';
import 'Mencatos/Footwear.dart';
import 'Mencatos/Hoodies.dart';
import 'Mencatos/Shirts.dart';
List<String>catos=["Jeans","Shirt","Footwear","Hoodies"];
List<Widget> _mencats=[Jeans(),Shirts(),Footwear(),Hoodies()];
int finindex=0;
class Men extends StatefulWidget {
  @override
  _MenState createState() => _MenState();
}

class _MenState extends State<Men>{
  void dispose()
  {
    super.dispose();
    finindex=0;
  }
  @override
  Widget build(BuildContext context) {
        return SafeArea(
          child: Scaffold(
        body:Column(
          children:
          [    
            Expanded(
              flex: 1,
              child: Center(child: Text("MEN",style: TextStyle(fontSize:30,color: Colors.lightGreenAccent[400],fontWeight: FontWeight.bold),))),
            Expanded(
              flex: 10,
              child: Cate1())
          ]
        ),

        ),
      );
  }
}
class Cate1 extends StatefulWidget {
  @override
  _Cate1State createState() => _Cate1State();
}

class _Cate1State extends State<Cate1> {
  int index1=0;
  void initState()
  {
    finindex=0;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    // LiftState finkey=Provider.of<LiftState>(context);
    return Column(
    children: [
      Expanded(
        flex:1,
        child: SizedBox(
          width:double.infinity,
          // height: 60,
          child: ListView.builder(
    itemCount: catos.length,
    scrollDirection: Axis.horizontal,
    shrinkWrap: true,
    itemBuilder: (context,ind)
    {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            children: [
              TextButton(
              onPressed: () async
              {
                if(mounted)
                setState(() {
                  index1=ind;
                  finindex=ind;
                });
              },
              child: Text("${catos[ind]}",style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize:18
                ),
                ),
              ),
                Center(
                  child: Container(
                  height:(ind==index1)?5:0,
                  width:(ind==index1)?38:0,
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
        child: _mencats[finindex])
    ],
        );
  }
}