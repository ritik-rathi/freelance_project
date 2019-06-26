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
            decoration: BoxDecoration(
                gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Color(0xFF50CDFF), Color(0xff1A2980)],
            )),
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
    return StreamBuilder(
        stream: Firestore.instance
            .collection("/society/0aklfheb/visitors")
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          } else {
            return Expanded(
              child: ListView.builder(
                  itemCount: snapshot.data.documents.length,
                  itemBuilder: (context, index) {
                    DocumentSnapshot ds = snapshot.data.documents[index];
                    String vName = ds["name"];
                    // while (vName[i] != "i") {
                    //   i++;
                    //   c++;
                    // }
                    List<String> name = vName.split(' ');
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
                                      text: name[0],
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
                  }),
            );
          }
        });
  }
}
