import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_share_me/flutter_share_me.dart';
import 'package:freelance/login.dart';
import 'package:freelance/main.dart';
import 'package:freelance/soc_ID.dart';
import 'package:url_launcher/url_launcher.dart';

Color color = Color(0xFF50CDFF);
var query = Firestore.instance.collection('/society/$socID/users');
var name, email, phone, block, profile;
String flat;

// Future<void> credential() async {
//   profile = await query.where('Email', isEqualTo: uid).snapshots().first;

//   name = profile.documents[0]['user-1'];
//   print('aaaaaaaaaa........$name');

//   email = profile.documents[0]['Email'].toString();
//   print('aaaaaaaaaa........$email');

//   phone = profile.documents[0]['Phone - 1'];
//   print('aaaaaaaaaa........$phone');

//   flat = profile.documents[0]['Flat'].toString();
//   print('aaaaaaaaaa........$flat');

//   block = profile.documents[0]['Block'].toString();
//   print('aaaaaaaaaa........$block');
// }

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.transparent,
        resizeToAvoidBottomInset: false,
        body: StreamBuilder(
          stream: query.where('Email', isEqualTo: uid).snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Center(child: CircularProgressIndicator());
            } else {
              flat = snapshot.data.documents[0]['Flat'].toString();
              return Column(
                  //mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      height: 250,
                      child: Stack(
                        children: <Widget>[
                          Container(
                            alignment: Alignment.topCenter,
                            height: 160.0,
                            width: double.infinity,
                            decoration: BoxDecoration(
                                gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [Color(0xFF50CDFF), Color(0xff1A2980)],
                            )),
                          ),
                          Positioned(
                            top: 180,
                            left: 30,
                            child: Container(
                              height: 50,
                              width: 50,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(color: Color(0xff1A2980))),
                              child: IconButton(
                                onPressed: () {
                                  editInfo();
                                },
                                icon: Icon(
                                  Icons.edit,
                                  size: 30,
                                ),
                                color: color,
                              ),
                            ),
                          ),
                          Positioned(
                            top: 180,
                            right: 30,
                            child: Container(
                              height: 50,
                              width: 50,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(color: Color(0xff1A2980))),
                              child: IconButton(
                                onPressed: () {},
                                icon: Icon(Icons.local_phone, size: 30),
                                color: color,
                              ),
                            ),
                          ),
                          Positioned(
                              right: 20.0,
                              top: 20.0,
                              child: IconButton(
                                icon: Icon(
                                  Icons.more_vert,
                                  size: 30.0,
                                  color: Colors.white,
                                ),
                                onPressed: () => dialog(context),
                              )),
                          Positioned(
                            top: 75.0,
                            left: 100,
                            child: Container(
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border:
                                      Border.all(color: Colors.grey, width: 3)),
                              // height: 160,
                              // width: 160,
                              padding: EdgeInsets.symmetric(horizontal: 20.0),
                              child: CircleAvatar(
                                backgroundImage:
                                    AssetImage('assets/images/logo.jpeg'),
                                radius: 80,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 8),
                    Container(
                      margin: EdgeInsets.only(left: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(snapshot.data.documents[0]['user-1'],
                              style: TextStyle(fontSize: 25, color: color))
                        ],
                      ),
                    ),
                    SizedBox(height: 8),
                    Container(
                      margin: EdgeInsets.only(left: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(snapshot.data.documents[0]['Email'],
                              style: TextStyle(fontSize: 20))
                        ],
                      ),
                    ),
                    SizedBox(height: 8),
                    Container(
                      margin: EdgeInsets.only(left: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text('${snapshot.data.documents[0]['Phone - 1']}',
                              style: TextStyle(fontSize: 20))
                        ],
                      ),
                    ),
                    SizedBox(height: 8),
                    Divider(color: Color(0xff1A2980)),
                    SizedBox(height: 8),
                    Container(
                      margin: EdgeInsets.only(left: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text('Owner',
                              style: TextStyle(fontSize: 25, color: color))
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                              '${snapshot.data.documents[0]['Flat']} - ${snapshot.data.documents[0]['Block']}',
                              style: TextStyle(fontSize: 20))
                        ],
                      ),
                    ),
                    SizedBox(height: 8),
                    Divider(color: Color(0xff1A2980)),
                    SizedBox(height: 8),
                    Container(
                      margin: EdgeInsets.only(left: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text('Gender',
                              style: TextStyle(fontSize: 25, color: color))
                        ],
                      ),
                    ),
                    SizedBox(height: 8),
                    Container(
                      margin: EdgeInsets.only(left: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text('', style: TextStyle(fontSize: 20))
                        ],
                      ),
                    ),
                    SizedBox(height: 50),
                    FlatButton(
                      onPressed: () {
                        try {
                          FlutterShareMe().shareToWhatsApp(
                              msg:
                                  'hello,this is my github:https://github.com/lizhuoyuan');
                        } catch (e) {
                          print(e);
                        }
                      },
                      child: Text('Share app'),
                    )
                  ]);
            }
          },
        ));
  }

  Future editInfo() {
    return showDialog(
        context: context,
        builder: (context) {
          return Scaffold(
            backgroundColor: Colors.transparent,
            resizeToAvoidBottomInset: false,
            body: Center(
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20.0),
                    border: Border.all(width: 2.0, color: Color(0xff1A2980))),
                margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                height: 450.0,
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
                          'Edit Info',
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
                        'Name',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 20.0,
                            fontWeight: FontWeight.w700),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5.0),
                        child: TextField(
                          decoration: InputDecoration.collapsed(
                            hintText: 'Name',
                            hintStyle: TextStyle(
                                color: Colors.grey[900],
                                fontWeight: FontWeight.w300,
                                letterSpacing: 1.2),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Text(
                        'Phone number',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 20.0,
                            fontWeight: FontWeight.w700),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5.0),
                        child: TextField(
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration.collapsed(
                            hintText: 'Phone Number',
                            hintStyle: TextStyle(
                                color: Colors.grey[900],
                                fontWeight: FontWeight.w300,
                                letterSpacing: 1.2),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Text(
                        'Address',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 20.0,
                            fontWeight: FontWeight.w700),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5.0),
                        child: TextField(
                          decoration: InputDecoration.collapsed(
                            hintText: 'Address',
                            hintStyle: TextStyle(
                                color: Colors.grey[900],
                                fontWeight: FontWeight.w300,
                                letterSpacing: 1.2),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Text(
                        'E-mail ID',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 20.0,
                            fontWeight: FontWeight.w700),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5.0),
                        child: TextField(
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration.collapsed(
                            hintText: 'you@example.com',
                            hintStyle: TextStyle(
                                color: Colors.grey[900],
                                fontWeight: FontWeight.w300,
                                letterSpacing: 1.2),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      Center(
                        child: MaterialButton(
                          onPressed: () {
                            Navigator.pushReplacementNamed(context, '/user');
                          },
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0)),
                          color: Color(0xff1A2980),
                          child: Text(
                            'Upload changes',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 25.0,
                                fontWeight: FontWeight.bold),
                          ),
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

  Future<bool> dialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) => Align(
              alignment: Alignment.topRight,
              child: Container(
                height: 85,
                width: 120,
                child: Card(
                  color: Colors.white,
                  elevation: 2,
                  child: Center(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pushReplacement(context,
                            MaterialPageRoute(builder: (context) => Login()));
                        setState(() {
                          isLoggedIn = false;
                        });
                      },
                      child: Text('Logout',
                          style: TextStyle(
                              fontSize: 30,
                              color: Color(0xff1A2980),
                              fontWeight: FontWeight.w400)),
                    ),
                  ),
                ),
              ),
            ));
  }
}
