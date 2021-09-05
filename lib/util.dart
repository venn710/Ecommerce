import './models/product.dart';
import 'package:mongo_dart/mongo_dart.dart' show Db,DbCollection;
List diff=[products,products1,products2,products3];
Map<String,List<Product>>mp={
  "Jeans":null,
  "Shirt":null,
  "Footwear":null,
  "Hoodies":null
};
Map<String,List<Product>>wp={
  "Dresses":null,
  "Footwear":null,
  "Jewellary":null,
  "Handbags":null
};
Db onlydb;
DbCollection onlycoll;
