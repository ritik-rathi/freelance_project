import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:freelance/soc_ID.dart';
import 'package:ansicolor/ansicolor.dart';

AnsiPen green = new AnsiPen()..green();
AnsiPen red = new AnsiPen()..red();
AnsiPen blue = new AnsiPen()..blue();

class MaidViewModel {
  String name;
  String time;
  String mobile;

  MaidViewModel({this.mobile, this.name, this.time}) : super();
}

class Test extends StatelessWidget {
  List<MaidViewModel> list = [];

  Future _getFuture() async {
    var stream;
    try {
      print(blue("Trying...."));
      stream = Firestore.instance
          .collection("/society/0aklfheb/maids")
          .snapshots()
          .map((data) {
        print(blue("Inside first map"));
        list = data.documents.map((rawPost) {
          print(blue("Inside second map"));
          var flatTime = rawPost["flatTime"];
          print(green(green(flatTime.length.toString())));
          MaidViewModel mvm = new MaidViewModel();
          for (int i = 0; i < flatTime.length; i++) {
            if (flatTime[i]["flat"] == "C 683") {
              mvm.time = flatTime[i]["time"];
              mvm.name = rawPost["name"];
              mvm.mobile = rawPost["mobile"];
            }
          }
          print(green(mvm.name));
          return mvm;
        }).toList();
        print(green(list.length.toString()));
        return list;
      }).toList();
    } catch (e) {
      print("Error occured ${e.toString()}");
    }
    // print(red(list.length.toString()));
    return stream;
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: MaterialButton(
        onPressed: () => _getFuture(),
        color: Colors.blue,
      ),
    );
  }
}
