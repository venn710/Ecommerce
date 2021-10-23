// import 'package:fresh/models/addresses.dart';
import 'package:fresh/models/Hiveaddress.dart';
import 'package:fresh/models/cart.dart';
import 'package:hive_flutter/adapters.dart';
import 'models/orders.dart';

class BOXES {
  Box<CART> getcart() {
    return Hive.box('carts');
  }

  Box<ADDRESS> getaddresses() {
    return Hive.box('addresses');
  }

  Box<ORDERS> getorders() {
    return Hive.box('orders');
  }
}
