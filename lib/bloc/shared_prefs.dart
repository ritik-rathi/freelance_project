import 'dart:async';
import 'dart:core';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefs {
  Future<String> authenticate({@required email}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await Future.delayed(Duration(seconds: 1));
    email = prefs.getString("email");
    return email;
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

  Future<String> hasPassword() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var guard = prefs.getString("guard");
    print("Pwd in shared preffs = $guard");
    return guard;
  }

  Future<void> writePassword(String pwd) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    print("Pwd that is being set = $pwd");
    prefs.setString("guard", pwd);
    await Future.delayed(Duration(seconds: 1));
  }

  Future<void> deletePassword() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    print("Email being deleted = ${prefs.getString("guard")}");
    prefs.remove("guard");
    await Future.delayed(Duration(seconds: 1));
  }
}
