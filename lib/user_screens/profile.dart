import 'package:flutter/material.dart';
import 'package:freelance/bloc/bloc.dart';
import 'package:freelance/login.dart' as login;
import 'package:freelance/navbar.dart';
import 'package:freelance/user_screens/maid_screen.dart';
import 'package:freelance/user_screens/profile_screen.dart';
import 'package:freelance/user_screens/profile_screen.dart' as prefix2;
import 'package:freelance/user_screens/visitor_log.dart';
import 'package:shared_preferences/shared_preferences.dart';

var vTime = TimeOfDay.now();

class Profile extends StatefulWidget {
  final String email;

  Profile({this.email});

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> with SingleTickerProviderStateMixin {
  // var controller = PageController(initialPage: 0);
  int selectedIndex = 0;
  AnimationController controller;
  static String emailId;

  // _getEmailID() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   String email = prefs.getString("email");
  //   return email ?? "";
  // }

  @override
  void initState() {
    emailId = widget.email;
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

  List<Widget> pages = [
    ProfileScreen(
      email: user,
    ),
    VisitorLog(),
    MaidScreen()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: NavBar(
          bgColor: Color(0xff0d2956),
          names: ['Home', 'Visitors', 'Reg. visitors'],
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
