import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:freelance/soc_ID.dart';
import 'package:bloc/bloc.dart';
import 'bloc/simple_bloc_delegate.dart';

void main() {
  BlocSupervisor.delegate = SimpleBlocDelegate();
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
      home: Access(),
      initialRoute: '.',
      routes: {
        '.': (context) => Access(),
      },
    );
  }
}
