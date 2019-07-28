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
    if (event is LoginButtonPressed) {
      await sharedPrefs.writeToken(event.email);
      print("Wrote ${event.email}");
      yield LoginLoading();
      try {
        final token =
            await sharedPrefs.authenticate(email: event.email, pwd: event.pwd);
        token
            ? authenticationBloc.dispatch(LoggedIn(token: token.toString()))
            : authenticationBloc.dispatch(LoggedOut());
        yield LoginInitial();
      } catch (error) {
        await sharedPrefs.deleteToken();
        yield LoginFailure(error: error.toString());
      }
    }
  }
}
