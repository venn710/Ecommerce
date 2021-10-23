import 'package:hive_flutter/adapters.dart';

part 'Hiveaddress.g.dart';
@HiveType(typeId: 0)
class ADDRESS extends HiveObject
{
  @HiveField(0)
  String hno;
  @HiveField(1)
  String state;
  @HiveField(2)
  String district;
  @HiveField(3)
  String mobileno;
  @HiveField(4)
  String name;
  @HiveField(5)
  String village;
}