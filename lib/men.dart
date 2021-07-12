import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fresh/screens/Individual.dart';
import 'package:fresh/statelift.dart';
import 'package:fresh/util.dart';
import 'package:provider/provider.dart';
Animation<Color> _colorTween;
List<String>catos=["Jeans","Shirt","Footwear","Hoodies"];
int finindex=0;
class Men extends StatefulWidget {
  @override
  _MenState createState() => _MenState();
}

class _MenState extends State<Men>{
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
          create:(context)=>LiftState(0),
          child: SafeArea(
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
              // Expanded(
              //   flex: 10,
              //   child: Container(
              //     child: ListView(
              //       shrinkWrap: true,
              //       scrollDirection: Axis.vertical,
              //       children: [
              //         Text("JIII"),
              //         SizedBox(height: 100,),
              //         Text("JIII"),
              //         SizedBox(height: 100,),
              //         Text("JIII"),
              //         SizedBox(height: 100,),
              //         Text("JIII"),
              //         SizedBox(height: 100,),
              //         Text("JIII"),
              //         SizedBox(height: 100,),
              //         Text("JIII"),
              //         SizedBox(height: 100,),
              //         Text("JIII"),
              //         Text("JIII"),
              //         Text("JIII"),
              //         Text("JIII"),
              //         Text("JIII")
              //       ],
              //      ),
              //   ),
              // )
              // Cate1()
            ]
          ),

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
  // List li=[];
  void initState()
  {
    finindex=0;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    LiftState finkey=Provider.of<LiftState>(context);
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

                if(mp[catos[finindex]]==null)
                finkey.initial(ind);
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
        child: MensProducts())
    ],
        );
  }
}
class MensProducts extends StatefulWidget {
  @override
  _MensProductsState createState() => _MensProductsState();
}

class _MensProductsState extends State<MensProducts> {

  @override
  Widget build(BuildContext context) {
    LiftState finkey=Provider.of<LiftState>(context);
    return (mp[catos[finindex]]==null)?Center(child: CircularProgressIndicator(valueColor: _colorTween)):
    GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: 2,
        ),
        itemCount: mp[catos[finindex]].length,
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemBuilder: (context,ind1)
      {
        return GestureDetector(
          onTap: ()=>Navigator.push(context,MaterialPageRoute(builder: (context)
          {
            return Indi(p1:mp[catos[finindex]][ind1]);
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
            Expanded(flex: 1,child:Text(mp[catos[finindex]][ind1].unique_id)),
            Expanded(flex:1,child: Text(mp[catos[finindex]][ind1].title)),
            Expanded(flex:10,child:Image.memory(base64Decode(mp[catos[finindex]][ind1].image))
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