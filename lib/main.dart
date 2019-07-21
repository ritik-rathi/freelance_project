import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:freelance/guard_screens/frequent_visitor.dart';
import 'package:freelance/guard_screens/todayVisitor.dart';
import 'package:freelance/guard_screens/visitor_log_guard.dart';
import 'package:freelance/soc_ID.dart';
import 'package:freelance/user_screens/maid_sched.dart';
import 'package:freelance/login.dart';
import 'package:freelance/guard_screens/delivery_details.dart';
import 'package:freelance/guard_screens/maidRec.dart';
import 'package:freelance/guard_screens/mainScreen.dart';
import 'package:freelance/guard_screens/new_visitor.dart';
import 'package:freelance/splashscreen.dart';
import 'package:freelance/user_screens/profile.dart';


void main() {
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'HOMANTRA',
      theme: ThemeData(fontFamily: 'Poppins', primaryColor: Color(0xFF50CDFF)),
      home: Login(),
      initialRoute: '.',
      routes: {
        '.': (context) => Access(),
        '/login': (context) => Login(),
        '/newvisitor': (context) => NewVisitorPage(),
        '/user': (context) => Profile(),
        '/guard': (context) => MainScreen(),
        '/delivery': (context) => DeliveryPage(),
        '/maidrec': (context) => MaidRec(),
        '/splash': (context) => SplashScreen(),
        '/maidSched': (context) => MaidSched(),
        '/frequent': (context) => Frequent(),
        '/guardVisitor': (context) => GuardvisitorLog(),
        '/today': (context) => TodayVisitor()
      },
    );
  }
}
