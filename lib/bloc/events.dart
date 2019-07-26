import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

abstract class LoginEvent extends Equatable {
  LoginEvent([List props = const []]) : super(props);
}

class LoginButtonPressed extends LoginEvent {
  final String email;
  final String pwd;
  LoginButtonPressed({@required this.email, this.pwd}) : super([email, pwd]);

  @override
  String toString() => 'LoginButtonPressed { username: $email} , { pwd : $pwd}';
}
