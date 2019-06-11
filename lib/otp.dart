import 'dart:io';
import 'dart:math';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

int otp = Random().nextInt(99999);

var apiKey = "u89iYz/h3dU-3Ab3nrQBqIYMbe8KSzowDCSTslyGNM";
//from the acc that I am using
var message = "Your OTP is $otp"; //vary otp using dart
var sender = "TXTLCL"; //default sender, can be changed
var numbers = "919953610152"; //coz test

var url =
    'https://api.textlocal.in/send/?+apiKey=${apiKey}&message=${message}&sender=${sender}&numbers=${numbers}';

var response = http.get(url).then((res) {
  print(res);
});
