import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart';
import 'men.dart';
import 'models/product.dart';
import 'util.dart';
class LiftState with ChangeNotifier
{
  List<Product>jeans=[];
  List<Product>shirts=[];
  List<Product>footwear=[];
  List<Product>hoodies=[];
LiftState()
{
  initial();
  notifyListeners();
}

void initial() async
{
      print("Cameeeeeeeeee here");
     var res=await get(Uri.parse("https://fresh48.herokuapp.com/all"));
     print("fetched");
     List finres=await jsonDecode(res.body);
     print(finres.length);
     for (var w in finres)
     {
       if(w['title']=='Shirt')
         shirts.add(Product(
         title: w['title'],
         desc: w['description'],
         id: w['id'],
         image: w['image'],
         price: w['price'],
         size: w['size'],
         brand: w['brand'],
         unique_id:w['_id']
       ));
        else if(w['title']=='Jeans')
         jeans.add(Product(
         title: w['title'],
         desc: w['description'],
         id: w['id'],
         image: w['image'],
         price: w['price'],
         size: w['size'],
         brand: w['brand'],
         unique_id:w['_id']
       ));
        else if(w['title']=='Footwear')
         footwear.add(Product(
         title: w['title'],
         desc: w['description'],
         id: w['id'],
         image: w['image'],
         price: w['price'],
         size: w['size'],
         brand: w['brand'],
         unique_id:w['_id']
       ));
        else if(w['title']=='Hoodies')
        hoodies.add(Product(
         title: w['title'],
         desc: w['description'],
         id: w['id'],
         image: w['image'],
         price: w['price'],
         size: w['size'],
         brand: w['brand'],
         unique_id:w['_id']
       ));
     }
      mp.update(catos[0], (value) =>jeans);
      mp.update(catos[1], (value) =>shirts);
      mp.update(catos[2], (value) =>footwear);
      mp.update(catos[3], (value) =>hoodies);
      print(jeans);
      notifyListeners();
    // }
//     else if(ind==1)
//     {
//       print("Came to 1");
//     List<Product> finallist1=[];
//     var res=await get(Uri.parse("https://fresh48.herokuapp.com/Men/Shirt"));
//     print("fetched");
//      var fin_res=await jsonDecode(res.body);
//      for (var w in fin_res)
//      {
//        finallist1.add(Product(
//          title: w['title'],
//          desc: w['description'],
//          id: w['id'],
//          image: w['image'],
//          price: w['price'],
//          size: w['size']
//        ));
//       mp.update(catos[ind], (value) => finallist1);
//       notifyListeners();
//     }
// }
}
}