import 'dart:io';
import 'package:image/image.dart' as Im;
import 'package:flutter/material.dart';
import 'package:freelance/guard_screens/otp.dart';
import 'package:image_picker/image_picker.dart';
import 'package:random_string/random_string.dart';

String name = "", phone = "", oName = "", uid;
int numFlats = 0;

List<dynamic> finalMap = [
  {"flat": "", "time": ""},
  {"flat": "", "time": ""},
  {"flat": "", "time": ""},
  {"flat": "", "time": ""},
  {"flat": "", "time": ""},
  {"flat": "", "time": ""},
  {"flat": "", "time": ""}
];

double _getVariableHeight() {
  switch (numFlats) {
    case (0):
      return 510.0;
      break;
    case (1):
      return 610.0;
      break;
    case (2):
      return 710.0;
      break;
    case (3):
      return 810.0;
      break;
    case (4):
      return 910.0;
      break;
    case (5):
      return 1010.0;
      break;
    case (6):
      return 1110.0;
      break;
    case (7):
      return 1210.0;
      break;
    default:
      return 510.0;
  }
}

createList(int d) {
  var headings = <Text>[];
  var textFields = <TextField>[];
  var finalList = <Padding>[];

  var list = [];
  // print(list);

  list.forEach((i) {
    var text = 'Flat- $i';
    headings.add(Text(
      text,
      style: TextStyle(color: Colors.black, fontSize: 22.0),
    ));
    textFields.add(new TextField());
  });
  return headings;
}

class MaidRec extends StatefulWidget {
  @override
  _MaidRecState createState() => _MaidRecState();
}

class _MaidRecState extends State<MaidRec> with SingleTickerProviderStateMixin {
  File _image;
  TabController _controller;
  var flatControllers = <TextEditingController>[];
  var timeControllers = <TextEditingController>[];

  void initState() {
    super.initState();
    // _getMap();
    // _getTimeMap();
    for (int i = 0; i < 7; i++) {
      flatControllers.add(new TextEditingController());
      timeControllers.add(new TextEditingController());
    }
    print(flatControllers.length + timeControllers.length);
    print(timeControllers.length);
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
                        shape: BoxShape.circle,
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
            height: _getVariableHeight() + 50,
            child: Column(
              children: <Widget>[
                Container(
                  width: double.maxFinite,
                  height: 60,
                  child: TabBar(
                    isScrollable: false,
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
                  height: _getVariableHeight() - 20,
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
                    name = value;
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
                  keyboardType: TextInputType.number,
                  onChanged: (value) {
                    phone = value;
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
                  keyboardType: TextInputType.number,
                  onChanged: (value) {
                    setState(() {
                      numFlats = int.parse(value);
                    });
                  },
                  decoration: InputDecoration(
                      hintText: 'Number of houses(max 7)',
                      hintStyle: TextStyle(
                          color: Colors.grey,
                          fontWeight: FontWeight.w500,
                          fontSize: 12.0)),
                )
              ],
            ),
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding:
                  const EdgeInsets.only(top: 10.0, left: 20.0, right: 20.0),
              child: Text(
                'Flats and Times',
                textAlign: TextAlign.left,
                style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10.0),
            child: numFlats == 0
                ? Center(
                    child: Text(
                      numFlats == 0
                          ? 'Enter number of flats'
                          : 'Enter less flats',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 20.0,
                          fontWeight: FontWeight.w300),
                    ),
                  )
                : Container(
                    height: numFlats == 1 ? 100.0 : _getVariableHeight() - 600,
                    width: double.infinity,
                    child: ListView.builder(
                      scrollDirection: Axis.vertical,
                      itemCount: numFlats,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding:
                              const EdgeInsets.only(left: 20.0, right: 20.0),
                          child: Card(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Expanded(
                                  child: Column(
                                    children: <Widget>[
                                      Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          'Flat- ${index + 1}',
                                          style: TextStyle(
                                              fontSize: 20.0,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black),
                                        ),
                                      ),
                                      TextField(
                                        controller: flatControllers[index],
                                        onChanged: (value) {
                                          print("$index" +
                                              flatControllers[index].text);
                                          finalMap[index]["flat"] =
                                              flatControllers[index].text;
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
                                Expanded(
                                  child: Column(
                                    children: <Widget>[
                                      Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          'Time',
                                          style: TextStyle(
                                              fontSize: 20.0,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black),
                                        ),
                                      ),
                                      TextField(
                                        controller: timeControllers[index],
                                        onChanged: (value) {
                                          print(timeControllers[index].text);
                                          finalMap[index]["time"] =
                                              timeControllers[index].text;
                                        },
                                        decoration: InputDecoration(
                                            hintText: '24hour format',
                                            hintStyle: TextStyle(
                                                color: Colors.grey,
                                                fontWeight: FontWeight.w500,
                                                fontSize: 12.0)),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
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
                for (int i = 0; i < 7; i++) {
                  flatControllers[i].clear();
                  timeControllers[i].clear();
                  if (finalMap[i]["flat"] == "" || finalMap[i]["time"] == "") {
                    finalMap.remove(i);
                  } else {
                    continue;
                  }
                }
                print(finalMap);
                uid = randomAlphaNumeric(6);
                print(uid);
                if (name != "" &&
                    phone != "" &&
                    phone.length == 10 &&
                    numFlats != 0 &&
                    finalMap[0]["flat"] != "" &&
                    finalMap[0]["time"] != "") {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          actions: <Widget>[
                            GestureDetector(
                              child: Icon(
                                Icons.check,
                                color: Color(0xff1A2980),
                              ),
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => OtpTesting(
                                              phoneNo: phone,
                                              name: name,
                                              flatdetails: finalMap,
                                              uid: uid,
                                              image: _image,
                                              firebaseMode: 3,
                                            )));
                                // finalMap.clear();
                              },
                            )
                          ],
                          title: Center(
                            child: Text('Unique ID is: $uid',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 20)),
                          ),
                        );
                      });
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
                    name = value;
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
                  keyboardType: TextInputType.number,
                  onChanged: (value) {
                    phone = value;
                  },
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
                    oName = value;
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
                if (name != "" &&
                    phone != "" &&
                    phone.length == 10 &&
                    oName != "") {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          actions: <Widget>[
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => OtpTesting(
                                              firebaseMode: 2,
                                              phoneNo: phone,
                                              name: name,
                                              ownName: oName,
                                              uid: uid,
                                              image: _image,
                                            )));
                              },
                              child: Icon(
                                Icons.check,
                                color: Color(0xff1A2980),
                              ),
                            )
                          ],
                          title: Center(
                            child: Text('Unique ID is: $uid',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 20)),
                          ),
                        );
                      });
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
    );
  }
}
