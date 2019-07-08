import 'package:flutter/cupertino.dart' as prefix1;
import 'package:flutter/material.dart';
import 'dart:ui';

String dName, dPhone, dOrg, rFlat, rName;
String dTime = TimeOfDay.now().toString();

class Frequent extends StatefulWidget {
  @override
  _FrequentState createState() => _FrequentState();
}

class _FrequentState extends State<Frequent>
    with SingleTickerProviderStateMixin {
  TabController _controller;

  initState() {
    _controller = TabController(initialIndex: 0, vsync: this, length: 4);
    super.initState();
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
            child: Column(
              children: <Widget>[
                Container(
                  width: double.maxFinite,
                  height: 60,
                  child: TabBar(
                    unselectedLabelColor: Colors.grey,
                    unselectedLabelStyle: TextStyle(fontSize: 15),
                    labelColor: Colors.black,
                    labelStyle: prefix1.TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold),
                    controller: _controller,
                    tabs: <Widget>[
                      Tab(
                        child: Text('Maid'),
                      ),
                      Tab(
                        child: Text('Driver'),
                      ),
                      Tab(
                        child: prefix1.Text('Milkman'),
                      ),
                      Tab(child: prefix1.Text('Others'))
                    ],
                  ),
                ),
                Container(
                  width: double.maxFinite,
                  height: 410,
                  child: TabBarView(
                    controller: _controller,
                    children: <Widget>[maid(), driver(), milkman(), others()],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 50.0,
          )
        ],
      ),
    );
  }

  Widget driver() {
    return Container(
      width: double.maxFinite,
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
            padding: const EdgeInsets.only(top: 50.0, left: 20.0, right: 20.0),
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
                Navigator.pop(context);
              },
            ),
          )
        ],
      ),
    );
  }

  Widget maid() {
    return Container(
      width: double.maxFinite,
      child: Column(
        children: <Widget>[
          Text(
            'Unique ID',
            style: TextStyle(
                fontSize: 40.0,
                fontWeight: FontWeight.w100,
                color: Colors.black),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 50.0, left: 20.0, right: 20.0),
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
                Navigator.pop(context);
              },
            ),
          )
        ],
      ),
    );
  }

  Widget milkman() {
    return Container(
      width: double.maxFinite,
      child: Column(
        children: <Widget>[
          Text(
            'Unique ID',
            style: TextStyle(
                fontSize: 40.0,
                fontWeight: FontWeight.w100,
                color: Colors.black),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 50.0, left: 20.0, right: 20.0),
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
                Navigator.pop(context);
              },
            ),
          )
        ],
      ),
    );
  }

  Widget others() {
    return Container(
      width: double.maxFinite,
      child: Column(
        children: <Widget>[
          Text(
            'Unique ID',
            style: TextStyle(
                fontSize: 40.0,
                fontWeight: FontWeight.w100,
                color: Colors.black),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 50.0, left: 20.0, right: 20.0),
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
                Navigator.pop(context);
              },
            ),
          )
        ],
      ),
    );
  }
}
