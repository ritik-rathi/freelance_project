import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:freelance/soc_ID.dart';

final Color highlightColor = Color(0xffedff2d);

class MaidSched extends StatefulWidget {
  final String name;
  final Key key;
  MaidSched({this.name, this.key});
  @override
  _MaidSchedState createState() => _MaidSchedState();
}

class _MaidSchedState extends State<MaidSched> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          children: <Widget>[
            Container(
              height: 160.0,
              width: double.infinity,
              color: Color(0xFF50CDFF),
              child: Column(children: [
                SizedBox(height: 110),
                Text(
                  'Schedule',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                      letterSpacing: 2.5,
                      color: Colors.white,
                      fontSize: 35.0,
                      fontWeight: FontWeight.w600),
                ),
              ]),
            ),
            Expanded(
                child: StreamBuilder(
              stream: Firestore.instance
                  .collection('/society/$socID/maids')
                  .where('name', isEqualTo: widget.name)
                  .snapshots(),
              builder: (context, snapshot) {
                return ListView.builder(
                    key: widget.key,
                    itemCount: snapshot.data.documents.length,
                    itemBuilder: (context, index) {
                      if (!snapshot.hasData)
                        return CircularProgressIndicator();
                      else
                        return Padding(
                          padding: const EdgeInsets.only(
                              left: 30, right: 30, top: 10, bottom: 10),
                          child: Card(
                            color: Color(0xFF50CDFF),
                            elevation: 3,
                            child: Container(
                              height: 100,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: <Widget>[
                                  Icon(
                                    Icons.home,
                                    size: 40,
                                    color: Colors.white,
                                  ),
                                  Text(
                                      snapshot.data.documents[index]['flatTime']
                                          ['flat'],
                                      style: TextStyle(
                                          fontSize: 25,
                                          backgroundColor: Colors.white,
                                          fontWeight: FontWeight.bold)),
                                  Text(
                                      snapshot.data.documents['flatTime'][index]
                                          ['time'],
                                      style: TextStyle(
                                          fontSize: 25,
                                          backgroundColor: Colors.white,
                                          fontWeight: FontWeight.bold))
                                ],
                              ),
                            ),
                          ),
                        );
                    });
              },
            ))
          ],
        ),
      ),
    );
  }
}
