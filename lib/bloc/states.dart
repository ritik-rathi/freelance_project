import 'package:equatable/equatable.dart';

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

  LoginComplete({this.guard , this.id});

  @override
  String toString() => 'Login info exists';
}

class LoginNotFound extends States{
  @override
  String toString() => 'Info doesnt exist';
}

class LoginError extends States{
  @override
  String toString() => 'Error occured';
}
