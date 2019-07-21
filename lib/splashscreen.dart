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
        () => Navigator.pushReplacementNamed(context, '/guard'));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
          gradient: new LinearGradient(
              begin: const FractionalOffset(0.0, 0.0),
              end: const FractionalOffset(1.0, 1.0),
              stops: [0.0, 1.0],
              tileMode: TileMode.clamp,
              colors: [Color(0xFF50CDFF), Color(0xff1A2980)])),
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
