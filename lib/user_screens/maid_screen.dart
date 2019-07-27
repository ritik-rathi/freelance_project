import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:freelance/user_screens/user_screens.dart' as prefix0;

import '../soc_ID.dart';

var _keys = <GlobalKey>[];

class MaidViewModel {
  String name;
  String time;
  String mobile;
  String uid;

  MaidViewModel({this.mobile, this.name, this.time, this.uid}) : super();
}

class MaidScreen extends StatelessWidget {
  final Color highlightColor = Color(0xffedff2d);
  final Color color = Color(0xFF50CDFF);

  Future image(String uid) async {
    final ref = FirebaseStorage.instance.ref().child('$uid');
    var url = await ref.getDownloadURL();
    return url;
  }

  Future _getFuture() async {
    var stream;
    try {
      stream = Firestore.instance
          .collection("/society/$socID/maids")
          .snapshots()
          .map((data) {
        var list = data.documents.map((rawPost) {
          var flatTime = rawPost["flatTime"];
          MaidViewModel mvm = new MaidViewModel();
          for (int i = 0; i < flatTime.length; i++) {
            if (flatTime[i]["flat"] == prefix0.flatDetails) {
              mvm.time = flatTime[i]["time"];
              mvm.name = rawPost["name"];
              mvm.mobile = rawPost["mobile"];
            }
          }
          return mvm;
        }).toList();
        return list;
      }).first;
    } catch (e) {
      print("Error occured ${e.toString()}");
    }
    return stream;
    //returns Future<List<MaidViewModel>
  }

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
                'Frequent visitors',
                textAlign: TextAlign.left,
                style: TextStyle(
                    letterSpacing: 2.5,
                    color: Colors.white,
                    fontSize: 30.0,
                    fontWeight: FontWeight.w600),
              ),
            ]),
          ),
          FutureBuilder(
              future: _getFuture(),
              builder: (context, data) {
                if (!data.hasData || data.hasError) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  return Expanded(
                      child: ListView.builder(
                          itemCount: data.data.length - 1,
                          itemBuilder: (context, index) {
                            var ds = data.data[index + 1];
                            String name = ds.name;
                            String mobile = ds.mobile;
                            String time = ds.time;
                            String uid = ds.uid;
                            return Card(
                              color: Colors.white,
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
                                          child: FutureBuilder(
                                              future: image(uid),
                                              builder: (context, snapshot) {
                                                if (snapshot.hasError ||
                                                    !snapshot.hasData) {
                                                  return Container(
                                                    width: 80,
                                                    height: 90,
                                                    child: Center(
                                                      child:
                                                          CircularProgressIndicator(
                                                        backgroundColor:
                                                            Colors.black,
                                                        strokeWidth: 1.0,
                                                      ),
                                                    ),
                                                  );
                                                }
                                                return Image.network(
                                                  snapshot.data,
                                                  fit: BoxFit.cover,
                                                );
                                              })),
                                      SizedBox(
                                        width: 20.0,
                                      ),
                                      RichText(
                                        text: TextSpan(children: [
                                          TextSpan(
                                            text: 'Name: ',
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 25.0,
                                            ),
                                          ),
                                          TextSpan(
                                            text: '${name ?? "NA"}',
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 25.0,
                                                fontWeight: FontWeight.w500),
                                          ),
                                          TextSpan(
                                            text: '\nPhone: ',
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 25.0,
                                            ),
                                          ),
                                          TextSpan(
                                            text: '${mobile ?? "NA"}',
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 25.0,
                                                fontWeight: FontWeight.w500),
                                          ),
                                          TextSpan(
                                            text: '\nTime: ',
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 25.0,
                                            ),
                                          ),
                                          TextSpan(
                                            text: '${time ?? "NA"}',
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 25.0,
                                                fontWeight: FontWeight.w500),
                                          ),
                                        ]),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            );
                          }));
                }
              }),
        ],
      ),
    );
  }
}
