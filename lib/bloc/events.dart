import 'package:equatable/equatable.dart';

abstract class Events extends Equatable{
  Events([List props = const []]) : super();
}

class Login extends Events{
  @override
  String toString() => 'Logging in.';
}
