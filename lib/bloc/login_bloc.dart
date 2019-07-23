import 'package:rxdart/rxdart.dart';
import 'package:bloc/bloc.dart';
import 'bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginBloc extends Bloc<Events, States> {
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
            var user = await _checkIfUserExists();
            var guard = await _checkIfGuardExists();
            print('Got something');
            if (user != null) {
              yield LoginComplete(guard: false);
            } else if (guard != null) {
              yield LoginComplete(guard: true);
            } else {
              yield LoginNotFound();
            }
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

  Future<String> _checkIfGuardExists() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var guard = prefs.getString("guard_pass");
    print(guard);
    return guard;
  }

  Future<String> _checkIfUserExists() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var email = prefs.getString("email");
    print(email);
    return email;
  }
}
