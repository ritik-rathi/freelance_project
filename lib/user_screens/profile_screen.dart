import 'package:flutter/material.dart';

Color color = Color(0xFF50CDFF);

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.transparent,
        body: Column(
            //mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                height: 250,
                child: Stack(
                  children: <Widget>[
                    Container(
                      alignment: Alignment.topCenter,
                      height: 160.0,
                      width: double.infinity,
                      color: Color(0xFF50CDFF),
                    ),
                    Positioned(
                      top: 180,
                      left: 30,
                      child: Container(
                        height: 50,
                        width: 50,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: color)
                        ),
                        child: IconButton(
                          onPressed: (){},
                          icon: Icon(Icons.edit, size: 30,),
                          color: color,
                        ),
                      ),
                    ),
                    Positioned(
                      top: 180,
                      right: 30,
                      child: Container(
                        height: 50,
                        width: 50,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: color)
                        ),
                        child: IconButton(
                          onPressed: (){},
                          icon: Icon(Icons.local_phone, size: 30),
                          color: color,
                        ),
                      ),
                    ),
                    Positioned(
                        right: 20.0,
                        top: 20.0,
                        child: IconButton(
                          icon: Icon(
                            Icons.menu,
                            size: 30.0,
                            color: Colors.white,
                          ),
                          onPressed: () => dialog(context),
                        )),
                    Positioned(
                      top: 75.0,
                      left: 100,
                      child: Container(
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.grey, width: 3)),
                        // height: 160,
                        // width: 160,
                        padding: EdgeInsets.symmetric(horizontal: 20.0),
                        child: CircleAvatar(
                          backgroundImage:
                              AssetImage('assets/images/logo.jpeg'),
                          radius: 80,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 8),
              Container(
                margin: EdgeInsets.only(left: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text('Ritik Rathi', style: TextStyle(fontSize: 25, color: color))
                  ],
                ),
              ),
              SizedBox(height: 8),
              Container(
                margin: EdgeInsets.only(left: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text('rathi27ritik@gmail.com',
                        style: TextStyle(fontSize: 20))
                  ],
                ),
              ),
              SizedBox(height: 8),
              Container(
                margin: EdgeInsets.only(left: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text('9990637630', style: TextStyle(fontSize: 20))
                  ],
                ),
              ),
              SizedBox(height: 8),
              Divider(color: color),
              SizedBox(height: 8),
              Container(
                margin: EdgeInsets.only(left: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text('Owner', style: TextStyle(fontSize: 25, color: color))
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text('1/522, Vaishali', style: TextStyle(fontSize: 20))
                  ],
                ),
              ),
              SizedBox(height: 8),
              Divider(color: color),
              SizedBox(height: 8),
              Container(
                margin: EdgeInsets.only(left: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text('Council member', style: TextStyle(fontSize: 25, color: color))
                  ],
                ),
              ),
              SizedBox(height: 8),
              Container(
                margin: EdgeInsets.only(left: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text('RWA, Mahagun society', style: TextStyle(fontSize: 20))
                  ],
                ),
              ),

            ]));
  }

  Future<bool> dialog(BuildContext context) {
    return showDialog(
        context: context,
        child: Align(
          alignment: Alignment.topRight,
          child: Container(
            height: 85,
            width: 120,
            child: Card(
              color: Colors.white,
              elevation: 2,
              child: Column(
                children: <Widget>[
                  GestureDetector(
                    onTap: () {},
                    child: Text('Edit info', style: TextStyle(fontSize: 20)),
                  ),
                  Divider(),
                  GestureDetector(
                    onTap: () {},
                    child: Text('Logout', style: TextStyle(fontSize: 20)),
                  )
                ],
              ),
            ),
          ),
        ));
  }
}
