import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

class VisitorLog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Container(
            height: 160.0,
            width: double.infinity,
            color: Color(0xFF50CDFF),
            child: Column(children: [
              SizedBox(height: 110),
              Text(
                'Your Visitors',
                textAlign: TextAlign.left,
                style: TextStyle(
                    letterSpacing: 2.5,
                    color: Colors.white,
                    fontSize: 30.0,
                    fontWeight: FontWeight.w600),
              ),
            ]),
          ),
          SizedBox(
            height: 10.0,
          ),
          _buildList()
        ],
      ),
    );
  }

  Widget _buildList() {
    int c = 0;
    int i = 0;
    return Expanded(
      child: StreamBuilder(
          stream: Firestore.instance
              .collection("societies/I6Y2LcU6vzD7ypacQ501/visitors")
              .snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return CircularProgressIndicator();
            } else {
              return ListView.builder(
                  itemCount: snapshot.data.documents.length,
                  itemBuilder: (context, index) {
                    DocumentSnapshot ds = snapshot.data.documents[index];
                    String vName = ds["name"];
                    // while (vName[i] != "i") {
                    //   i++;
                    //   c++;
                    // }
                    //String name = vName.substring(0, c);
                    var time = ds["visitTime"].toString().substring(10, 11);
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 20.0),
                      child: Card(
                        color: Colors.pink[50],
                        elevation: 5.0,
                        child: Container(
                          width: double.infinity,
                          height: 160.0,
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: 10.0, horizontal: 10.0),
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
                                      text: vName,
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
                                        text: '\n$time',
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
                  });
            }
          }),
    );
  }
}
