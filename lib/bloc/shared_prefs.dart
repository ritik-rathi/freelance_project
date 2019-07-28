import 'dart:async';
import 'dart:core';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../soc_ID.dart';

var query1 = Firestore.instance.collection('/society/$socID/users');
var l1 = 0, l2 = 0, l3 = 0;

class SharedPrefs {
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

  Future<bool> authenticate({@required email, @required pwd}) async {
    var c = await query1.where('Email', isEqualTo: email).snapshots().first;
    l1 = c.documents.length;
    print(l1);

    var d = await query1.where('Password', isEqualTo: pwd).snapshots().first;
    l2 = d.documents.length;
    print(l2);

    if (l1 == 1 && l2 == 1) l3 = 1;
    return l3 == 1 ? true : false;
    // SharedPreferences prefs = await SharedPreferences.getInstance();
    // await Future.delayed(Duration(seconds: 1));
    // email = prefs.getString("email");
    // return email;
  }

  Future<void> deleteToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    print("Email being deleted = ${prefs.getString("email")}");
    prefs.remove("email");
    await Future.delayed(Duration(seconds: 1));
  }

  Future<void> writeToken(String email) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    print("Wmail that is being set = $email");
    prefs.setString("email", email);
    await Future.delayed(Duration(seconds: 1));
  }

  Future<String> hasToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var email = prefs.getString("email");
    print("Email in shared preffs = $email");
    return email;
  }
}
