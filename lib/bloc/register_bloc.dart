import 'package:bloc_pattern/bloc/validators.dart';
import 'package:rxdart/rxdart.dart';
import 'package:rxdart/subjects.dart';

class RegisterBloc with Validators {
  final _registerName = BehaviorSubject<String>();
  final _registerEmail = BehaviorSubject<String>();
  final _registerPassword = BehaviorSubject<String>();
  final _registerConfirmPassword = BehaviorSubject<String>();

  //Getter

  Stream<String> get registerName =>
      _registerName.stream.transform(nameValidator);
  Stream<String> get registerEmail =>
      _registerEmail.stream.transform(emailValidator);
  Stream<String> get registerPassword =>
      _registerPassword.stream.transform(passwordValidator);
  Stream<String> get registerConfirmPassword =>
      _registerConfirmPassword.stream.transform(confirmPasswordValidator);

  Stream<bool> get isValid => Rx.combineLatest4(registerName, registerPassword,
      registerEmail, registerConfirmPassword, (a, b, c, d) => true);

  //Setter

  Function(String) get changeRegisterName => _registerName.sink.add;
  Function(String) get changeRegisterEmail => _registerEmail.sink.add;
  Function(String) get changeRegisterPassword => _registerPassword.sink.add;
  Function(String) get changeConfirmPassword =>
      _registerConfirmPassword.sink.add;

//Submit
  void submit() {
    print(_registerPassword.value);
    print(_registerConfirmPassword.value);
    if (_registerPassword.value != _registerConfirmPassword.value) {
      _registerConfirmPassword.sink.addError("Password doesn't match");
    } else {
      print(_registerName.value);
      print(_registerEmail.value);
    }
  }

  void dispose() {
    _registerName.close();
    _registerEmail.close();
    _registerPassword.close();
    _registerConfirmPassword.close();
  }
}
