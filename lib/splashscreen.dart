import 'dart:async';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Timer(Duration(seconds: 2),
        () => Navigator.popAndPushNamed(context, '/guard'));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: Color(0xFF50CDFF),
      height: MediaQuery.of(context).size.height,
      child: Center(
        child: Image.asset(
          'assets/images/logo.jpeg',
          fit: BoxFit.scaleDown,
          width: 200.0,
          height: 200.0,
        ),
      ),
    );
  }
}
