import 'package:flutter/material.dart';
import 'package:freelance/login.dart';
import 'package:freelance/guard_screens/delivery_details.dart';
import 'package:freelance/guard_screens/maidRec.dart';
import 'package:freelance/guard_screens/mainScreen.dart';
import 'package:freelance/guard_screens/new_visitor.dart';
import 'package:freelance/user_screens/profile.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'HOMANTRA',
      theme: ThemeData(fontFamily: 'Raleway', primaryColor: Color(0xFF50CDFF)),
      home: Profile(),
      routes: {
        '/newvisitor': (context) => NewVisitorPage(),
        '/user': (context) => Profile(),
        '/guard': (context) => MainScreen(),
        '/delivery':(context) => DeliveryPage(),
        '/maidrec': (context) => MaidRec()
      },
    );
  }
}
