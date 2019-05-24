import 'package:flutter/cupertino.dart' as prefix0;
import 'package:flutter/material.dart';
import 'package:freelance/navbar.dart';
import 'package:freelance/user_screens/maid_screen.dart';
import 'package:freelance/user_screens/profile_screen.dart';
import 'package:freelance/user_screens/visitor_log.dart';

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

  List<Widget> pages = [ProfileScreen(), VisitorLog(), MaidScreen()];

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
}
