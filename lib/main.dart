import 'package:flutter/material.dart';
import 'package:fresh/loading.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:fresh/screens/Homescreen.dart';
import 'package:fresh/welcome.dart';
import 'package:shared_preferences/shared_preferences.dart';
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var _email=prefs.getString('email');
  runApp(MyApp(tar:_email==null));
}
class MyApp extends StatelessWidget {
  final bool tar;
  MyApp({this.tar});
  @override
  Widget build(BuildContext context){
    return MaterialApp(
        home:(tar)?welcome():HomePage()
      );
  }
}
// class Loading extends StatefulWidget {
//   @override
//   _LoadingState createState() => _LoadingState();
// }

// class _LoadingState extends State<Loading> {
//   List li;
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     getdata();
//   }
//   void getdata()
//   {
//     // var url=Uri.parse('https://api.covid19api.com/countries');
//     // var res=await http.get(url);
//     // li=await jsonDecode(res.body);
//     // await start();
//     // var coll = db.collection('contacts');
//     // var result=await coll.find().toList();
//     // print(result);
//     Navigator.pushReplacement(context,MaterialPageRoute(builder: (BuildContext context)
//     {
//       // return second(lis:li);
//       return welcome();
//     }));
//   }
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body:Center(child: Image.asset('assets/images/bat.jpg'),),
      
//     );
//   }
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Demo',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//         visualDensity: VisualDensity.adaptivePlatformDensity,
//       ),
//       home: MyHomePage(title: 'Flutter Demo Home Page'),
//     );
//   }
// }

// class MyHomePage extends StatefulWidget {
//   MyHomePage({Key key, this.title}) : super(key: key);
//   final String title;

//   @override
//   _MyHomePageState createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {
// List li;
// void ref()async{
// var url=Uri.parse('https://api.covid19api.com/countries');
// var res=await http.get(url);
// print(jsonDecode(res.body)[0]);
// li=jsonDecode(res.body);
//   }
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//             appBar: AppBar(
//         title: Text(widget.title),
//       ),
//               body: Stack(
//                 children: [
//                   Container(
//                     width: double.infinity,
//                     height: double.infinity,
//                     decoration:BoxDecoration(color: Colors.amber),
//                     child: Text("HI",),
//                     ),
//                   Container(
//                     width: double.infinity,
//                     height: double.infinity,
//                     decoration:BoxDecoration(color: Colors.black),
//                     child: Center(child: Text("Bye")))
//                 //   ListView.builder(
//                 //   itemCount:5,
//                 //   itemBuilder: (BuildContext context,int ind)
//                 // {
//                 //     return Card(child: li[ind]);
//                 // })
//                 ]
//               ),
//       );
//   }
// }
