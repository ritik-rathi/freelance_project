import 'dart:io';
import 'package:image/image.dart' as Im;
import 'package:flutter/material.dart';
import 'package:freelance/guard_screens/otp.dart';
import 'package:image_picker/image_picker.dart';
import 'package:random_string/random_string.dart';

String vName, vPhone, vPurpose, vFlat, oName, uid;
int numFlats = 0;
String vTime = TimeOfDay.now().toString();

double _getVariableHeight() {
  switch (numFlats) {
    case (0):
      return 410.0;
      break;
    case (1):
      return 510.0;
      break;
    case (2):
      return 610.0;
      break;
    case (3):
      return 710.0;
      break;
    case (4):
      return 810.0;
      break;
    case (5):
      return 910.0;
      break;
    case (6):
      return 1010.0;
      break;
    case (7):
      return 1110.0;
      break;
    default:
      return 410.0;
  }
}

createList(int d) {
  var textEditingControllers = <TextEditingController>[];

  var textFields = <TextField>[];
  var finalList = <Padding>[];
  var list = new List<int>.generate(d, (i) => i + 1);
  print(list);

  list.forEach((i) {
    var textEditingController = new TextEditingController();
    textEditingControllers.add(textEditingController);
    return textFields.add(new TextField(controller: textEditingController));
  });
  return textFields;
}

class MaidRec extends StatefulWidget {
  @override
  _MaidRecState createState() => _MaidRecState();
}

class _MaidRecState extends State<MaidRec> with SingleTickerProviderStateMixin {
  File _image;
  TabController _controller;

  void initState() {
    super.initState();
    _controller = TabController(vsync: this, initialIndex: 0, length: 2);
  }

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
            height: _getVariableHeight(),
            child: Column(
              children: <Widget>[
                Container(
                  width: double.maxFinite,
                  height: 60,
                  child: TabBar(
                    unselectedLabelColor: Colors.grey,
                    unselectedLabelStyle: TextStyle(fontSize: 15),
                    labelColor: Colors.black,
                    labelStyle:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    controller: _controller,
                    tabs: <Widget>[
                      Tab(
                        child: Text('Maid'),
                      ),
                      Tab(
                        child: Text('Driver'),
                      )
                    ],
                  ),
                ),
                Container(
                  width: double.maxFinite,
                  height: _getVariableHeight() - 100,
                  child: TabBarView(
                    controller: _controller,
                    children: <Widget>[maid(), driver()],
                  ),
                ),
              ],
            ),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.0),
                // border: Border.all(width: 2.0),
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

  Widget maid() {
    return Container(
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
            padding: const EdgeInsets.only(top: 10.0, left: 20.0, right: 20.0),
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
                  onChanged: (value) {
                    vName = value;
                  },
                  decoration: InputDecoration(
                      hintText: 'Maid\'s Name',
                      hintStyle: TextStyle(
                          color: Colors.grey,
                          fontWeight: FontWeight.w500,
                          fontSize: 12.0)),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10.0, left: 20.0, right: 20.0),
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
                  // autofocus: true,
                  onChanged: (value) {
                    vPhone = value;
                  },
                  // controller: _taskTimeController,
                  decoration: InputDecoration(
                      hintText: 'Maid\'s Phone Number',
                      hintStyle: TextStyle(
                          color: Colors.grey,
                          fontWeight: FontWeight.w500,
                          fontSize: 12.0)),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10.0, left: 20.0, right: 20.0),
            child: Column(
              children: <Widget>[
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Number of flats',
                    style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                ),
                TextField(
                  onChanged: (value) {
                    setState(() {
                      numFlats = int.parse(value);
                    });
                  },
                  decoration: InputDecoration(
                      hintText: 'Number of houses for this maid',
                      hintStyle: TextStyle(
                          color: Colors.grey,
                          fontWeight: FontWeight.w500,
                          fontSize: 12.0)),
                )
              ],
            ),
          ),
          numFlats == 0
              ? SizedBox(height: 30.0)
              : Expanded(
                  child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  itemCount: numFlats,
                  itemBuilder: (context, index) {
                    Padding(
                      padding: const EdgeInsets.only(
                          top: 10.0, left: 20.0, right: 20.0),
                      child: Column(
                        children: <Widget>[
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Number of flats',
                              style: TextStyle(
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                            ),
                          ),
                          TextField(
                            onChanged: (value) {
                              setState(() {
                                numFlats = int.parse(value);
                              });
                            },
                            decoration: InputDecoration(
                                hintText: 'Number of houses for this maid',
                                hintStyle: TextStyle(
                                    color: Colors.grey,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 12.0)),
                          )
                        ],
                      ),
                    );
                  },
                )),
          Padding(
            padding: const EdgeInsets.only(top: 18.0),
            child: RaisedButton(
              child: Text(
                'Add record',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 30.0,
                    fontWeight: FontWeight.bold),
              ),
              color: Colors.blue,
              onPressed: () {
                uid = randomAlphaNumeric(6);
                print(uid);
                showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: Center(
                          child: Text('Unique ID is: $uid',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 20)),
                        ),
                      );
                    });
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => OtpTesting(
                              phoneNo: vPhone,
                              name: vName,
                              flatdetails: vFlat,
                              uid: uid,
                              image: _image,
                            )));
                // Navigator.pop(context);
                // _uploadDataToFirebase();
              },
            ),
          )
        ],
      ),
    );
  }

  Widget driver() {
    return Container(
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
            padding: const EdgeInsets.only(top: 10.0, left: 20.0, right: 20.0),
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
                  //autofocus: true,
                  onChanged: (value) {
                    vName = value;
                  },
                  // controller: _taskTitleController,
                  decoration: InputDecoration(
                      hintText: 'Driver\'s Name',
                      hintStyle: TextStyle(
                          color: Colors.grey,
                          fontWeight: FontWeight.w500,
                          fontSize: 12.0)),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10.0, left: 20.0, right: 20.0),
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
                  // autofocus: true,
                  onChanged: (value) {
                    vPhone = value;
                  },
                  // controller: _taskTimeController,
                  decoration: InputDecoration(
                      hintText: 'Driver\'s Phone Number',
                      hintStyle: TextStyle(
                          color: Colors.grey,
                          fontWeight: FontWeight.w500,
                          fontSize: 12.0)),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10.0, left: 20.0, right: 20.0),
            child: Column(
              children: <Widget>[
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Owner',
                    style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                ),
                TextField(
                  // autofocus: true,
                  onChanged: (value) {
                    vFlat = value;
                  },
                  // controller: _taskDesController,
                  decoration: InputDecoration(
                      hintText: 'Owner',
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
                'Add record',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 30.0,
                    fontWeight: FontWeight.bold),
              ),
              color: Colors.blue,
              onPressed: () {
                uid = randomAlphaNumeric(6);
                print(uid);
                showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: Center(
                          child: Text('Unique ID is: $uid',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 20)),
                        ),
                      );
                    });
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => OtpTesting(
                              phoneNo: vPhone,
                              name: vName,
                              ownName: vFlat,
                              uid: uid,
                              image: _image,
                            )));
                // Navigator.pop(context);
                // _uploadDataToFirebase();
              },
            ),
          )
        ],
      ),
    );
  }
}
