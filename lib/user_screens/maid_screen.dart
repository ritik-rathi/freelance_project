import 'dart:async';
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
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

  Stream<dynamic> _getFuture() {
    Stream<dynamic> stream;
    try {
      stream = Firestore.instance
          .collection("/society/$socID/maids")
          .snapshots()
          .map((data) {
        print("${data.documents.length}");
        var list = data.documents.map((rawPost) {
          var flatTime = rawPost["flatTime"];
          MaidViewModel mvm = new MaidViewModel();
          print("Length is ${flatTime.length}");

          for (int i = 0; i < flatTime.length; i++) {
            if (flatTime[i]["flat"] == prefix0.flatDetails) {
              print("Inside if coz ${flatTime[i]["flat"]}");
              print("${flatTime[i]["time"]}");
              mvm.time = flatTime[i]["time"];
              mvm.name = rawPost["name"];
              mvm.mobile = rawPost["mobile"];
            } else {
              continue;
            }
          }
          print("Assigned data : ${mvm.name}");
          return mvm ?? null;
        }).toList();
        print(list.length.toString());
        for (int i = 0; i < list.length; i++) {
          if (list[i].name == null) {
            print("Removing nulls");
            list.removeAt(i);
          }
        }
        return list;
      }).where((thisList) {
        // bool check = false;
        MaidViewModel mvm = new MaidViewModel();
        return !thisList.contains(mvm.name == null);
      });
    } catch (e) {
      print("Error occured ${e.toString()}");
    }
    return stream;
    //returns Stream<List<MaidViewModel>
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
          StreamBuilder(
              stream: _getFuture(),
              builder: (context, data) {
                if (!data.hasData || data.hasError) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  return Expanded(
                      child: ListView.builder(
                          itemCount: data.data.length,
                          itemBuilder: (context, index) {
                            var ds = data.data[index];
                            String name = ds.name ?? "NA";
                            String mobile = ds.mobile ?? "NA";
                            String time = ds.time ?? "NA";
                            if(ds.name == null){
                              return Container(height: 0.0 , width: 0.0,);
                            }
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
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: <Widget>[
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
                                            text: '$name',
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
                                            text: '$mobile',
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
                                            text: '$time',
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
