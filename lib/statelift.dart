import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart';
// import 'men.dart';
import 'models/product.dart';
import 'util.dart';
List<String>mencatos=["Jeans","Shirt","Footwear","Hoodies"];
List<String>womencatos=["Dresses","Footwear","Jewellary","Handbags"];
class LiftState with ChangeNotifier
{
  List<Product>jeans=[];
  List<Product>shirts=[];
  List<Product>footwear=[];
  List<Product>hoodies=[];
  List<Product>dresses=[];
  List<Product>_footwear=[];
  List<Product>jewellary=[];
  List<Product>handbaga=[];
LiftState(int index)
{
  if(index==0)
  menprods();
  else
  womenprods();
  notifyListeners();
}

void menprods()async
{
     var res=await get(Uri.parse("https://fresh48.herokuapp.com/Men/all"));
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
      mp.update(mencatos[0], (value) =>jeans);
      mp.update(mencatos[1], (value) =>shirts);
      mp.update(mencatos[2], (value) =>footwear);
      mp.update(mencatos[3], (value) =>hoodies);
      notifyListeners();
}
void womenprods()async
{
  print("Camee to women");
     var res=await get(Uri.parse("https://fresh48.herokuapp.com/Women/all"));
     print("fetched");
     List finres=await jsonDecode(res.body);
     print(finres.length);
     for (var w in finres)
     {
       if(w['title']=='Dresses')
         dresses.add(Product(
         title: w['title'],
         desc: w['description'],
         id: w['id'],
         image: w['image'],
         price: w['price'],
         size: w['size'],
         brand: w['brand'],
         unique_id:w['_id']
       ));
        else if(w['title']=='Handbags')
        handbaga.add(Product(
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
         _footwear.add(Product(
         title: w['title'],
         desc: w['description'],
         id: w['id'],
         image: w['image'],
         price: w['price'],
         size: w['size'],
         brand: w['brand'],
         unique_id:w['_id']
       ));
        else if(w['title']=='Jewellary')
        jewellary.add(Product(
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
      wp.update(womencatos[0], (value) =>dresses);
      wp.update(womencatos[1], (value) =>_footwear);
      wp.update(womencatos[2], (value) =>jewellary);
      wp.update(womencatos[3], (value) =>handbaga);
      notifyListeners();

}
}