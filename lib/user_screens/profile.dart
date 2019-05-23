import 'package:flutter/cupertino.dart' as prefix0;
import 'package:flutter/material.dart';
import 'package:freelance/navbar.dart';
import 'package:freelance/user_screens/profile_screen.dart';

var vTime = TimeOfDay.now();

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> with SingleTickerProviderStateMixin {
  // var controller = PageController(initialPage: 0);
  int selectedIndex = 0;
  AnimationController controller;

  @override
  void initState() {
    controller = new AnimationController(
        vsync: this, duration: Duration(milliseconds: 500));
    super.initState();
    controller.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  List<Widget> pages = [ProfileScreen(), visitorLog(), maid()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: NavBar(
          bgColor: Color(0xff0d2956),
          names: ['Home', 'Visitors', 'Maids'],
          icons: [Icons.home, Icons.transit_enterexit, Icons.person],
          touchCallback: (int index) {
            controller.reset();
            controller.forward();
            selectedIndex = index;
          },
        ),
        body: pages[selectedIndex]);
  }

  // static Widget profile() {
  //   return Scaffold(
  //     floatingActionButton: FloatingActionButton.extended(
  //       onPressed: () {},
  //       icon: Icon(Icons.edit),
  //       label: Text('Edit info'),
  //     ),
  //     floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
  //     body: prefix0.Container(
  //       margin: prefix0.EdgeInsets.fromLTRB(16, 50, 16, 16),
  //       child: prefix0.Stack(
  //         children: <Widget>[
  //           Positioned(
  //             left: 20.0,
  //             top: 20.0,
  //             child: CircleAvatar(
  //               backgroundImage: AssetImage('assets/images/logo.jpeg'),
  //               radius: 50,
  //             ),
  //           ),
  //           SizedBox(height: 30),
  //           prefix0.Row(
  //             children: <Widget>[
  //               Icon(Icons.account_circle, size: 30),
  //               SizedBox(width: 15),
  //               Text('Ritik', style: TextStyle(fontSize: 25))
  //             ],
  //           ),
  //           SizedBox(height: 15),
  //           Row(
  //             children: <Widget>[
  //               Icon(Icons.phone, size: 30),
  //               SizedBox(width: 15),
  //               Text('9990637630', style: TextStyle(fontSize: 25))
  //             ],
  //           ),
  //           SizedBox(height: 15),
  //           Row(
  //             children: <Widget>[
  //               Icon(Icons.mail, size: 30),
  //               SizedBox(width: 15),
  //               Text('rathi27ritik@gmail.com', style: TextStyle(fontSize: 25))
  //             ],
  //           ),
  //           SizedBox(height: 15),
  //           Row(
  //             children: <Widget>[
  //               Icon(Icons.home, size: 30),
  //               SizedBox(width: 15),
  //               Text('1/522, Vaishali', style: TextStyle(fontSize: 25))
  //             ],
  //           ),
  //         ],
  //       ),
  //     ),
  //   );
  // }

  static Widget maid() {
    return Container(
      margin: EdgeInsets.only(top: 50, left: 20, right: 20, bottom: 20),
      child: Column(
        children: <Widget>[
          Text('Maid Schedules',
              style: TextStyle(
                  color: Color(0xFF50CDFF),
                  fontSize: 35,
                  fontWeight: FontWeight.bold)),
          Expanded(
            child: ListView.builder(
              itemCount: 4,
              itemBuilder: (context, index) {
                return Card(
                  elevation: 3,
                  child: Container(
                    margin: EdgeInsets.all(8),
                    child: prefix0.Column(
                      children: <Widget>[
                        prefix0.Row(
                          children: <prefix0.Widget>[
                            SizedBox(
                              width: 15,
                            ),
                            Icon(Icons.account_circle, size: 100),
                            SizedBox(width: 50),
                            Text('Shanta', style: TextStyle(fontSize: 25)),
                          ],
                        ),
                        Text('Schedule:', style: TextStyle(fontSize: 20)),
                        Text('9am - 402', style: TextStyle(fontSize: 20)),
                        Text('10am - 410', style: TextStyle(fontSize: 20)),
                        Text('11am - 803', style: TextStyle(fontSize: 20)),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            prefix0.Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: FloatingActionButton(
                                backgroundColor: Color(0xFF50CDFF),
                                onPressed: () {},
                                child: Icon(Icons.call),
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }

  static Widget visitorLog() {
    return Container(
      margin: EdgeInsets.only(top: 50, left: 20, right: 20),
      child: Column(
        children: <Widget>[
          Text('Visitor Log',
              style: TextStyle(
                  color: Color(0xFF50CDFF),
                  fontSize: 35,
                  fontWeight: FontWeight.bold)),
          Expanded(
            child: ListView.builder(
              itemCount: 5,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                      elevation: 3,
                      child: Container(
                        width: double.infinity,
                        margin: EdgeInsets.all(5),
                        child: Column(
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text('Name: Ritik',
                                    style: TextStyle(fontSize: 20)),
                                Text('$vTime')
                              ],
                            ),
                            Row(
                              children: <Widget>[
                                Text('Purpose: abcdefghijk',
                                    style: TextStyle(fontSize: 20),
                                    maxLines: 100,
                                    textAlign: TextAlign.start),
                              ],
                            )
                          ],
                        ),
                      )),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
