import 'dart:async';

import 'package:dest_bucket/components/blocs/common/bloc_provider.dart';
import 'package:rxdart/rxdart.dart';

class SignUpFormBloc extends Object
    with EmailValidator, PasswordValidator
    implements BlocBase {
  final BehaviorSubject<String> _emailController = BehaviorSubject<String>();
  final BehaviorSubject<String> _passwordController = BehaviorSubject<String>();
  final BehaviorSubject<String> _passwordConfirmController =
      BehaviorSubject<String>();

  //
  //  Inputs
  //
  Function(String) get onEmailChanged => _emailController.sink.add;

  Function(String) get onPasswordChanged => _passwordController.sink.add;

  Function(String) get onRetypePasswordChanged =>
      _passwordConfirmController.sink.add;

  //
  // Validators
  //
  Stream<String> get email => _emailController.stream.transform(validateEmail);

  Stream<String> get password =>
      _passwordController.stream.transform(validatePassword);

  Stream<String> get confirmPassword => _passwordConfirmController.stream
          .transform(validatePassword)
          .doOnData((String c) {
        // If the password is accepted (after validation of the rules)
        // we need to ensure both password and retyped password match
        if (0 != _passwordController.value.compareTo(c)) {
          // If they do not match, add an error
          _passwordConfirmController.addError("No Match");
        }
      });

  //
  // Registration button
  Stream<bool> get registerValid => Observable.combineLatest3(
      email, password, confirmPassword, (e, p, c) => true);

  @override
  void dispose() {
    _emailController?.close();
    _passwordController?.close();
    _passwordConfirmController?.close();
  }
}

const String _kEmailRule = r"^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$";

class EmailValidator {
  final StreamTransformer<String, String> validateEmail =
      StreamTransformer<String, String>.fromHandlers(handleData: (email, sink) {
    final RegExp emailExp = new RegExp(_kEmailRule);

    if (!emailExp.hasMatch(email) || email.isEmpty) {
      sink.addError('Enter a valid email');
    } else {
      sink.add(email);
    }
  });
}

//const String _kMin8CharsOneLetterOneNumber = r"^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$";
//const String _kMin8CharsOneLetterOneNumberOnSpecialCharacter = r"^(?=.*[A-Za-z])(?=.*\d)(?=.*[@$!%*#?&])[A-Za-z\d@$!%*#?&]{8,}$";
//const String _kMin8CharsOneUpperLetterOneLowerLetterOnNumber = r"^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)[a-zA-Z\d]{8,}$";
const String _kMin8CharsOneUpperOneLowerOneNumberOneSpecial = r"^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$";
//const String _kMin8Max10OneUpperOneLowerOneNumberOneSpecial = r"^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,10}$";

class PasswordValidator {
  final StreamTransformer<String, String> validatePassword =
      StreamTransformer<String, String>.fromHandlers(
          handleData: (password, sink) {
    final RegExp passwordExp =
        new RegExp(_kMin8CharsOneUpperOneLowerOneNumberOneSpecial);

    if (!passwordExp.hasMatch(password)) {
      sink.addError('Enter a valid password');
    } else {
      sink.add(password);
    }
  });
}
