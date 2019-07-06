import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:freelance/user_screens/maid_sched.dart';
import 'package:url_launcher/url_launcher.dart';

import '../soc_ID.dart';

var _keys = <GlobalKey>[];

class MaidScreen extends StatelessWidget {
  final Color highlightColor = Color(0xffedff2d);
  final Color color = Color(0xFF50CDFF);
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
          Expanded(
            child: StreamBuilder(
                stream: Firestore.instance
                    .collection("/society/$socID/maids")
                    .snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Center(child: CircularProgressIndicator());
                  } else {
                    return ListView.builder(
                        itemCount: snapshot.data.documents.length,
                        itemBuilder: (context, index) {
                          DocumentSnapshot ds = snapshot.data.documents[index];
                          String name = ds["name"];
                          String mobile = ds["mobile"];
                          //var houses = ds["houses"][0]["house"];
                          if (name != null && mobile != null)
                            return GestureDetector(
                              onTap: () {
                                // Navigator.push(
                                //     context,
                                //     MaterialPageRoute(
                                //         builder: (context) => MaidSched(
                                //               name: name,
                                //               key: key,
                                //             )));
                              },
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: 16.0, horizontal: 20.0),
                                child: Align(
                                  alignment: Alignment.center,
                                  child: Container(
                                    width: double.infinity,
                                    height: 200.0,
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius:
                                            BorderRadius.circular(15.0),
                                        border: Border.all(
                                            color: Color.fromRGBO(
                                                212, 230, 252, 1.0)),
                                        boxShadow: [
                                          BoxShadow(
                                              color: Color.fromRGBO(
                                                  212, 230, 252, 1.0),
                                              offset: Offset(5.0, 25.0),
                                              blurRadius: 80),
                                        ]),
                                    child: Stack(
                                      children: <Widget>[
                                        SizedBox(
                                          width: 30.0,
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              right: 20.0, top: 5.0),
                                          child: Align(
                                            alignment: Alignment.centerRight,
                                            child: Container(
                                              height: 130,
                                              width: 240,
                                              decoration: BoxDecoration(
                                                  border: Border.all()),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 10.0,
                                                        horizontal: 10.0),
                                                child: RichText(
                                                  textAlign: TextAlign.left,
                                                  text: TextSpan(children: [
                                                    TextSpan(
                                                        text: 'Name : ',
                                                        style: TextStyle(
                                                            color: Colors.black,
                                                            fontSize: 20.0,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w700)),
                                                    TextSpan(
                                                        text: '$name\n\n',
                                                        style: TextStyle(
                                                            // backgroundColor:
                                                            //     highlightColor,
                                                            color: Colors.black,
                                                            fontSize: 30.0,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold)),
                                                    // TextSpan(
                                                    //     text: 'Works in:',
                                                    //     style: TextStyle(
                                                    //         color: Colors.black,
                                                    //         fontSize: 20.0,
                                                    //         fontWeight:
                                                    //             FontWeight.w700)),
                                                    // TextSpan(
                                                    //     text: '$houses\n\n',
                                                    //     style: TextStyle(
                                                    //         backgroundColor:
                                                    //             highlightColor,
                                                    //         color: Colors.black,
                                                    //         fontSize: 30.0,
                                                    //         fontWeight:
                                                    //             FontWeight.bold)),
                                                    TextSpan(
                                                        text: 'Mobile: ',
                                                        style: TextStyle(
                                                            color: Colors.black,
                                                            fontSize: 20.0,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w700)),
                                                    TextSpan(
                                                        text: '$mobile\n\n',
                                                        style: TextStyle(
                                                            // backgroundColor:
                                                            //     highlightColor,
                                                            color: Colors.black,
                                                            fontSize: 30.0,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold))
                                                  ]),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              top: 8.0, left: 8.0),
                                          child: Container(
                                            alignment: Alignment.topLeft,
                                            width: 75.0,
                                            height: 75.0,
                                            decoration: BoxDecoration(
                                                color: color,
                                                shape: BoxShape.rectangle,
                                                border: Border.all()),
                                          ),
                                        ),
                                        Align(
                                          alignment: Alignment.bottomRight,
                                          child: FloatingActionButton(
                                            child: Icon(Icons.phone),
                                            onPressed: () {
                                              //call
                                              launch("tel://$mobile");
                                            },
                                            backgroundColor: color,
                                            // backgroundColor: index % 2 == 0
                                            //     ? Colors.red[400]
                                            //     : Colors.blue[400],
                                          ),
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
          ),
        ],
      ),
    );
  }
}
