import 'dart:io';
import 'dart:ui' as prefix0;

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_share_me/flutter_share_me.dart';
import 'package:freelance/bloc/bloc.dart';
import 'package:freelance/login.dart';
import 'package:freelance/main.dart';
import 'package:freelance/soc_ID.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:shared_preferences/shared_preferences.dart';

Color color = Color(0xFF50CDFF);
var query = Firestore.instance.collection('/society/$socID/users');
var name, email, phone, block, profile;
String flat;
var callGuard;

String flatDetails = "";

guardPhone() {
  var query = Firestore.instance.document('society/$socID');

  query.get().then((document) {
    callGuard = document['guard phone'].toString();
  });
}

TextEditingController controller;
TextEditingController controller2;

TextEditingController emailController;
TextEditingController nameController;
TextEditingController phoneController;
TextEditingController addressController;

class ProfileScreen extends StatefulWidget {
  final SharedPrefs prefs;
  final String email;
  final AuthenticationBloc authenticationBloc;

  ProfileScreen({this.prefs, this.email, this.authenticationBloc}) : super();

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  void initState() {
    emailController = new TextEditingController();
    phoneController = new TextEditingController();
    nameController = new TextEditingController();
    addressController = new TextEditingController();
    controller = new TextEditingController();
    controller2 = new TextEditingController();
    guardPhone();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
        backgroundColor: Colors.transparent,
        resizeToAvoidBottomInset: false,
        body: StreamBuilder(
          stream: query.where('Email', isEqualTo: uid).snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Center(
                child: Text(
                  'Error',
                  style: TextStyle(
                      color: Colors.red,
                      fontSize: 25.0,
                      fontWeight: FontWeight.w400),
                ),
              );
            }
            if (!snapshot.hasData) {
              return Center(child: CircularProgressIndicator());
            }
            if (snapshot.hasData) {
              flatDetails =
                  "${snapshot.data.documents[0]['Block']} ${snapshot.data.documents[0]['Flat']}";
              flat = snapshot.data.documents[0]['Flat'].toString();
              String name = snapshot.data.documents[0]['user-1'];
              String phone = snapshot.data.documents[0]['Phone - 1'];
              String email = snapshot.data.documents[0]['Email'];
              String id = snapshot.data.documents[0].documentID;
              return ListView(children: [
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
                              editInfo(id, name, phone, email);
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
                            onPressed: () {
                              print('guard: $callGuard');
                              launch("tel:$callGuard");
                            },
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
                            onPressed: () => dialog(
                                context, snapshot.data.documents[0].documentID),
                          )),
                      Positioned(
                        top: 75.0,
                        width: width,
                        //left: 100,
                        // right: 90,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Container(
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
                          ],
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
                      Text(flatDetails, style: TextStyle(fontSize: 20))
                    ],
                  ),
                ),
                SizedBox(height: 8),
                Divider(color: Color(0xff1A2980)),
                SizedBox(height: 50),
                FlatButton(
                  onPressed: () {
                    try {
                      FlutterShareMe().shareToWhatsApp(
                          msg:
                              'Download Homantra app - https://play.google.com/store/apps/details?id=com.application.homantra');
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

  Future editInfo(String id, String user, String phone, String email) {
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
                height: 480.0,
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
                          controller: nameController,
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
                          controller: phoneController,
                          maxLength: 10,
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
                          controller: addressController,
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
                          controller: emailController,
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
                          onPressed: () async {
                            Navigator.pop(context);
                            if (phoneController.text != '') {
                              Firestore.instance
                                  .collection('/society/$socID/users')
                                  .document('$id')
                                  .updateData({
                                "Phone - 1": phoneController.text,
                              });
                              phoneController.clear();
                            }
                            if (nameController.text != '') {
                              Firestore.instance
                                  .collection('/society/$socID/users')
                                  .document('$id')
                                  .updateData({
                                "user-1": nameController.text,
                              });
                              nameController.clear();
                            }
                            if (emailController.text != '') {
                              Firestore.instance
                                  .collection('/society/$socID/users')
                                  .document('$id')
                                  .updateData({
                                "Email": emailController.text,
                              });
                              emailController.clear();

                              SharedPreferences sPrefs =
                                  await SharedPreferences.getInstance();
                              sPrefs.remove("email");

                              return showDialog(
                                  context: context,
                                  builder: (context) {
                                    return BackdropFilter(
                                      filter: prefix0.ImageFilter.blur(
                                          sigmaX: 6, sigmaY: 6),
                                      child: Center(
                                        child: AlertDialog(
                                          title: Column(
                                            children: <Widget>[
                                              Text('You\'re being logged out.'),
                                              SizedBox(height: 20),
                                              MaterialButton(
                                                color: Colors.blue,
                                                onPressed: () {
                                                  exit(0);
                                                },
                                                child: Text('Ok'),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    );
                                  });
                            }
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

  Future addUser(BuildContext context, String id) {
    String name, phone, gender;
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
                height: 420.0,
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
                          'Add user',
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
                          controller: controller,
                          onChanged: (value) {
                            name = value;
                          },
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
                          maxLength: 10,
                          controller: controller2,
                          onChanged: (value) => phone = value,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
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
                        'Gender',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 20.0,
                            fontWeight: FontWeight.w700),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5.0),
                        child: TextField(
                          onChanged: (value) {
                            gender = value;
                          },
                          decoration: InputDecoration.collapsed(
                            hintText: 'Gender',
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
                            print(controller.text);
                            print(controller2.text);
                            Firestore.instance
                                .collection('/society/$socID/users')
                                .document('$id')
                                .updateData(
                                    {"Phone - 2": phone, 'user-2': name});
                            Navigator.pop(context);
                          },
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0)),
                          color: Color(0xff1A2980),
                          child: Text(
                            'Upload',
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

  Future<bool> dialog(BuildContext context, String id) {
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
                  child: Column(children: [
                    GestureDetector(
                      onTap: () async {
                        SharedPreferences sPrefs =
                            await SharedPreferences.getInstance();
                        sPrefs.remove("email");
                        exit(0);
                      },
                      child: Text('Logout',
                          style: TextStyle(
                              fontSize: 20,
                              color: Color(0xff1A2980),
                              fontWeight: FontWeight.w400)),
                    ),
                    Divider(),
                    GestureDetector(
                      onTap: () {
                        addUser(context, id);
                      },
                      child: Text('Add user',
                          style: TextStyle(
                              fontSize: 20,
                              color: Color(0xff1A2980),
                              fontWeight: FontWeight.w400)),
                    ),
                  ]),
                ),
              ),
            ));
  }
}
