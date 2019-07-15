import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:ui';

import '../soc_ID.dart';

DateTime today = DateTime.now();

class TodayVisitor extends StatefulWidget {
  @override
  _TodayVisitorState createState() => _TodayVisitorState();
}

class _TodayVisitorState extends State<TodayVisitor> {
  Future image(int otp) async {
    final ref = FirebaseStorage.instance.ref().child('$otp');
    var url = await ref.getDownloadURL();
    return url;
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
                "Today's Visitors",
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

  Future detailDialog(List<String> detName, String detTime, String detPurpose,
      String detPhone, String detFlat, String detBlock, String exit) {
    return showDialog(
        context: context,
        builder: (context) {
          return Scaffold(
            backgroundColor: Colors.transparent,
            resizeToAvoidBottomInset: false,
            body: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
                child: Center(
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20.0),
                        border:
                            Border.all(width: 4.0, color: Color(0xff1A2980))),
                    margin:
                        EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                    height: 380.0,
                    width: double.infinity,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 20.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Center(
                            child: Text(
                              'Details',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 30.0,
                                  letterSpacing: 1.5,
                                  fontWeight: FontWeight.w700),
                            ),
                          ),
                          SizedBox(
                            height: 20.0,
                          ),
                          Text(
                            'Name - ${detName[0]}',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 20.0,
                                fontWeight: FontWeight.w700),
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                          Text(
                            'Phone - $detPhone',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 20.0,
                                fontWeight: FontWeight.w700),
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                          Text(
                            'Time - $detTime',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 20.0,
                                fontWeight: FontWeight.w700),
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                          Text(
                            'Purpose - $detPurpose',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 20.0,
                                fontWeight: FontWeight.w700),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            'Flat - $detBlock $detFlat',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 20.0,
                                fontWeight: FontWeight.w700),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            'Exit - $exit',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 20.0,
                                fontWeight: FontWeight.w700),
                          ),
                          Align(
                            alignment: Alignment.bottomRight,
                            child: IconButton(
                              onPressed: () => Navigator.pop(context),
                              icon: Icon(Icons.check),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                )),
          );
        });
  }

  Widget _buildList() {
    int c = 0;
    int i = 0;
    return StreamBuilder(
        stream: Firestore.instance
            .collection("/society/$socID/visitors")
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
                    var docID = ds.documentID;
                    var time = ds["visitTime"];
                    var timeExit;
                    if (ds['exitTime'] != null)
                      timeExit = ds['exitTime'].toString().substring(0, 10);
                    else
                      timeExit = '--';
                    bool exit = true;
                    double height;

                    if (ds['exitTime'] == null) exit = false;
                    if (exit)
                      height = 130;
                    else
                      height = 170;
                    //var diff = DateTime.now().difference(time).toString();
                    var time1 = time.toString();
                    String phone = ds["mobile"];
                    if (phone != null)
                      phone = phone;
                    else
                      phone = 'NA';
                    String vName = ds["name"];
                    String purpose = ds['purpose'];
                    String flat = ds['house'];
                    String block = ds['block'];
                    List<String> name = vName.split(' ');
                    var newTime;
                    if (time1 != null) {
                      newTime = time1.substring(11, 16);
                    }
                    var tt = DateTime.parse(time);

                    var dur = DateTime.now().difference(tt).inDays;
                    if (dur != 0) {
                      return Container();
                    } else {
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 20.0),
                        child: GestureDetector(
                          onTap: () => detailDialog(name, newTime, purpose,
                              phone, flat, block, timeExit),
                          child: (vName != null && time != null)
                              ? Card(
                                  color: Colors.white,
                                  elevation: 5.0,
                                  child: Container(
                                    width: double.infinity,
                                    height: height,
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(
                                          vertical: 10.0, horizontal: 10.0),
                                      child: Column(
                                        children: <Widget>[
                                          Row(
                                            children: <Widget>[
                                              Container(
                                                color: Colors.blue,
                                                width: 90,
                                                height: 100,
                                                child: FutureBuilder(
                                                    future: image(ds['otp']),
                                                    builder:
                                                        (context, snapshot) {
                                                      if (snapshot.hasError ||
                                                          !snapshot.hasData) {
                                                        return CircularProgressIndicator(
                                                          backgroundColor:
                                                              Colors.black,
                                                        );
                                                      } else {
                                                        return Image.network(
                                                            snapshot.data,
                                                            fit: BoxFit.cover);
                                                      }
                                                    }),
                                              ),
                                              SizedBox(
                                                width: 20.0,
                                              ),
                                              RichText(
                                                text: TextSpan(children: [
                                                  TextSpan(
                                                    text: 'Name: ',
                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        //letterSpacing: 1.5,
                                                        // backgroundColor:
                                                        //     Color(0xffedff2d),
                                                        fontSize: 25.0,
                                                        fontWeight:
                                                            FontWeight.w500),
                                                  ),
                                                  TextSpan(
                                                    text: '${name[0]}',
                                                    style: TextStyle(
                                                      color: Colors.black,
                                                      //letterSpacing: 1.5,
                                                      // backgroundColor:
                                                      //     Color(0xffedff2d),
                                                      fontSize: 25,
                                                      //fontWeight: FontWeight.w500
                                                    ),
                                                  ),
                                                ]),
                                              )
                                            ],
                                          ),
                                          exit
                                              ? Container(height: 0)
                                              : Align(
                                                  alignment:
                                                      Alignment.bottomRight,
                                                  child: MaterialButton(
                                                    color: Colors.red,
                                                    onPressed: () {
                                                      setState(() {
                                                        exit = true;
                                                        height = 160;
                                                        exitTime(docID);
                                                      });
                                                    },
                                                    child: Text('Exit'),
                                                  ),
                                                )
                                        ],
                                      ),
                                    ),
                                  ),
                                )
                              : null,
                        ),
                      );
                    }
                  }),
            );
          }
        });
  }

  exitTime(var docid) {
    print('$docid');
    Firestore.instance
        .collection('/society/$socID/visitors')
        .document('$docid')
        .updateData({"exitTime": DateTime.now().toString()});
    print('Exited');
  }
}
