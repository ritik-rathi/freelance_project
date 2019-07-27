import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freelance/bloc/bloc.dart';
import 'package:freelance/guard_screens/guard_screens.dart';
import 'dart:async';
import 'dart:math' as math;
import 'package:freelance/soc_ID.dart';
import 'package:freelance/user_screens/profile.dart';
import 'package:freelance/user_screens/profile_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

var email;
String uid, upwd, spwd;
var tid, tpwd;
var query1 = Firestore.instance.collection('/society/$socID/users');
var query2 = Firestore.instance.collection('/society');
LoginBloc _loginBloc;
AuthenticationBloc _authenticationBloc;

class Login extends StatefulWidget {
  final SharedPrefs prefs;

  Login({@required this.prefs}) : super();
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> with TickerProviderStateMixin {
  SharedPrefs get _sharedPrefs => widget.prefs;

  int l1 = 0, l2 = 0, l3 = 0, l4 = 0, l5 = 0;
  Future<int> emailID(String id, String pwd) async {
    var c = await query1.where('Email', isEqualTo: id).snapshots().first;
    l1 = c.documents.length;
    print(l1);

    var d = await query1.where('Password', isEqualTo: pwd).snapshots().first;
    l2 = d.documents.length;
    print(l2);

    if (l1 == 1 && l2 == 1) l3 = 1;
    return l3;
  }

  Future<int> guardPass(String pwd) async {
    var c = await query2.where('password', isEqualTo: pwd).snapshots().first;
    l5 = c.documents.length;

    if (l5 == 1) l4 = 1;
    return l4;
  }

  final FocusNode myFocusNodeEmailLogin = FocusNode();
  final FocusNode myFocusNodePasswordLogin = FocusNode();

  final FocusNode myFocusNodePassword = FocusNode();
  final FocusNode myFocusNodeEmail = FocusNode();
  final FocusNode myFocusNodeName = FocusNode();

  TextEditingController emailCon = new TextEditingController();
  TextEditingController idCon = new TextEditingController();
  TextEditingController guard = new TextEditingController();

  bool _obscureTextLogin = true;

  TextEditingController signupEmailController = new TextEditingController();
  TextEditingController signupNameController = new TextEditingController();
  TextEditingController signupPasswordController = new TextEditingController();
  TextEditingController signupConfirmPasswordController =
      new TextEditingController();

  PageController _pageController;

  Color right = Colors.black;
  Color left = Colors.white;

  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  // final GlobalKey<FormState> _signkey = GlobalKey<FormState>();
  AnimationController fadeAnimationController;
  Animation fadeAnimation;

  @override
  void dispose() {
    myFocusNodePassword.dispose();
    myFocusNodeEmail.dispose();
    myFocusNodeName.dispose();
    _pageController.dispose();
    _loginBloc.dispose();
    super.dispose();
  }

  @override
  void initState() {
    emailCon.clear();
    // uid = "";
    tid = 0;
    tpwd = 0;
    _authenticationBloc = BlocProvider.of<AuthenticationBloc>(context);
    _loginBloc = LoginBloc(
      sharedPrefs: _sharedPrefs,
      authenticationBloc: _authenticationBloc,
    );
    fadeAnimationController =
        new AnimationController(vsync: this, duration: Duration(seconds: 5));
    fadeAnimation = new CurvedAnimation(
        curve: Curves.fastOutSlowIn, parent: fadeAnimationController);
    super.initState();

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    _pageController = new PageController(initialPage: 0);
  }

  @override
  Widget build(BuildContext context) {
    fadeAnimationController.forward();
    return FadeTransition(
      opacity: fadeAnimation,
      child: Scaffold(
          body: BlocBuilder(
              bloc: _authenticationBloc,
              builder: (BuildContext context, state) {
                if (state is AuthenticationUninitialized) {
                  return Container(
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
                    child: Center(
                      child: CircularProgressIndicator(
                        semanticsLabel: 'Loading',
                        backgroundColor: Colors.black,
                      ),
                    ),
                  );
                }
                if (state is AuthenticationUnauthenticated) {
                  return NotificationListener<OverscrollIndicatorNotification>(
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
                                colors: [
                                  Color(0xFF50CDFF),
                                  Color(0xff1A2980)
                                ])),
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
                                image:
                                    new AssetImage('assets/images/logo.jpeg'),
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
                                controller: _pageController,
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
                  );
                }
                if (state is AuthenticationAuthenticated) {
                  uid = state.userEmail;
                  if (state.userEmail != null) {
                    return Profile(
                      bloc: _authenticationBloc,
                    );
                  } else {
                    return MainScreen();
                  }
                }

                if (state is LoginFailure) {
                  return Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height >= 775.0
                        ? MediaQuery.of(context).size.height
                        : 775.0,
                    color: Colors.black,
                    child: Center(
                      child: Text(
                        'Error Occured\nPlease restart the app',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 25.0,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                  );
                }
              })),
    );
  }

  Widget _buildMenuBar(BuildContext context) {
    return Container(
      width: 300.0,
      height: 50.0,
      decoration: BoxDecoration(
        color: Color(0x552B2B2B).withAlpha(50),
        borderRadius: BorderRadius.all(Radius.circular(25.0)),
      ),
      child: CustomPaint(
        painter: TabIndicationPainter(pageController: _pageController),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Expanded(
              child: FlatButton(
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                onPressed: _onSignInButtonPress,
                child: Text(
                  "Resident",
                  style: TextStyle(
                      color: left,
                      fontSize: 16.0,
                      fontFamily: "WorkSansSemiBold"),
                ),
              ),
            ),
            Container(height: 33.0, width: 1.0, color: Colors.white),
            Expanded(
              child: FlatButton(
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                onPressed: _onSignUpButtonPress,
                child: Text(
                  "Guard",
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
                            controller: emailCon,
                            onChanged: (input) {
                              uid = input;
                            },
                            keyboardType: TextInputType.emailAddress,
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
                        Padding(
                          padding: EdgeInsets.only(
                              top: 20.0, bottom: 20.0, left: 25.0, right: 25.0),
                          child: TextField(
                            focusNode: myFocusNodePasswordLogin,
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
                    onPressed: () async {
                      print('testing ');
                      _onLoginButtonPressed();
                      emailID(emailCon.text, idCon.text).then((l3) {
                        if (l3 == 1) {
                          print('object');
                          print(email);
                          Navigator.pushReplacement(
                              context,
                              new MaterialPageRoute(
                                  builder: (context) => Profile(
                                        bloc: _authenticationBloc,
                                      )));
                        } else {
                          showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                    title: Column(
                                  children: <Widget>[
                                    Text('Enter valid credentials'),
                                    Padding(
                                      padding: EdgeInsets.all(10),
                                      child: MaterialButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        color: color,
                                        child: Text('Ok'),
                                      ),
                                    )
                                  ],
                                ));
                              });
                        }
                      });
                      setState(() {
                        emailCon.clear();
                        idCon.clear();
                      });
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
                  height: 100.0,
                  child: Form(
                    //key: _formkey,
                    child: Column(
                      children: <Widget>[
                        Container(
                          width: 250.0,
                          height: 1.0,
                          color: Colors.grey[400],
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              top: 20.0, bottom: 20.0, left: 25.0, right: 25.0),
                          child: TextFormField(
                            controller: guard,
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
                margin: EdgeInsets.only(top: 80.0),
                decoration: new BoxDecoration(
                  color: Color(0xFF50CDFF),
                  borderRadius: BorderRadius.all(Radius.circular(5.0)),
                  border: Border.all(color: Colors.white, width: 3),
                ),
                child: MaterialButton(
                    highlightColor: Colors.transparent,
                    splashColor: Color(0xFF50CDFF),
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
                    onPressed: () async {
                      print('testing ');
                      SharedPreferences prefs =
                          await SharedPreferences.getInstance();
                      prefs.setString('guard_pass', guard.text);
                      _onLoginButtonPressed();
                      guardPass(guard.text).then((l4) {
                        if (l4 == 1) {
                          print('object');
                          Navigator.pushReplacementNamed(context, '/splash');
                        } else {
                          showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                    title: Column(
                                  children: <Widget>[
                                    Text('Enter valid credentials'),
                                    Padding(
                                      padding: EdgeInsets.all(10),
                                      child: MaterialButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        color: color,
                                        child: Text('Ok'),
                                      ),
                                    )
                                  ],
                                ));
                              });
                        }
                      });
                      guard.clear();
                    }),
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
    _pageController.animateToPage(1,
        duration: Duration(milliseconds: 500), curve: Curves.decelerate);
  }

  _onLoginButtonPressed() {
    _loginBloc
        .dispatch(LoginButtonPressed(email: emailCon.text, pwd: guard.text));
  }

  void _toggleLogin() {
    setState(() {
      _obscureTextLogin = !_obscureTextLogin;
    });
  }

  // void _toggleSignup() {
  //   setState(() {
  //     _obscureTextSignup = !_obscureTextSignup;
  //   });
  // }

  // void _toggleSignupConfirm() {
  //   setState(() {
  //     _obscureTextSignupConfirm = !_obscureTextSignupConfirm;
  //   });
  // }
}

class TabIndicationPainter extends CustomPainter {
  Paint painter;
  final double dxTarget;
  final double dxEntry;
  final double radius;
  final double dy;

  final PageController pageController;

  TabIndicationPainter(
      {this.dxTarget = 125.0,
      this.dxEntry = 25.0,
      this.radius = 21.0,
      this.dy = 25.0,
      this.pageController})
      : super(repaint: pageController) {
    painter = new Paint()
      ..color = Color(0xff1A2980)
      ..style = PaintingStyle.fill;
  }

  @override
  void paint(Canvas canvas, Size size) {
    final pos = pageController.position;
    double fullExtent =
        (pos.maxScrollExtent - pos.minScrollExtent + pos.viewportDimension);

    double pageOffset = pos.extentBefore / fullExtent;

    bool left2right = dxEntry < dxTarget;
    Offset entry = new Offset(left2right ? dxEntry : dxTarget, dy);
    Offset target = new Offset(left2right ? dxTarget : dxEntry, dy);

    Path path = new Path();
    path.addArc(new Rect.fromCircle(center: entry, radius: radius),
        0.5 * math.pi, 1 * math.pi);
    path.addRect(
        new Rect.fromLTRB(entry.dx, dy - radius, target.dx, dy + radius));
    path.addArc(new Rect.fromCircle(center: target, radius: radius),
        1.5 * math.pi, 1 * math.pi);

    canvas.translate(size.width * pageOffset, 0.0);
    canvas.drawShadow(path, Color(0xFF50CDFF), 3.0, false);
    canvas.drawPath(path, painter);
  }

  @override
  bool shouldRepaint(TabIndicationPainter oldDelegate) => true;
}
