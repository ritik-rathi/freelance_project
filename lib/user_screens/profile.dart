import 'package:flutter/material.dart';
import 'package:freelance/bloc/bloc.dart';
import 'package:freelance/navbar.dart';
import 'package:freelance/user_screens/maid_screen.dart';
import 'package:freelance/user_screens/profile_screen.dart';
import 'package:freelance/user_screens/visitor_log.dart';
import 'package:shared_preferences/shared_preferences.dart';

var vTime = TimeOfDay.now();
var parse = "";
AuthenticationBloc _bloc;

class Profile extends StatefulWidget {
  final AuthenticationBloc bloc;

  Profile({this.bloc});

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> with SingleTickerProviderStateMixin {
  int selectedIndex = 0;
  AnimationController controller;

  @override
  void initState() {
    _bloc = widget.bloc;
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
      authenticationBloc: _bloc,
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
