import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.transparent,
        body: Container(
          height: 250,
          child: Stack(
            children: <Widget>[
              Container(
                alignment: Alignment.topCenter,
                height: 160.0,
                width: double.infinity,
                color: Color(0xFF50CDFF),
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
                top: 80.0,
                left: 90,
                right: 90,
                child: Container(
                  height: 160,
                  width: 160,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.black
                    ),
                    borderRadius: BorderRadius.circular(140) 
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 20.0),
                  child: CircleAvatar(
                    backgroundImage: AssetImage('assets/images/logo.jpeg'),
                    radius: 80,
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
