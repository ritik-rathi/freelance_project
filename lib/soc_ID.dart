import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

String socID;

var c = Firestore.instance.collection('society').snapshots();

List<String> ids = [];

class Access extends StatelessWidget {
  void idCheck() {
    c.listen((snapshot) {
      snapshot.documents.forEach((doc) {
        ids.add(doc.documentID);
      });
    });
    print(ids);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.arrow_forward, color: Colors.white),
        onPressed: () {
          idCheck();
          c.listen((snapshot) {
            int length = snapshot.documents.length;
            for (int i = 0; i < length; i++) {
              if (ids[i] == socID) {
                Navigator.pushReplacementNamed(context, '/login');
                print(ids[i]);
                break;
              } else {
                showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: Text('Enter valid society ID'),
                        actions: <Widget>[
                          GestureDetector(
                              onTap: () => Navigator.pop(context),
                              child: Icon(Icons.check))
                        ],
                      );
                    });
              }
            }
          });
        },
      ),
      body: Container(
        decoration: BoxDecoration(
            gradient: new LinearGradient(
                begin: const FractionalOffset(0.0, 0.0),
                end: const FractionalOffset(1.0, 1.0),
                stops: [0.0, 1.0],
                tileMode: TileMode.clamp,
                colors: [Color(0xFF50CDFF), Color(0xff1A2980)])),
        child: Center(
          child: Container(
            height: 200,
            width: 300,
            child: Card(
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: <Widget>[
                    Text(
                      'Enter Society ID',
                      style:
                          TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextField(
                      decoration: InputDecoration(hintText: 'Society ID'),
                      onChanged: (value) {
                        socID = value;
                      },
                    ),
                    SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
