import 'package:hive_flutter/adapters.dart';

part 'cart.g.dart';
@HiveType(typeId: 1)
class CART extends HiveObject
{
  @HiveField(0)
  String usermail;
  @HiveField(1)
  String image;
  @HiveField(2)
  String title;
  @HiveField(3)
  String desc;
  @HiveField(4)
  String id;
  @HiveField(5)
  String brand;
  @HiveField(6)
  String unique_id;
  @HiveField(7)
  int price;
  @HiveField(8)
  int size;
  @HiveField(9)
  int quant;
  CART({this.brand,this.desc,this.id,this.image,this.price,this.quant,this.size,this.title,this.unique_id,this.usermail});
}