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
  // final SharedPrefs prefs;
  // final String email;
  // Profile({@required this.prefs, this.email}) : super();

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> with SingleTickerProviderStateMixin {
  // var controller = PageController(initialPage: 0);
  int selectedIndex = 0;
  AnimationController controller;
  // String get _emailId => widget.email;
  // SharedPrefs get _prefs => widget.prefs;

  @override
  void initState() {
    _bloc = widget.bloc;
    // _method;
    // parse = _emailId;
    // print("This is the email that is parsed $parse");
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
