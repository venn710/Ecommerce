import 'package:flutter/material.dart';

import 'Mencatos/Footwear.dart';
import 'Mencatos/Hoodies.dart';
import 'Mencatos/Jeans.dart';
import 'Mencatos/Shirts.dart';

class ProductDisplay extends StatefulWidget {
  final int ind;
  ProductDisplay({this.ind});

  @override
  _ProductDisplayState createState() => _ProductDisplayState();
}

class _ProductDisplayState extends State<ProductDisplay> {
  List<Widget> _mencats=[Jeans(),Shirts(),Footwear(),Hoodies()];
  int _finindex=0;
  void initState()
  {
    super.initState();
    setState(() {
    _finindex=widget.ind;      
    });
  }
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onPanUpdate: (det)
        {
          if(det.delta.dx>0)
          {
            print("RIGHTTTTTTTTTT");
            if(_finindex>0)
            setState(() {
              _finindex=_finindex-1;   
            });
          }
          if(det.delta.dx<0)
          {
            if(_finindex<3)
            setState(() {
              _finindex=_finindex+1;
            });
          }
        },
      child: _mencats[widget.ind]);
  }
}