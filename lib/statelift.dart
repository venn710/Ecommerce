import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart';
import 'men.dart';
import 'models/product.dart';
import 'util.dart';
class LiftState with ChangeNotifier
{
  List<Product>jeans=[];
LiftState(int ind)
{
  initial(ind);
  notifyListeners();
}

void initial(int ind) async
{
  //  if(ind==0)
    // {
     List<Product> finallist=[];
     var res=await get(Uri.parse("https://fresh48.herokuapp.com/products/Men/${catos[ind]}"));
     print("https://fresh48.herokuapp.com/Men/${catos[ind]}");
     print("fetched");
     var finres=await jsonDecode(res.body);
     for (var w in finres)
     {
       finallist.add(Product(
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
    print("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@");
      mp.update(catos[ind], (value) => finallist);

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