import 'dart:async';

import '../../../../core/utils/functions.dart';
import '../../domain/usecase/reset_password_usecase.dart';
import '../../../../core/base_viewmodel/baseviewmodel.dart';

class ResetPasswordViewModel extends BaseViewModel
    with ForgotPasswordViewModelInputs, ForgotPasswordViewModelOutputs {
  final _emailStreamController = StreamController<String>.broadcast();
  final StreamController _isInputValidStreamController =
      StreamController<void>.broadcast();

  var email = "";

  final ResetPasswordUsecase _forgotPasswordUsecase;
  ResetPasswordViewModel(this._forgotPasswordUsecase);

  @override
  void dispose() {
    _emailStreamController.close();
    _isInputValidStreamController.close();
  }

  @override
  void start() {}

  @override
  Sink get inputEmail => _emailStreamController.sink;

  @override
  Sink get inputIsInputValid => _isInputValidStreamController.sink;

  @override
  void resetPassword() async {
    (await _forgotPasswordUsecase.execute(
      email,
    )).fold((failure) {}, (supportMessage) {});
  }

  @override
  Stream<bool> get outIsEmailValid =>
      _emailStreamController.stream.map((email) => isEmailValidChecker(email));

  @override
  Stream<bool> get outIsInputValid =>
      _isInputValidStreamController.stream.map((_) => _isUserEnteredData());

  @override
  void setEmail(String email) {
    inputEmail.add(email);
    this.email = email;
    inputIsInputValid.add(null);
  }

  bool _isUserEnteredData() {
    return isEmailValidChecker(email);
  }
}

abstract mixin class ForgotPasswordViewModelInputs {
  void setEmail(String email);
  void resetPassword();
  Sink get inputEmail;
  Sink get inputIsInputValid;
}

abstract mixin class ForgotPasswordViewModelOutputs {
  Stream<bool> get outIsEmailValid;
  Stream<bool> get outIsInputValid;
}
