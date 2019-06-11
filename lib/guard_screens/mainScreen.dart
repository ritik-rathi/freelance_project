import 'package:flutter/material.dart';
import 'package:freelance/guard_screens/new_visitor.dart';

class MainScreen extends StatelessWidget {
  final String user;

  MainScreen({this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Guard portal'),
        backgroundColor: Colors.white,
      ),
      backgroundColor: Colors.transparent,
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: GridView.count(
            // crossAxisSpacing: 5,
            // mainAxisSpacing: 5,
            childAspectRatio: 0.53,
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
                onTap: (){
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
                  onTap: () => Navigator.pushNamed(context, '/delivery'),
                  child: _optionCard(
                      'Delivery boy',
                      Color(0xffd8fbff),
                      Icon(
                        Icons.shopping_cart,
                        size: 50,
                      ))),
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, '/maidrec');
                },
                child: _optionCard(
                    'New Maid',
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
}
