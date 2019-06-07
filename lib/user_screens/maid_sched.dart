import 'package:flutter/material.dart';

final Color highlightColor = Color(0xffedff2d);

class MaidSched extends StatefulWidget {
  @override
  _MaidSchedState createState() => _MaidSchedState();
}

class _MaidSchedState extends State<MaidSched> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          children: <Widget>[
            Container(
              height: 160.0,
              width: double.infinity,
              color: Color(0xFF50CDFF),
              child: Column(children: [
                SizedBox(height: 110),
                Text(
                  'Schedule',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                      letterSpacing: 2.5,
                      color: Colors.white,
                      fontSize: 35.0,
                      fontWeight: FontWeight.w600),
                ),
              ]),
            ),
            Expanded(
              child: ListView.builder(
                  itemCount: 4,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(
                          left: 30, right: 30, top: 10, bottom: 10),
                      child: Card(
                        color: Color(0xFF50CDFF),
                        elevation: 3,
                        child: Container(
                          height: 100,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              Icon(Icons.home, size: 40, color: Colors.white,),
                              Text('C-710',
                                  style: TextStyle(
                                      fontSize: 25,
                                      backgroundColor: Colors.white,
                                      fontWeight: FontWeight.bold)),
                              Text('11:00 AM',
                                  style: TextStyle(
                                      fontSize: 25,
                                      backgroundColor: Colors.white,
                                      fontWeight: FontWeight.bold))
                            ],
                          ),
                        ),
                      ),
                    );
                  }),
            )
          ],
        ),
      ),
    );
  }
}
