import 'package:flutter/material.dart';
import 'package:freelance/login.dart';
import 'package:freelance/screens/mainScreen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily: 'Poppins', primaryColor: Color(0xFF50CDFF)),
      home: MainScreen(),
      routes: {
        
      },
    );
  }
}
