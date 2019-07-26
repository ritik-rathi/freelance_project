import 'dart:async';

import 'package:freelance/bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final SharedPrefs sharedPrefs;
  final AuthenticationBloc authenticationBloc;

  LoginBloc({
    @required this.sharedPrefs,
    @required this.authenticationBloc,
  })  : assert(sharedPrefs != null),
        assert(authenticationBloc != null);

  @override
  LoginState get initialState => LoginInitial();

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    // if (event is SocIdEntered) {
    //   yield LoginLoading();

    //   try {
    //     final id = await sharedPrefs.authenticate(
    //         email: event.emailId);
    //   } catch (e) {}
    // }
    if (event is LoginButtonPressed) {
      await sharedPrefs.writeToken(event.email);
      await sharedPrefs.writePassword(event.pwd);
      print("Wrote ${event.email} & ${event.pwd}");
      yield LoginLoading();
      try {
        final token = await sharedPrefs.authenticate(email: event.email);
        authenticationBloc.dispatch(LoggedIn(token: token));
        yield LoginInitial();
      } catch (error) {
        yield LoginFailure(error: error.toString());
      }
    }
  }
}
