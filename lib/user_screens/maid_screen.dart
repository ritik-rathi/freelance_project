import 'package:flutter/material.dart';

class MaidScreen extends StatelessWidget {
  Color highlightColor = Color(0xffedff2d);
  Color color = Color(0xFF50CDFF);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Container(
            height: 200.0,
            width: double.infinity,
            color: color,
          ),
          Text('Your Maids',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 30.0,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 2.0)),
          Expanded(
            child: ListView.builder(
                itemCount: 10,
                itemBuilder: (context, index) {
                  return Padding(
                    padding:
                        EdgeInsets.symmetric(vertical: 16.0, horizontal: 20.0),
                    child: Align(
                      alignment: Alignment.center,
                      child: Container(
                        width: double.infinity,
                        height: 250.0,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(15.0),
                            border: Border.all(
                                color: Color.fromRGBO(212, 230, 252, 1.0)),
                            boxShadow: [
                              BoxShadow(
                                  color: Color.fromRGBO(212, 230, 252, 1.0),
                                  offset: Offset(5.0, 25.0),
                                  blurRadius: 80),
                            ]),
                        child: Stack(
                          children: <Widget>[
                            SizedBox(
                              width: 30.0,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(right: 20.0, top: 5.0),
                              child: Align(
                                alignment: Alignment.centerRight,
                                child: Container(
                                  height: 200,
                                  width: 240,
                                  decoration:
                                      BoxDecoration(border: Border.all()),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 10.0 , horizontal: 10.0),
                                    child: RichText(
                                      textAlign: TextAlign.left,
                                      text: TextSpan(children: [
                                        TextSpan(
                                            text: 'Name : ',
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 20.0,
                                                fontWeight: FontWeight.w700)),
                                        TextSpan(
                                            text: 'Rathi\n\n',
                                            style: TextStyle(
                                                backgroundColor: highlightColor,
                                                color: Colors.black,
                                                fontSize: 30.0,
                                                fontWeight: FontWeight.bold)),
                                        TextSpan(
                                            text: 'Works in:',
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 20.0,
                                                fontWeight: FontWeight.w700)),
                                        TextSpan(
                                            text: 'C-143\n\n',
                                            style: TextStyle(
                                                backgroundColor: highlightColor,
                                                color: Colors.black,
                                                fontSize: 30.0,
                                                fontWeight: FontWeight.bold))
                                      ]),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(top: 8.0, left: 15.0),
                              child: Container(
                                alignment: Alignment.topLeft,
                                width: 90.0,
                                height: 90.0,
                                decoration: BoxDecoration(
                                    color: Colors.teal,
                                    shape: BoxShape.rectangle,
                                    border: Border.all()),
                              ),
                            ),
                            Align(
                              alignment: Alignment.bottomRight,
                              child: FloatingActionButton(
                                onPressed: () {
                                  //edit screen
                                },
                                backgroundColor: index % 2 == 0
                                    ? Colors.red[400]
                                    : Colors.blue[400],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                }),
          ),
        ],
      ),
    );
  }
}
