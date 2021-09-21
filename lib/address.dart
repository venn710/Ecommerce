import 'package:flutter/material.dart';
class AddressDetails extends StatefulWidget {
  List li;
  Function fun;
  AddressDetails({this.li,this.fun});
  @override
  _AddressDetailsState createState() => _AddressDetailsState();
}

class _AddressDetailsState extends State<AddressDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My Addresses"),
        centerTitle: true,
        backgroundColor: Colors.white70,
        foregroundColor: Colors.black,
      ),
      body: SafeArea(
        child:
            Column(
              children: [
                ListView.builder(
                itemCount:widget.li.length,
                 itemBuilder: (context,ind)
                    {
                 return Padding(
                   padding: const EdgeInsets.all(8.0),
                   child: Material(
                     borderRadius: BorderRadius.circular(20),
                     elevation: 20,
                     color: Colors.lightGreenAccent[200],
                     child: Container(
                       margin: EdgeInsets.all(10),
                       height: 220,
                       child: Column(
                       children: [
                       Expanded(child: Rowcard(index:ind,resp2: widget.li,st1: "HNO",)),
                       Expanded(child: Rowcard(index:ind,resp2: widget.li,st1:"Village")),
                       Expanded(child: Rowcard(index:ind,resp2: widget.li,st1: "State",)),
                       Expanded(child: Rowcard(index:ind,resp2: widget.li,st1: "District",)),
                       Expanded(child: Rowcard(index:ind,resp2: widget.li,st1: "Mobile NUmber",)),
                       Expanded(child: Rowcard(index:ind,resp2: widget.li,st1: "Name",)),
                        ],
                       ),
                     ),
                   ),
                 );
                    }
                    ),
                (widget.fun==null)?Container():ElevatedButton(onPressed: widget.fun, child:Text("PAYYYY"))
              ],
            ),
          ),
    );
  }
}
class Rowcard extends StatelessWidget {
  String st1;
  List resp2;
  int index;
  Rowcard({this.index,this.st1,this.resp2});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Text(st1),
          Text('  :  '+resp2[index]['address'][st1]),
        ],
      ),
    );
  }
}