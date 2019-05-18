import 'package:flutter/material.dart';
import 'package:freelance/screens/new_visitor.dart';

class MainScreen extends StatelessWidget {
  String user;

  MainScreen({this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => NewVisitorPage()));
                },
                child: _optionCard('New Visitor')),
            _optionCard('Regular'),
            _optionCard('Delivery')
          ],
        ),
        decoration: BoxDecoration(
            gradient: RadialGradient(
                center: Alignment.topLeft,
                radius: 2.0,
                colors: [Color(0xff6B77E0), Color(0xff9388FF)],
                tileMode: TileMode.clamp)),
      ),
    );
  }

  Widget _optionCard(String page) {
    return Card(
      elevation: 5.0,
      child: Container(
        height: 100.0,
        width: 200.0,
        child: Center(
          child: Text(
            page,
            style: new TextStyle(
                color: Colors.black,
                fontSize: 30.0,
                fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
