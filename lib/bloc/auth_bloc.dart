import 'dart:async';

import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';
import 'bloc.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final SharedPrefs prefs;

  AuthenticationBloc({@required this.prefs}) : assert(prefs != null);

  @override
  AuthenticationState get initialState => AuthenticationUninitialized();

  @override
  Stream<AuthenticationState> mapEventToState(
    AuthenticationEvent event,
  ) async* {
    if (event is AppStarted) {
      final bool hasToken = await prefs.hasToken() != null;
      if (hasToken) {
        var token = await prefs.hasToken();
        // var id = await prefs.readSocId();
        yield AuthenticationAuthenticated(userEmail: token);
        return;
      } else {
        yield AuthenticationUnauthenticated();
      }
    }

    if (event is LoggedIn) {
      yield AuthenticationLoading();
      print("Logged in state and token = ${event.token}");
      await prefs.writeToken(event.token);
      yield AuthenticationAuthenticated(userEmail: event.token);
    }

    if (event is LoggedOut) {
      yield AuthenticationLoading();
      print("Logging out/...........");
      await prefs.deleteToken();
      print("Deleted token.........");
      yield AuthenticationUnauthenticated();
    }
  }
}
