import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freelance/bloc/bloc.dart';
import 'login.dart' as widget;

String socID;

var c = Firestore.instance.collection('society');

List<String> ids = [];

class Access extends StatelessWidget {
   int l;

  Future idCheck(String id) async {
    var check = await c.where('id', isEqualTo: id).snapshots().first;
    l = check.documents.length;
    return l;
  }
  // void idCheck() {
  //   c.listen((snapshot) {
  //     snapshot.documents.forEach((doc) {
  //       ids.add(doc.documentID);
  //     });
  //   });
  //   print(ids);
  // }

  @override
  Widget build(BuildContext context) {
    final SharedPrefs prefs = new SharedPrefs();
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.arrow_forward, color: Colors.white),
        onPressed: () {
          idCheck(socID).then((l) {
            if (l == 1) {
              Navigator.pushReplacement(
                  context,
                  new MaterialPageRoute(
                      builder: (context) => BlocProvider<AuthenticationBloc>(
                            builder: (context) =>
                                AuthenticationBloc(prefs: prefs)
                                  ..dispatch(AppStarted()),
                            child: widget.Login(
                              prefs: prefs,
                            ),
                          )));
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
