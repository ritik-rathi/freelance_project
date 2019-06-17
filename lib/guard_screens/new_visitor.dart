import 'dart:io';

import 'package:flutter/material.dart';
import 'package:freelance/guard_screens/otp.dart';
import 'package:image_picker/image_picker.dart';

String vName, vPhone, vPurpose, vFlat, oName;
String vTime = TimeOfDay.now().toString();

class NewVisitorPage extends StatefulWidget {
  @override
  _NewVisitorPageState createState() => _NewVisitorPageState();
}

class _NewVisitorPageState extends State<NewVisitorPage> {
  File _image;

  Future getImage() async {
    var tempImage = await ImagePicker.pickImage(source: ImageSource.camera);

    setState(() {
      _image = tempImage;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff6B77E0),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding:
                  const EdgeInsets.only(top: 20.0, left: 10.0, right: 10.0),
              child: GestureDetector(
                onTap: () {
                  Route focusRoute = new MaterialPageRoute(
                      builder: (context) => Scaffold(
                          backgroundColor: Colors.black,
                          body: Center(
                              child: Hero(
                                  tag: "Focus",
                                  child: _image == null
                                      ? Text('Add Image to view',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 20.0,
                                              fontWeight: FontWeight.w500))
                                      : Image.file(_image)))));
                  Navigator.push(context, focusRoute);
                },
                child: Container(
                    width: double.infinity,
                    height: 256.0,
                    decoration: BoxDecoration(
                        color: Colors.black,
                        border: Border.all(width: 2.0, color: Colors.white)),
                    child: _image == null
                        ? Center(
                            child: Text(
                            'Add Image of the visitor',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 20.0,
                                fontWeight: FontWeight.w500),
                          ))
                        : Image.file(
                            _image,
                            fit: BoxFit.cover,
                          )),
              ),
            ),
            _buildAddCard()
          ],
        ),
      ),
      floatingActionButton: new FloatingActionButton(
        onPressed: getImage,
        backgroundColor: Colors.white,
        tooltip: 'Click Photo',
        child: Icon(Icons.camera_alt, color: Colors.black),
      ),
    );
  }

  Widget _buildAddCard() {
    return Padding(
      padding: const EdgeInsets.only(left: 10.0, right: 10.0, top: 20.0),
      child: Column(
        children: <Widget>[
          Container(
            width: double.infinity,
            height: 700.0,
            child: Column(
              children: <Widget>[
                new Text(
                  'Details',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 40.0,
                      fontWeight: FontWeight.w100),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(top: 10.0, left: 20.0, right: 20.0),
                  child: Column(
                    children: <Widget>[
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Name',
                          style: TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),
                      ),
                      TextField(
                        autofocus: false,
                        onChanged: (value) {
                          vName = value;
                        },
                        // controller: _taskTitleController,
                        decoration: InputDecoration(
                            hintText: 'Visitor\'s Name',
                            hintStyle: TextStyle(
                                color: Colors.grey,
                                fontWeight: FontWeight.w500,
                                fontSize: 12.0)),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(top: 10.0, left: 20.0, right: 20.0),
                  child: Column(
                    children: <Widget>[
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Phone Number',
                          style: TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),
                      ),
                      TextField(
                        autofocus: false,
                        onChanged: (value) {
                          vPhone = value;
                        },
                        // controller: _taskTimeController,
                        decoration: InputDecoration(
                            hintText: 'Visitor\'s Phone Number',
                            hintStyle: TextStyle(
                                color: Colors.grey,
                                fontWeight: FontWeight.w500,
                                fontSize: 12.0)),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(top: 10.0, left: 20.0, right: 20.0),
                  child: Column(
                    children: <Widget>[
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Flat Number',
                          style: TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),
                      ),
                      TextField(
                        autofocus: false,
                        onChanged: (value) {
                          vFlat = value;
                        },
                        // controller: _taskDesController,
                        decoration: InputDecoration(
                            hintText: 'Owner\'s Flat Number',
                            hintStyle: TextStyle(
                                color: Colors.grey,
                                fontWeight: FontWeight.w500,
                                fontSize: 12.0)),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(top: 10.0, left: 20.0, right: 20.0),
                  child: Column(
                    children: <Widget>[
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Purpose',
                          style: TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),
                      ),
                      TextField(
                        autofocus: false,
                        onChanged: (value) {
                          vPurpose = value;
                        },
                        // controller: _taskDesController,
                        decoration: InputDecoration(
                            hintText: 'Purpose',
                            hintStyle: TextStyle(
                                color: Colors.grey,
                                fontWeight: FontWeight.w500,
                                fontSize: 12.0)),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 18.0),
                  child: RaisedButton(
                    child: Text(
                      'Submit',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 30.0,
                          fontWeight: FontWeight.bold),
                    ),
                    color: Colors.blue,
                    onPressed: () {
                      if (vName != null &&
                          vPhone != null &&
                          vFlat != null &&
                          vTime != null &&
                          vPurpose != null) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => OtpTesting(
                                      phoneNo: vPhone,
                                      name: vName,
                                      house: vFlat,
                                      purpose: vPurpose,
                                      isGuest: true,
                                      ownName: oName,
                                      image: _image,
                                      firebaseMode: 0,
                                    )));
                      }
                      else showDialog(
                        context: context,
                        builder: (context){
                          return AlertDialog(
                            title: Center(
                              child: Text('Please enter details'), 
                            ),
                          );
                        }
                      );
                    },
                  ),
                )
              ],
            ),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.0),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                      color: Colors.black12,
                      offset: Offset(0.0, 15.0),
                      blurRadius: 15.0),
                  BoxShadow(
                      color: Colors.black12,
                      offset: Offset(0.0, -15.0),
                      blurRadius: 15.0)
                ]),
          ),
          SizedBox(
            height: 50.0,
          )
        ],
      ),
    );
  }
}
