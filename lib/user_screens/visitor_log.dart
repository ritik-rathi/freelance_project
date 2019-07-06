import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:freelance/login.dart';
import 'package:freelance/soc_ID.dart';
import 'profile_screen.dart';
import 'package:firebase_storage/firebase_storage.dart';

String url;

Future image(int otp) async {
  final ref = FirebaseStorage.instance.ref().child('$otp');
// no need of the file extension, the name will do fine.
  url = await ref.getDownloadURL();
  if(url != null){
    print('This is your fucking url - $url');
  }
  else{
    print('No url present');
  }
}

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
            .collection("/society/$socID/visitors")
            .where('house', isEqualTo: flat)
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
                    image(ds['otp']);

                    String vName = ds["name"];
                    String purpose = ds['purpose'];
                    // while (vName[i] != "i") {
                    //   i++;
                    //   c++;
                    // }
                    List<String> name = vName.split(' ');
                    var time = ds["visitTime"].toString();
                    if (time != null) {
                      time = time.substring(11, 16);
                    }
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 20.0),
                      child: (vName != null && time != null)
                          ? Card(
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
                                        child: Image.network('$url',
                                            fit: BoxFit.contain),
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
                                                fontSize: 20.0,
                                                //fontWeight: FontWeight.w800
                                                ),
                                          ),
                                          TextSpan(
                                            text: '${name[0]}',
                                            style: TextStyle(
                                                color: Colors.black,
                                                //letterSpacing: 1.5,
                                                // backgroundColor:
                                                //     Color(0xffedff2d),
                                                fontSize: 25.0,
                                                fontWeight: FontWeight.w500),
                                          ),
                                          TextSpan(
                                              text: '\nTime: ',
                                              style: TextStyle(
                                                  //letterSpacing: 1.5,
                                                  color: Colors.black,
                                                  // backgroundColor:
                                                  //     Color(0xffedff2d),
                                                  fontSize: 20.0,
                                                  )),
                                          TextSpan(
                                              text: '$time',
                                              style: TextStyle(
                                                  //letterSpacing: 1.5,
                                                  color: Colors.black,
                                                  // backgroundColor:
                                                  //     Color(0xffedff2d),
                                                  fontSize: 25.0,
                                                  fontWeight: FontWeight.w500)),
                                          TextSpan(
                                              text: '\nPurpose: ',
                                              style: TextStyle(
                                                  //letterSpacing: 1.5,
                                                  color: Colors.black,
                                                  // backgroundColor:
                                                  //     Color(0xffedff2d),
                                                  fontSize: 20.0,
                                                  )),
                                          TextSpan(
                                              text: '$purpose',
                                              style: TextStyle(
                                                  //letterSpacing: 1.5,
                                                  color: Colors.black,
                                                  // backgroundColor:
                                                  //     Color(0xffedff2d),
                                                  fontSize: 25.0,
                                                  fontWeight: FontWeight.w500))
                                        ]),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            )
                          : null,
                    );
                  }),
            );
          }
        });
  }
}
