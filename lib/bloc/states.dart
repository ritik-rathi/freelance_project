import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

abstract class States extends Equatable {
  States([List props = const []]) : super();
}

class LoginStarts extends States {
  @override
  String toString() => 'Starting Login';
}

class LoginComplete extends States {
  final bool guard;
  final String id;
  final Widget widget;

  LoginComplete({this.guard, this.id, this.widget});

  LoginComplete copyWith(bool guard, String id, Widget widget) {
    return LoginComplete(
        guard: guard ?? this.guard,
        id: id ?? this.id,
        widget: widget ?? this.widget);
  }

  @override
  String toString() => 'Login info exists';
}

class LoginNotFound extends States {
  @override
  String toString() => 'Info doesnt exist';
}

class LoginError extends States {
  @override
  String toString() => 'Error occured';
}
