import 'package:flutter/material.dart';

class second extends StatefulWidget {
  List lis;
  second({this.lis});
  @override
  _secondState createState() => _secondState();
}

class _secondState extends State<second> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widget.lis.length,
      itemBuilder: (BuildContext context,int ind){
        return Card(
          margin: EdgeInsets.all(10),
          child: Text(widget.lis[ind]['Country'].toString()));
      }
    );
  }
}