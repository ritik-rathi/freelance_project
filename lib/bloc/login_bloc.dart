import 'package:flutter/widgets.dart';
import 'package:rxdart/rxdart.dart';
import 'package:bloc/bloc.dart';
import 'bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginBloc extends Bloc<Events, States> {
  // final bool guardLogin;

  // LoginBloc({@required this.guardLogin}) : super();

  @override
  States get initialState => LoginStarts();

  @override
  Stream<States> transform(
    Stream<Events> events,
    Stream<States> Function(Events event) next,
  ) {
    return super.transform(
      (events as Observable<Events>).debounceTime(
        Duration(milliseconds: 500),
      ),
      next,
    );
  }

  @override
  Stream<States> mapEventToState(Events event) async* {
    if (event is Login) {
      try {
        if (currentState is LoginStarts) {
          print('Inside login starts function');
          try {
            print('Getting details....');
            var exists = await _checkIfUserExists();
            print('Got something');
            print(exists.toString());
            yield exists ? LoginComplete() : LoginNotFound();
          } catch (e) {
            print(e.toString());
            print("Minor error");
          }
        }
        if (currentState is LoginComplete) {
          print('Completed login');
        }
        if (currentState is LoginNotFound) {
          print('Please login to save something');
        }
      } catch (e) {
        print("Total Error");
        print(e.toString());
        yield LoginError();
      }
    }
  }

  Future<bool> _checkIfUserExists() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var email = prefs.getString("email");
    var guard = prefs.getString("guard_pass");
    print(guard);
    print(email);
    return (email != null) || guard != null;
  }
}
