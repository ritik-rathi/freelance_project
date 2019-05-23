import 'package:flutter/material.dart';

class VisitorLog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Container(
              height: 200.0, width: double.infinity, color: Color(0xFF50CDFF)),
          SizedBox(
            height: 10.0,
          ),
          Text(
            'Your Visitors',
            textAlign: TextAlign.left,
            style: TextStyle(
                letterSpacing: 2.5,
                color: Colors.black,
                fontSize: 30.0,
                fontWeight: FontWeight.w600),
          ),
          _visitorCard()
        ],
      ),
    );
  }

  Widget _visitorCard() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
      child: Card(
        color: Colors.pink[50],
        elevation: 5.0,
        child: Container(
          width: double.infinity,
          height: 160.0,
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
            child: Row(
              children: <Widget>[
                Container(
                  color: Colors.blue,
                  width: 90,
                  height: 100,
                ),
                SizedBox(
                  width: 20.0,
                ),
                RichText(
                  text: TextSpan(children: [
                    TextSpan(
                      text: 'Rathi',
                      style: TextStyle(
                          color: Colors.black,
                          letterSpacing: 1.5,
                          backgroundColor: Color(0xffedff2d),
                          fontSize: 25.0,
                          fontWeight: FontWeight.w800),
                    ),
                    TextSpan(
                        text: ' \nvisited you at',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 20.0,
                            fontWeight: FontWeight.w500)),
                    TextSpan(
                        text: '\n10:40 am',
                        style: TextStyle(
                            letterSpacing: 1.5,
                            color: Colors.black,
                            backgroundColor: Color(0xffedff2d),
                            fontSize: 25.0,
                            fontWeight: FontWeight.w800))
                  ]),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}