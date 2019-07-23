import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freelance/bloc/bloc.dart' as bloc;
import 'package:shared_preferences/shared_preferences.dart';

import '../login.dart';

class MainScreen extends StatelessWidget {
  final String user;

  MainScreen({this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('Guard portal'),
        backgroundColor: Colors.white,
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.more_vert,
              size: 30.0,
              color: Colors.black,
            ),
            onPressed: () => dialog(context),
          )
        ],
      ),
      backgroundColor: Colors.transparent,
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: GridView.count(
            // crossAxisSpacing: 5,
            // mainAxisSpacing: 5,
            childAspectRatio: 0.5,
            crossAxisCount: 2,
            children: [
              GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, '/newvisitor');
                  },
                  child: _optionCard(
                      'New Visitor',
                      Color(0xFF50CDFF),
                      Icon(
                        Icons.supervisor_account,
                        size: 50,
                      ))),
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, '/frequent');
                },
                child: _optionCard(
                    'Frequent visitor',
                    Color(0xffd8fbff),
                    Icon(
                      Icons.card_membership,
                      size: 50,
                    )),
              ),
              GestureDetector(
                  onTap: () => Navigator.pushNamed(context, '/guardVisitor'),
                  child: _optionCard(
                      'Visitor log',
                      Color(0xffd8fbff),
                      Icon(
                        Icons.people,
                        size: 50,
                      ))),
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, '/today');
                },
                child: _optionCard(
                    'Today\'s visitors',
                    Color(0xFF50CDFF),
                    Icon(
                      Icons.supervisor_account,
                      size: 50,
                    )),
              )
            ]),
        // Column(
        //   mainAxisAlignment: MainAxisAlignment.center,
        //   crossAxisAlignment: CrossAxisAlignment.center,
        //   children: <Widget>[
        //     GestureDetector(
        //         onTap: () {
        //           Navigator.push(
        //               context,
        //               MaterialPageRoute(
        //                   builder: (context) => NewVisitorPage()));
        //         },
        //         child: _optionCard('New Visitor')),
        //     _optionCard('Regular'),
        //     _optionCard('Delivery')
        //   ],
        // ),
        decoration: BoxDecoration(
            gradient: RadialGradient(
                center: Alignment.topLeft,
                radius: 2.0,
                colors: [Color(0xff6B77E0), Color(0xff9388FF)],
                tileMode: TileMode.clamp)),
      ),
    );
  }

  Widget _optionCard(String page, Color color, Icon icon) {
    return Container(
      height: 1000,
      color: color,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          icon,
          Text(
            page,
            style: new TextStyle(
                color: Colors.black,
                fontSize: 20.0,
                fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  Future<bool> dialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) => Align(
              alignment: Alignment.topRight,
              child: Container(
                height: 85,
                width: 120,
                child: Card(
                  color: Colors.white,
                  elevation: 2,
                  child: Center(
                    child: GestureDetector(
                      onTap: () async {
                        SharedPreferences prefs =
                            await SharedPreferences.getInstance();
                        prefs.remove("guard_pass");
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => BlocProvider(
                                    child: Login(),
                                    builder: (context) => bloc.LoginBloc()
                                      ..dispatch(bloc.Login()))));
                      },
                      child: Text('Logout',
                          style: TextStyle(
                              fontSize: 30,
                              color: Color(0xff1A2980),
                              fontWeight: FontWeight.w400)),
                    ),
                  ),
                ),
              ),
            ));
  }
}
