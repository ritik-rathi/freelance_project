import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.transparent,
        body: SingleChildScrollView(
          child: Stack(
            children: <Widget>[
              Container(
                alignment: Alignment.topCenter,
                height: 250.0,
                width: double.infinity,
                color: Color(0xFF50CDFF),
              ),
              Positioned(
                top: 100.0,
                left: 20.0,
                child: Card(
                  child: Container(
                    width: 200,
                    height: 400.0,
                    color: Colors.green,
                  ),
                ),
              ),
              Positioned(
                  right: 20.0,
                  top: 20.0,
                  child: IconButton(
                    icon: Icon(
                      Icons.menu,
                      size: 30.0,
                      color: Colors.white,
                    ),
                    onPressed: () {},
                  )),
              Positioned(
                top: 20.0,
                left: 20.0,
                child: CircleAvatar(
                  backgroundImage: AssetImage('assets/images/logo.jpeg'),
                  radius: 50,
                ),
              ),
            ],
          ),
        ));
  }
}
