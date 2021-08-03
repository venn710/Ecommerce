
import 'package:fresh/screens/Individual.dart';

import 'models/product.dart';
// import 'util.dart';
import 'package:flutter/material.dart';
int _finindex=0;

class Women extends StatefulWidget {
  @override
  _WomenState createState() => _WomenState();
}

class _WomenState extends State<Women> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
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
    );
  }
}
class Cate extends StatefulWidget {
  @override
  _CateState createState() => _CateState();
}

class _CateState extends State<Cate> {
  List<String>catos=["Hand Bag","jewellery","Footwear","Dresses"];
  int _index=0;
  @override
  Widget build(BuildContext context) {
    return Column(
    children: [
      Expanded(
        flex: 1,
        child: SizedBox(
          width:double.infinity ,
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
              onPressed: ()
              {
                setState(() {
                  _index=ind;
                  _finindex=ind;
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
List diff=[products,products1,products2,products3];
  @override
  Widget build(BuildContext context) {
    //  print(diff[_finindex].length);
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
    crossAxisCount: 2,
    // mainAxisExtent: 150.0,
      ),
      itemCount: diff[_finindex].length,
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      itemBuilder: (context,ind1)
    {
      // print(diff[_finindex].length);
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: GestureDetector(
          onTap: ()=>Navigator.push(context, MaterialPageRoute(builder: (context)=>Indi(p1:diff[_finindex][ind1],))),
          child: Container(
            decoration: BoxDecoration(
             color: diff[_finindex][ind1].color,
              borderRadius:BorderRadius.circular(20)
            ),
            height: 500,
            width: 100,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical:5.0),
              child: Column(
              children: [
                Expanded(flex:1,child: Text(diff[_finindex][ind1].title)),
                Expanded(flex:10,child: Image.asset(
                  diff[_finindex][ind1].image,
                  fit:BoxFit.fill,
                  colorBlendMode:BlendMode.darken ,
                  )),
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