import 'package:flutter/material.dart';
import 'package:freelance/login.dart';
import 'package:freelance/screens/delivery_details.dart';
import 'package:freelance/screens/mainScreen.dart';
import 'package:freelance/screens/new_visitor.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'HOMANTRA',
      theme: ThemeData(fontFamily: 'Poppins', primaryColor: Color(0xFF50CDFF)),
      home: Login(),
      routes: {
        '/newvisitor': (context) => NewVisitorPage(),
        '/guard': (context) => MainScreen(),
        '/delivery':(context) => DeliveryPage()
      },
    );
  }
}
