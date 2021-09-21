import 'package:flutter/material.dart';
import 'dart:math' as math;
class Product
{
  String image,title,desc,id,brand,unique_id;
  int price,size;
  int quant;  
  Color color;
  Product({
    this.quant,
    this.unique_id,
    this.color,
    this.brand,
    this.desc,
    this.id,
    this.image,
    this.price,
    this.size,
    this.title
  });
}