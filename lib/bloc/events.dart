import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

abstract class LoginEvent extends Equatable {
  LoginEvent([List props = const []]) : super(props);
}

class LoginButtonPressed extends LoginEvent {
  final String email;
  LoginButtonPressed({@required this.email,}) : super([email]);

  @override
  String toString() => 'LoginButtonPressed { username: $email}';
}
