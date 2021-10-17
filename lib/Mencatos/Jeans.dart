
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:fresh/models/product.dart';
import 'package:fresh/screens/Individual.dart';
import 'package:http/http.dart';

import '../util.dart';

class Jeans extends StatefulWidget {
  @override
  JeansState createState() => JeansState();
}

class JeansState extends State<Jeans> {
  int page=1;
  List<Product>_finallist=[];
  bool _loader=true;
  bool _loader1=false;
  bool _isempty=false;
  ScrollController _controller=new ScrollController();
void getprods(int page) async{
    try
    {
      var resp=await get(Uri.parse('https://fresh48.herokuapp.com/Products/Men/Jeans?page=$page'));
      List ress=(jsonDecode(resp.body));
      if(mounted)
      setState(() {
      if(ress.length==0 && mp['Jeans']==null)
      _isempty=true;
      else
{      for(var w in ress)
      _finallist.add(
        Product(
         title: w['title'],
         desc: w['description'],
         id: w['id'],
         image: w['image'],
         price: w['price'],
         size: w['size'],
         brand: w['brand'],
         unique_id:w['_id']
          ),
        );  
        mp.update('Jeans', (value) =>_finallist);
        }
        _loader=false;
        _loader1=false;
      });
    }
    on SocketException
    {
      return Future.error("Server Error");
    }
  }
  @override
  void initState() {
    super.initState();
    getprods(1);
    // 
    _controller.addListener(() {
      if(_controller.position.pixels==_controller.position.maxScrollExtent && mounted)
      {

        print("pixels ${_controller.position.pixels}");
        setState(() {
          page=page+1;
          _loader1=true;
        });
        getprods(page);
      }
    });
  }
    @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controller.dispose();
  }
  @override
  Widget build(BuildContext context) {
    print(MediaQuery.of(context).size.height);
    return SafeArea(
      child:Column(
        children: [
          Expanded(
            child:(_loader)?Center(child: CircularProgressIndicator()):
    (_isempty)?Center(child: Text("No Products are added")):GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        controller: _controller,
        itemBuilder: (context,ind)
           {
        return Container(
          height: 1500,
          child: GestureDetector(
            onTap: ()=>Navigator.push(context,MaterialPageRoute(builder: (context)
            {
              return Indi(p1:mp['Jeans'][ind]);
            })),
            child: Padding(
    padding: const EdgeInsets.all(8.0),
    child: Padding(
          padding: const EdgeInsets.symmetric(vertical:5.0),
          child: Column(
          children: [
            Expanded(flex:10,child:Image.memory(base64Decode(mp['Jeans'][ind].image))),
            Expanded(flex: 1,child:Text(mp['Jeans'][ind].brand)),
            Expanded(flex:1,child: Text(mp['Jeans'][ind].title)),
            Expanded(flex:1,child: Text("₹"+mp['Jeans'][ind].price.toString())),
          ],
    ),
    ),
            ),
          ),
        );
      },
      itemCount:_finallist.length,
      )
          
          ),
          Container(
            margin: EdgeInsets.only(top:10),
            height: _loader1 ? 50.0 : 0,
            color: Colors.transparent,
            child: Center(
              child: new CircularProgressIndicator(),
            ),
          )
        ],
      )
      // (_finallist.length==0)?CircularProgressIndicator():
// FutureBuilder<List>(
//         future: getprods(),
//         builder: (context,snapshot)
//       {
//           if(snapshot.hasData)
//           return ListView.builder(
//             controller: _controller,
//             itemBuilder: (context,ind)
//             {
//               return Container(
//                 height: 150,
//                 child: ListTile(
//                   title: Text(snapshot.data[ind]['brand']),
//                   leading: Image(image: MemoryImage(base64Decode(snapshot.data[ind]['image'])))),
//               ); 
//               // MemoryImage(); 
//             },
//             itemCount: snapshot.data.length,
// );
//           else if(snapshot.hasError)
//           return Text(snapshot.error.toString());
//           else
//           return CircularProgressIndicator();
//       }),
    );
  }
}