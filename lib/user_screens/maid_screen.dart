import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
                                child: Card(
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
                                              child: Image.network(
                                                '',
                                                fit: BoxFit.cover,
                                              )),
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
                                                  //fontWeight: FontWeight.w800
                                                ),
                                              ),
                                              TextSpan(
                                                text: '$name',
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
                                                text: '\nPhone: ',
                                                style: TextStyle(
                                                  color: Colors.black,
                                                  //letterSpacing: 1.5,
                                                  // backgroundColor:
                                                  //     Color(0xffedff2d),
                                                  fontSize: 25.0,
                                                  //fontWeight: FontWeight.w800
                                                ),
                                              ),
                                              TextSpan(
                                                text: '$mobile',
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    //letterSpacing: 1.5,
                                                    // backgroundColor:
                                                    //     Color(0xffedff2d),
                                                    fontSize: 25.0,
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ),
                                            ]),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ));
                        });
                  }
                }),
          ),
        ],
      ),
    );
  }
}
