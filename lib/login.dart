import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:async';

import 'package:freelance/soc_ID.dart';

//Implement society id check

bool email = false, password = false;
String uid, upwd, spwd;
var tid, tpwd;
var query = Firestore.instance.collection('/society/$socID/users');

class Login extends StatefulWidget {
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> with TickerProviderStateMixin {
  int l1 = 0, l2 = 0, l3 = 0;
  Future<int> emailID(String id, String pwd) async {
    var c = await query.where('Email', isEqualTo: id).snapshots().first;
    l1 = c.documents.length;
    print(l1);

    var d = await query.where('Password', isEqualTo: pwd).snapshots().first;
    l2 = d.documents.length;
    print(l2);

    if (l1 == 1 && l2 == 1) l3 = 1;
    return l3;
  }

  final FocusNode myFocusNodeEmailLogin = FocusNode();
  final FocusNode myFocusNodePasswordLogin = FocusNode();

  final FocusNode myFocusNodePassword = FocusNode();
  final FocusNode myFocusNodeEmail = FocusNode();
  final FocusNode myFocusNodeName = FocusNode();

  TextEditingController emailCon = new TextEditingController();
  TextEditingController idCon = new TextEditingController();

  bool _obscureTextLogin = true;
  bool _obscureTextSignup = true;
  bool _obscureTextSignupConfirm = true;

  TextEditingController signupEmailController = new TextEditingController();
  TextEditingController signupNameController = new TextEditingController();
  TextEditingController signupPasswordController = new TextEditingController();
  TextEditingController signupConfirmPasswordController =
      new TextEditingController();

  PageController _pageController;

  Color right = Colors.black;
  Color left = Colors.white;

  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  final GlobalKey<FormState> _signkey = GlobalKey<FormState>();
  AnimationController fadeAnimationController;
  Animation fadeAnimation;

  @override
  Widget build(BuildContext context) {
    fadeAnimationController.forward();
    return FadeTransition(
      opacity: fadeAnimation,
      child: Scaffold(
          body: NotificationListener<OverscrollIndicatorNotification>(
        child: SingleChildScrollView(
          // The main container or background that contains everything
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height >= 775.0
                ? MediaQuery.of(context).size.height
                : 775.0,
            decoration: new BoxDecoration(
                gradient: new LinearGradient(
                    begin: const FractionalOffset(0.0, 0.0),
                    end: const FractionalOffset(1.0, 1.0),
                    stops: [0.0, 1.0],
                    tileMode: TileMode.clamp,
                    colors: [Color(0xFF50CDFF), Color(0xff1A2980)])),
            // Column is used to display the rest of the widgets vertically
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                // Our logo. can be tweaked
                Padding(
                  padding: const EdgeInsets.only(
                      top: 150.0, left: 20.0, right: 20.0),
                  child: new Image(
                    width: 150.0,
                    height: 150.0,
                    fit: BoxFit.cover,
                    image: new AssetImage('assets/images/logo.jpeg'),
                  ),
                ),
                //fucntion used for building the menu bar
                new Padding(
                    padding: EdgeInsets.all(8.0),
                    child: _buildMenuBar(context)),
                new Expanded(
                  flex: 2,
                  // below is a check that finds out which tab is active and sets the color accordingly
                  child: PageView(
                    onPageChanged: (i) {
                      if (i == 0) {
                        setState(() {
                          right = Colors.black;
                          left = Colors.white;
                        });
                      } else if (i == 1) {
                        setState(() {
                          right = Colors.white;
                          left = Colors.black;
                        });
                      }
                    },
                    children: <Widget>[
                      //the sign in widgets
                      new ConstrainedBox(
                        constraints: const BoxConstraints.expand(),
                        child: _buildParentSignIn(context),
                      ),
                      new ConstrainedBox(
                        constraints: const BoxConstraints.expand(),
                        child: _buildTeacherSignIn(context),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      )),
    );
  }

  @override
  void dispose() {
    myFocusNodePassword.dispose();
    myFocusNodeEmail.dispose();
    myFocusNodeName.dispose();
    _pageController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    //login();
    tid = 0;
    tpwd = 0;
    fadeAnimationController =
        new AnimationController(vsync: this, duration: Duration(seconds: 5));
    fadeAnimation = new CurvedAnimation(
        curve: Curves.fastOutSlowIn, parent: fadeAnimationController);
    super.initState();

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    _pageController = PageController();
  }

  Widget _buildMenuBar(BuildContext context) {
    return Container(
      width: 300.0,
      height: 50.0,
      decoration: BoxDecoration(
        color: Color(0x552B2B2B),
        borderRadius: BorderRadius.all(Radius.circular(25.0)),
      ),
      child: CustomPaint(
        // painter: TabIndicationPainter(pageController: _pageController),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Expanded(
              child: FlatButton(
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                onPressed: _onSignInButtonPress,
                child: Text(
                  "User",
                  style: TextStyle(
                      color: left,
                      fontSize: 16.0,
                      fontFamily: "WorkSansSemiBold"),
                ),
              ),
            ),
            //Container(height: 33.0, width: 1.0, color: Colors.white),
            Expanded(
              child: FlatButton(
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                onPressed: _onSignUpButtonPress,
                child: Text(
                  "Society",
                  style: TextStyle(
                      color: right,
                      fontSize: 16.0,
                      fontFamily: "WorkSansSemiBold"),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildParentSignIn(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 23.0),
      child: Column(
        children: <Widget>[
          Stack(
            alignment: Alignment.topCenter,
            overflow: Overflow.visible,
            children: <Widget>[
              Card(
                elevation: 2.0,
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Container(
                  width: 300.0,
                  height: 200.0,
                  child: Form(
                    key: _formkey,
                    child: Column(
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(
                              top: 20.0, bottom: 20.0, left: 25.0, right: 25.0),
                          child: TextField(
                            focusNode: myFocusNodeEmailLogin,
                            // validator: (input) {
                            //   if (input.length < 8)
                            //     return "Make sure your password consists of atleast 8 letters";
                            // },
                            controller: emailCon,
                            onChanged: (input) {
                              uid = input;
                            },
                            // keyboardType: TextInputType.emailAddress,
                            style: TextStyle(
                                fontFamily: "WorkSansSemiBold",
                                fontSize: 16.0,
                                color: Colors.black),
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              icon: Icon(
                                Icons.event_note,
                                color: Colors.black,
                                size: 22.0,
                              ),
                              hintText: "Username",
                              hintStyle: TextStyle(
                                  fontFamily: "WorkSansSemiBold",
                                  fontSize: 17.0),
                            ),
                          ),
                        ),

                        // Container(
                        //   width: 250.0,
                        //   height: 1.0,
                        //   color: Colors.grey[400],
                        // ),
                        Padding(
                          padding: EdgeInsets.only(
                              top: 20.0, bottom: 20.0, left: 25.0, right: 25.0),
                          child: TextField(
                            focusNode: myFocusNodePasswordLogin,
                            // validator: (input) {
                            //   if (input.length < 4)
                            //     return "Make sure your password consists of atleast 8 letters";
                            // },
                            onChanged: (input) {
                              upwd = input;
                            },
                            controller: idCon,
                            obscureText: _obscureTextLogin,
                            style: TextStyle(
                                fontFamily: "WorkSansSemiBold",
                                fontSize: 16.0,
                                color: Colors.black),
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              icon: Icon(
                                Icons.lock,
                                size: 22.0,
                                color: Colors.black,
                              ),
                              hintText: "Password",
                              hintStyle: TextStyle(
                                  fontFamily: "WorkSansSemiBold",
                                  fontSize: 17.0),
                              suffixIcon: GestureDetector(
                                onTap: _toggleLogin,
                                child: Icon(
                                  Icons.remove_red_eye,
                                  size: 25.0,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 175.0),
                decoration: new BoxDecoration(
                  color: Color(0xFF50CDFF),
                  borderRadius: BorderRadius.all(Radius.circular(5.0)),
                  border: Border.all(color: Colors.white, width: 3),
                ),
                child: MaterialButton(
                    highlightColor: Colors.transparent,
                    splashColor: Color(0xFF50CDFF),
                    //shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(5.0))),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 42.0),
                      child: Text(
                        "LOGIN",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 25.0,
                            fontFamily: "WorkSansBold"),
                      ),
                    ),
                    onPressed: () {
                      print('testing ');
                      emailID(emailCon.text, idCon.text).then((l3) {
                        if (l3 == 1) {
                          print('object');
                          Navigator.pushReplacementNamed(context, '/user');
                        } else {
                          showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title: Text('Enter valid credentials'),
                                );
                              });
                        }
                      });
                      emailCon.clear();
                      idCon.clear();
                    }),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTeacherSignIn(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 23.0),
      child: Column(
        children: <Widget>[
          Stack(
            alignment: Alignment.topCenter,
            overflow: Overflow.visible,
            children: <Widget>[
              Card(
                elevation: 2.0,
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Container(
                  width: 300.0,
                  height: 190.0,
                  child: Form(
                    //key: _formkey,
                    child: Column(
                      children: <Widget>[
                        // Container(
                        //   width: 250.0,
                        //   height: 1.0,
                        //   color: Colors.grey[400],
                        // ),
                        Padding(
                          padding: EdgeInsets.only(
                              top: 20.0, bottom: 20.0, left: 25.0, right: 25.0),
                          child: TextFormField(
                            focusNode: myFocusNodePasswordLogin,
                            validator: (input) {
                              if (input.length < 4)
                                return "Make sure your password consists of atleast 8 letters";
                            },
                            onFieldSubmitted: (input) {
                              spwd = input;
                            },
                            obscureText: _obscureTextLogin,
                            style: TextStyle(
                                fontFamily: "WorkSansSemiBold",
                                fontSize: 16.0,
                                color: Colors.black),
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              icon: Icon(
                                Icons.lock,
                                size: 22.0,
                                color: Colors.black,
                              ),
                              hintText: "Password",
                              hintStyle: TextStyle(
                                  fontFamily: "WorkSansSemiBold",
                                  fontSize: 17.0),
                              suffixIcon: GestureDetector(
                                onTap: _toggleLogin,
                                child: Icon(
                                  Icons.check_box,
                                  size: 15.0,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 170.0),
                decoration: new BoxDecoration(
                  color: Color(0xFF50CDFF),
                  borderRadius: BorderRadius.all(Radius.circular(5.0)),
                  border: Border.all(color: Colors.white, width: 3),
                ),
                child: MaterialButton(
                    highlightColor: Colors.transparent,
                    splashColor: Color(0xFF50CDFF),
                    //shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(5.0))),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 42.0),
                      child: Text(
                        "LOGIN",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 25.0,
                            fontFamily: "WorkSansBold"),
                      ),
                    ),
                    onPressed: () {
                      Navigator.pushReplacementNamed(context, '/splash');
                      // login();
                      // Navigator.pushNamed(context, '/home');
                    } // showInSnackBar("Login button pressed")),
                    ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _onSignInButtonPress() {
    _pageController.animateToPage(0,
        duration: Duration(milliseconds: 500), curve: Curves.decelerate);
  }

  void _onSignUpButtonPress() {
    _pageController?.animateToPage(1,
        duration: Duration(milliseconds: 500), curve: Curves.decelerate);
  }

  void _toggleLogin() {
    setState(() {
      _obscureTextLogin = !_obscureTextLogin;
    });
  }

  void _toggleSignup() {
    setState(() {
      _obscureTextSignup = !_obscureTextSignup;
    });
  }

  void _toggleSignupConfirm() {
    setState(() {
      _obscureTextSignupConfirm = !_obscureTextSignupConfirm;
    });
  }
}
