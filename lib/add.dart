import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:http/http.dart';
import 'dart:io';
import 'package:mongo_dart/mongo_dart.dart' show Db, GridFS;
import 'package:image_picker/image_picker.dart';
import './util.dart';
import './server.dart';
// import 'package:mongo_dart/mongo_dart.dart';
class Add extends StatefulWidget {
  @override
  _AddState createState() => _AddState();
}

class _AddState extends State<Add> {
  String baseimage;
  int price;
  String desc;
  String id;
  List<int> imageBytes;
  String base;
  ImageProvider provider;
  String brand;
  int size;
  String dbimage;
  // String gender;
  String title;
  File image1;
  File image2;
  final picker = ImagePicker();
Future getimage()async
{
final pickedFile = await picker.getImage(source: ImageSource.gallery);
image1=File(pickedFile.path);
imageBytes = image1.readAsBytesSync();
baseimage=base64Encode(imageBytes);
setState(() {
  image1=File(pickedFile.path);
});
}

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home:Scaffold(
          body: SafeArea(
              child: Container(
            child: ListView(children: [
                TextField(
                decoration: InputDecoration(hintText:"Enter your product brand"),
                onChanged: (val)
                {
                  brand=val; 
                },
              ),
              TextField(
                decoration: InputDecoration(hintText:"Enter your product Description"),
                onChanged: (val)
                {
                  desc=val; 
                },
              ),
                      TextField(
                decoration: InputDecoration(hintText:"Enter your product genre"),
                onChanged: (val)
                {
                  title=val; 
                },
              ),
                      TextField(
                decoration: InputDecoration(hintText:"enter your product suited for"),
                onChanged: (val)
                {
                  id=val; 
                },
              ),
                 TextField(
                decoration: InputDecoration(hintText:"Enter your product price"),
                onChanged: (val)
                {
                  price=int.parse(val); 
                },
              ),
                            TextField(
                decoration: InputDecoration(hintText:"Enter your product size"),
                onChanged: (val)
                {
                  size=int.parse(val); 
                },
              ),
            SafeArea(
              child: Container(
              child: Column(
                children: [
                  image1==null?Text("no Image Selected"):Image.file(image1),
                  base==null?Text("Mo image found"):Image.memory(base64Decode(base)),
                  Center(child: TextButton(
                    onPressed:getimage,
                    child: Icon(Icons.add_a_photo)),),
                ],
              ),

              ),
            ),
            

            ElevatedButton(onPressed:()async
            {
              var _obj={
              "brand":brand,
               "id":id,"description":desc,"image":baseimage,"size":size,"title":title,"price":price};
               var _res=jsonEncode(_obj);
               if(id=="Men"){
               var resuu=await post(Uri.parse("https://fresh48.herokuapp.com/Men",),body:_res,headers: {
              "Content-Type": "application/json"
               });
               }
               else
               {
                 var resuu=await post(Uri.parse("https://fresh48.herokuapp.com/Women",),body:_res,headers: {
              "Content-Type": "application/json"
               });
               }
              // );
              // var resuu1=(resuu.body);
              // print(resuu1);
            },

            child: Text("ADD"),
            )
            ],),
      ),
          ),
        ),
    );
  }
}