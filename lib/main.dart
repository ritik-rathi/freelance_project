import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freelance/bloc/bloc.dart';
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
import 'package:bloc/bloc.dart';
import 'bloc/simple_bloc_delegate.dart';

void main() {
  BlocSupervisor.delegate = SimpleBlocDelegate();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(MyApp(
    // prefs: SharedPrefs(),
  ));
}

// class MyApp extends StatefulWidget {
//   final SharedPrefs prefs;

//   MyApp({this.prefs}) : super();

//   @override
//   _MyAppState createState() => _MyAppState();
// }

// class _MyAppState extends State<MyApp> {
//   AuthenticationBloc authenticationBloc;
//   SharedPrefs get prefs => widget.prefs;

//   @override
//   void initState() {
//     authenticationBloc = AuthenticationBloc(prefs: prefs);
//     authenticationBloc.dispatch(AppStarted());
//     super.initState();
//   }

//   @override
//   void dispose() {
//     authenticationBloc.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider<AuthenticationBloc>(
//       builder: (context) => authenticationBloc,
//       child: MaterialApp(
//         debugShowCheckedModeBanner: false,
//         title: 'HOMANTRA',
//         theme:
//             ThemeData(fontFamily: 'Poppins', primaryColor: Color(0xFF50CDFF)),
//         // initialRoute: '.',
//         routes: {
//           '.': (context) => Access(),
//           '/login': (context) => Login(
//                 prefs: prefs,
//               ),
//           '/newvisitor': (context) => NewVisitorPage(),
//           '/user': (context) => Profile(
//                 prefs: prefs,
//               ),
//           '/guard': (context) => MainScreen(),
//           '/delivery': (context) => DeliveryPage(),
//           '/maidrec': (context) => MaidRec(),
//           '/splash': (context) => SplashScreen(),
//           '/maidSched': (context) => MaidSched(),
//           '/frequent': (context) => Frequent(),
//           '/guardVisitor': (context) => GuardvisitorLog(),
//           '/today': (context) => TodayVisitor()
//         },
//         home: BlocBuilder(
//           bloc: authenticationBloc,
//           builder: (context, state) {
//             if (state is AuthenticationUninitialized) {
//               return SplashScreen();
//             }
//             if (state is AuthenticationAuthenticated) {
//               print("Authenticated email = ${state.userEmail}");
//               return Profile(prefs: prefs, email: state.userEmail);
//             }
//             if (state is AuthenticationUnauthenticated) {
//               return Access();
//             }
//             if (state is AuthenticationLoading) {
//               return Center(child: CircularProgressIndicator());
//             }
//           },
//         ),
//       ),
//     );
//   }
// }

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'HOMANTRA',
      theme: ThemeData(fontFamily: 'Poppins', primaryColor: Color(0xFF50CDFF)),
      home: Access(),
      initialRoute: '.',
      routes: {
        '.': (context) => Access(),
        // '/login': (context) => Login(),
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
