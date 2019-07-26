import 'package:flutter/cupertino.dart' as prefix1;
import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freelance/guard_screens/otp.dart';

import '../soc_ID.dart';

String dName, dPhone, dOrg, rFlat, rName;
DateTime dTime = DateTime.now();
var query = Firestore.instance.collection('/society/$socID/maids');

class Frequent extends StatefulWidget {
  @override
  _FrequentState createState() => _FrequentState();
}

class _FrequentState extends State<Frequent>
    with SingleTickerProviderStateMixin {
  TabController _controller;
  int l;
  initState() {
    _controller = TabController(initialIndex: 0, vsync: this, length: 4);
    super.initState();
  }

  Future<int> check(String id) async {
    var c = await query.where('uid', isEqualTo: id).snapshots().first;
    l = c.documents.length;
    return l;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff1A2980),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(8),
              child: Align(
                alignment: Alignment.topLeft,
                child: IconButton(
                  iconSize: 30,
                  icon: Icon(Icons.arrow_back),
                  onPressed: () => Navigator.pop(context),
                ),
              ),
            ),
            prefix1.SizedBox(height: 100),
            _buildAddCard()
          ],
        ),
      ),
    );
  }

  Widget _buildAddCard() {
    return Padding(
      padding: const EdgeInsets.only(left: 10.0, right: 10.0, top: 20.0),
      child: Column(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.0),
                // border: Border.all(width: 2.0),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                      color: Colors.black12,
                      offset: Offset(0.0, 15.0),
                      blurRadius: 15.0),
                  BoxShadow(
                      color: Colors.black12,
                      offset: Offset(0.0, -15.0),
                      blurRadius: 15.0)
                ]),
            width: double.infinity,
            height: 470,
            child: Container(
              width: double.maxFinite,
              height: 410,
              child: Column(
                children: <Widget>[
                  //SizedBox(height: 70),
                  Text(
                    'Unique ID',
                    style: TextStyle(
                        fontSize: 40.0,
                        fontWeight: FontWeight.w100,
                        color: Colors.black),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 50.0, left: 20.0, right: 20.0),
                    child: Column(
                      children: <Widget>[
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'ID',
                            style: TextStyle(
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                          ),
                        ),
                        TextField(
                          autofocus: true,
                          onChanged: (value) {
                            dName = value;
                          },
                          decoration: InputDecoration(
                              hintText: 'Enter ID',
                              hintStyle: TextStyle(
                                  color: Colors.grey,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 12.0)),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 50.0),
                    child: RaisedButton(
                      child: Text(
                        'Submit',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 30.0,
                            fontWeight: FontWeight.bold),
                      ),
                      color: Colors.blue,
                      onPressed: () {
                        check(dName).then((l) {
                          if (l == 1) {
                            match();
                          }
                        });
                      },
                    ),
                  )
                ],
              ),
            ),
          ),
          SizedBox(
            height: 50.0,
          )
        ],
      ),
    );
  }

  Future match() {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
              title: Column(
            children: <Widget>[
              Text('ID matched!'),
              Padding(
                padding: EdgeInsets.all(10),
                child: MaterialButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('Ok'),
                ),
              )
            ],
          ));
        });
  }
}
