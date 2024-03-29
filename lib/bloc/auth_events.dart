import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

abstract class AuthenticationEvent extends Equatable {
  AuthenticationEvent([List props = const []]) : super(props);
}

class AppStarted extends AuthenticationEvent {
  final String token;
  final String socId;

  AppStarted({this.token , this.socId});

  @override
  String toString() => 'AppStarted : $token';
}

class LoggedIn extends AuthenticationEvent {
  final String token;
  final String password;

  LoggedIn({@required this.token , this.password}) : super([token , password]);

  @override
  String toString() => 'LoggedIn { token: $token }';
}

class LoggedOut extends AuthenticationEvent {
  @override
  String toString() => 'LoggedOut';
}
