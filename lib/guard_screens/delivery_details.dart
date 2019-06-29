import 'dart:io';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:freelance/guard_screens/otp.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image/image.dart' as Im;

String dName = "", dPhone = "", dOrg = "", block = "", rFlat = "", rName = "";
String dTime = TimeOfDay.now().toString();

class DeliveryPage extends StatefulWidget {
  @override
  _DeliveryPageState createState() => _DeliveryPageState();
}

class _DeliveryPageState extends State<DeliveryPage> {
  File _image;

  Future getImage() async {
    var tempImage = await ImagePicker.pickImage(source: ImageSource.camera);
    Im.Image imageFile = Im.decodeImage(tempImage.readAsBytesSync());
    File compressedImage = tempImage
      ..writeAsBytesSync(Im.encodeJpg(imageFile, quality: 85));
    setState(() {
      _image = compressedImage;
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
                    margin: EdgeInsets.only(top: 20),
                    width: double.infinity,
                    height: 256.0,
                    decoration: BoxDecoration(
                        color: Colors.black,
                        shape: BoxShape.circle,
                        border: Border.all(width: 2.0, color: Colors.white)),
                    child: Hero(
                      tag: "Focus",
                      child: _image == null
                          ? Center(
                              child: Text(
                              'Add Image of Delivery Boy',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.w500),
                            ))
                          : Image.file(
                              _image,
                              fit: BoxFit.cover,
                            ),
                    )),
              ),
            ),
            _buildAddCard()
          ],
        ),
      ),
      floatingActionButton: new FloatingActionButton(
        onPressed: getImage,
        backgroundColor: Color(0xffd8fbff),
        foregroundColor: Colors.white,
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
                          dName = value;
                        },
                        decoration: InputDecoration(
                            hintText: 'Name',
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
                          dPhone = value;
                        },
                        decoration: InputDecoration(
                            hintText: 'Phone Number',
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
                          'Block',
                          style: TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),
                      ),
                      TextField(
                        autofocus: false,
                        onChanged: (value) {
                          block = value;
                        },
                        decoration: InputDecoration(
                            hintText: 'Block',
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
                          rFlat = value;
                        },
                        decoration: InputDecoration(
                            hintText: 'Flat Number',
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
                          'Recepient\'s Name',
                          style: TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),
                      ),
                      TextField(
                        autofocus: false,
                        onChanged: (value) {
                          rName = value;
                        },
                        decoration: InputDecoration(
                            hintText: 'Name of the flat owner',
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
                          'Organization',
                          style: TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),
                      ),
                      TextField(
                        autofocus: false,
                        onChanged: (value) {
                          dOrg = value;
                        },
                        decoration: InputDecoration(
                            hintText: 'Name of the organization',
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
                      if (block != "" &&
                          dName != "" &&
                          dPhone != "" &&
                          dPhone.length == 10 &&
                          dOrg != "" &&
                          rName != "" &&
                          rFlat != "") {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => OtpTesting(
                                      firebaseMode: 1,
                                      block: block,
                                      name: dName,
                                      phoneNo: dPhone,
                                      org: dOrg,
                                      ownName: rName,
                                      house: rFlat,
                                    )));
                      } else {
                        showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: Center(
                                  child: Text('Please enter valid details'),
                                ),
                              );
                            });
                      }
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
