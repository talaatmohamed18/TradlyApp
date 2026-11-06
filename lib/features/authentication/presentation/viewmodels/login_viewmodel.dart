import 'dart:async';

import '../../../../core/utils/functions.dart';
import '../../../../core/base_viewmodel/baseviewmodel.dart';
import '../../domain/data_classes/freezed_data_classes.dart';
import '../../domain/usecase/login_usecase.dart';

class LoginViewModel extends BaseViewModel
    with LoginViewModelInputs, LoginViewModelOutputs {
  final _emailStreamController = StreamController<String>.broadcast();
  final _passwordStreamController = StreamController<String>.broadcast();

  final _areAllInputsValidStreamController = StreamController<void>.broadcast();

  final isUserLoggedInSuccessfullyStreamController = StreamController<bool>();

  var loginObject = LoginObject("", "");

  final LoginUsecase _loginUsecase;
  LoginViewModel(this._loginUsecase);

  @override
  void dispose() {
    _emailStreamController.close();
    _passwordStreamController.close();
    _areAllInputsValidStreamController.close();
    isUserLoggedInSuccessfullyStreamController.close();
  }

  @override
  void start() {}

  @override
  Sink get emailInput => _emailStreamController.sink;

  @override
  Sink get passwordInput => _passwordStreamController.sink;

  @override
  Sink get inputAreAllInputsValid => _areAllInputsValidStreamController.sink;

  @override
  setEmail(String email) {
    emailInput.add(email);
    if (isEmailValidChecker(email)) {
      loginObject = loginObject.copyWith(email: email);
    } else {
      loginObject = loginObject.copyWith(email: "");
    }
    inputAreAllInputsValid.add(null);
  }

  @override
  setPassoword(String password) {
    passwordInput.add(password);
    if (isPasswordValid(password)) {
      loginObject = loginObject.copyWith(password: password);
    } else {
      loginObject = loginObject.copyWith(password: "");
    }
    inputAreAllInputsValid.add(null);
  }

  @override
  login() async {
    final response = await _loginUsecase.execute(
      LoginUsecaseInput(loginObject.email, loginObject.password),
    );
    response.fold((failure) {}, (success) {
      isUserLoggedInSuccessfullyStreamController.add(true);
    });
  }

  @override
  Stream<bool> get outputIsEmailValid =>
      _emailStreamController.stream.map((email) => isEmailValidChecker(email));

  @override
  Stream<bool> get outputIsPasswordValid => _passwordStreamController.stream
      .map((password) => isPasswordValid(password));

  @override
  Stream<bool> get outputAreAllInputsValid => _areAllInputsValidStreamController
      .stream
      .map((_) => _areAllInputsValid());

  bool _areAllInputsValid() {
    return isEmailValidChecker(loginObject.email) &&
        isPasswordValid(loginObject.password);
  }
}

abstract mixin class LoginViewModelInputs {
  void setEmail(String email);
  void setPassoword(String password);
  void login();

  Sink get emailInput;
  Sink get passwordInput;
  Sink get inputAreAllInputsValid;
}

abstract mixin class LoginViewModelOutputs {
  Stream<bool> get outputIsEmailValid;

  Stream<bool> get outputIsPasswordValid;

  Stream<bool> get outputAreAllInputsValid;
}
