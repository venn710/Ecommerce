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
List<Product> products3=[
  Product(
  color: Color((math.Random().nextDouble() * 0xFFFFFF).toInt()).withOpacity(1.0),
  id:"Women",
  desc:"text",
  price: 2500055,
  image: "assets/images/dress1.jfif",
  size: 12,
  title: "bags",
  brand: "Toul House"
  ),

];
List<Product> products2=[
  Product(
  color: Color((math.Random().nextDouble() * 0xFFFFFF).toInt()).withOpacity(1.0),
  id:"Women",
  desc:"text",
  price: 25,
  image: "assets/images/foot1.jfif",
  size: 12,
  title: "bags"
  ),

];
List<Product> products1=[
  Product(
  color: Color((math.Random().nextDouble() * 0xFFFFFF).toInt()).withOpacity(1.0),
  id:"Women",
  desc:"text",
  price: 25,
  image: "assets/images/jew1.jfif",
  size: 12,
  title: "bags"
  ),
    Product(
  color: Color((math.Random().nextDouble() * 0xFFFFFF).toInt()).withOpacity(1.0),
  id:"Women",
  desc:"text",
  price: 25,
  image: "assets/images/jew1.jfif",
  size: 12,
  title: "bags"
  ),
    Product(
  color: Color((math.Random().nextDouble() * 0xFFFFFF).toInt()).withOpacity(1.0),
  id:"Women",
  desc:"text",
  price: 25,
  image: "assets/images/jew1.jfif",
  size: 12,
  title: "bags"
  ),
    Product(
  color: Color((math.Random().nextDouble() * 0xFFFFFF).toInt()).withOpacity(1.0),
  id:"Women",
  desc:"text",
  price: 25,
  image: "assets/images/jew1.jfif",
  size: 12,
  title: "bags"
  ),  Product(
  color: Color((math.Random().nextDouble() * 0xFFFFFF).toInt()).withOpacity(1.0),
  id:"Women",
  desc:"text",
  price: 25,
  image: "assets/images/jew1.jfif",
  size: 12,
  title: "bags"
  ),
    Product(
  color: Color((math.Random().nextDouble() * 0xFFFFFF).toInt()).withOpacity(1.0),
  id:"Women",
  desc:"text",
  price: 25,
  image: "assets/images/jew1.jfif",
  size: 12,
  title: "bags"
  ),
    Product(
  color: Color((math.Random().nextDouble() * 0xFFFFFF).toInt()).withOpacity(1.0),
  id:"Women",
  desc:"text",
  price: 25,
  image: "assets/images/jew1.jfif",
  size: 12,
  title: "bags"
  ),
    Product(
  color: Color((math.Random().nextDouble() * 0xFFFFFF).toInt()).withOpacity(1.0),
  id:"Women",
  desc:"text",
  price: 25,
  image: "assets/images/jew1.jfif",
  size: 12,
  title: "bags"
  ),  Product(
  color: Color((math.Random().nextDouble() * 0xFFFFFF).toInt()).withOpacity(1.0),
  id:"Women",
  desc:"text",
  price: 25,
  image: "assets/images/jew1.jfif",
  size: 12,
  title: "bags"
  ),  Product(
  color: Color((math.Random().nextDouble() * 0xFFFFFF).toInt()).withOpacity(1.0),
  id:"Women",
  desc:"text",
  price: 25,
  image: "assets/images/jew1.jfif",
  size: 12,
  title: "bags"
  ),
];
List<Product> products=[
  Product(
  color: Color((math.Random().nextDouble() * 0xFFFFFF).toInt()).withOpacity(1.0),
  id:"Women",
  desc:"text",
  price: 2500,
  image: "assets/images/bag_1.jfif",
  size: 12,
  title: "bags"
  ),
    Product(
  color: Color((math.Random().nextDouble() * 0xFFFFFF).toInt()).withOpacity(1.0),
  id:"Women",
  desc:"text",
  price: 2500000,
  image: "assets/images/bag_1.jfif",
  size: 12,
  title: "bags"
  ),
    Product(
  color: Color((math.Random().nextDouble() * 0xFFFFFF).toInt()).withOpacity(1.0),
  id:"Women",
  desc:"text",
  price: 25,
  image: "assets/images/bag_1.jfif",
  size: 12,
  title: "bags"
  ),
    Product(
  color: Color((math.Random().nextDouble() * 0xFFFFFF).toInt()).withOpacity(1.0),
  id:"Women",
  desc:"text",
  price: 25,
  image: "assets/images/bag_1.jfif",
  size: 12,
  title: "bags"
  ),
    Product(
  color: Color((math.Random().nextDouble() * 0xFFFFFF).toInt()).withOpacity(1.0),
  id:"Women",
  desc:"text",
  price: 25,
  image: "assets/images/bag_1.jfif",
  size: 12,
  title: "bags"
  ),
    Product(
  color: Color((math.Random().nextDouble() * 0xFFFFFF).toInt()).withOpacity(1.0),
  id:"Women",
  desc:"text",
  price: 25,
  image: "assets/images/bag_1.jfif",
  size: 12,
  title: "bags"
  ),
  Product(
  color: Color((math.Random().nextDouble() * 0xFFFFFF).toInt()).withOpacity(1.0),
  id:"Women",
  desc:"text",
  price: 25,
  image: "assets/images/bag_1.jfif",
  size: 12,
  title: "bags"
  ),
    Product(
  color: Color((math.Random().nextDouble() * 0xFFFFFF).toInt()).withOpacity(1.0),
  id:"Women",
  desc:"text",
  price: 25,
  image: "assets/images/bag_1.jfif",
  size: 12,
  title: "bags"
  ),
    Product(
  color: Color((math.Random().nextDouble() * 0xFFFFFF).toInt()).withOpacity(1.0),
  id:"Women",
  desc:"text",
  price: 25,
  image: "assets/images/bag_1.jfif",
  size: 12,
  title: "bags"
  ),
];