import 'dart:async';

import 'package:easy_localization/easy_localization.dart';

import '../../../../core/utils/functions.dart';
import '../../../../core/base_viewmodel/baseviewmodel.dart';
import '../../domain/data_classes/freezed_data_classes.dart';
import '../../../../core/resourcses/strings_manager.dart';
import '../../domain/usecase/register_usecase.dart';

class RegisterViewModel extends BaseViewModel
    with RegisterViewModelInputs, RegisterViewModelOutputs {
  final _firstNameStreamController = StreamController<String>.broadcast();
  final _lastNameStreamController = StreamController<String>.broadcast();
  final _emailStreamController = StreamController<String>.broadcast();
  final _passwordStreamController = StreamController<String>.broadcast();
  final _confirmPasswordStreamController = StreamController<String>.broadcast();

  final _areAllInputsValidStreamController = StreamController<void>.broadcast();
  final StreamController isUserRegsiteredSuccessfullyStreamController =
      StreamController<bool>();

  var registerObject = RegisterObject("", "", "", "", "");

  final RegisterUsecase _registerUsecase;
  RegisterViewModel(this._registerUsecase);

  @override
  void start() {}

  @override
  void dispose() {
    _firstNameStreamController.close();
    _lastNameStreamController.close();
    _emailStreamController.close();
    _passwordStreamController.close();
    _confirmPasswordStreamController.close();
    _areAllInputsValidStreamController.close();
    isUserRegsiteredSuccessfullyStreamController.close();
  }

  @override
  Sink get inputFirstName => _firstNameStreamController.sink;

  @override
  Sink get inputLastName => _lastNameStreamController.sink;

  @override
  Sink get inputEmail => _emailStreamController.sink;

  @override
  Sink get inputPassword => _passwordStreamController.sink;

  @override
  Sink get inputConfirmPassword => _confirmPasswordStreamController.sink;

  @override
  Sink get inputAreAllInputsValid => _areAllInputsValidStreamController.sink;

  @override
  setFirstName(String firstName) {
    inputFirstName.add(firstName);
    if (isNameValid(firstName)) {
      registerObject = registerObject.copyWith(firstName: firstName);
    } else {
      registerObject = registerObject.copyWith(firstName: "");
    }
    inputAreAllInputsValid.add(null);
  }

  @override
  setLastName(String lastName) {
    inputLastName.add(lastName);
    if (isNameValid(lastName)) {
      registerObject = registerObject.copyWith(lastName: lastName);
    } else {
      registerObject = registerObject.copyWith(lastName: "");
    }
    inputAreAllInputsValid.add(null);
  }

  @override
  setEmail(String email) {
    inputEmail.add(email);
    if (isEmailValidChecker(email)) {
      registerObject = registerObject.copyWith(email: email);
    } else {
      registerObject = registerObject.copyWith(email: "");
    }
    inputAreAllInputsValid.add(null);
  }

  @override
  setPassword(String password) {
    inputPassword.add(password);
    if (isPasswordValid(password)) {
      registerObject = registerObject.copyWith(password: password);
    } else {
      registerObject = registerObject.copyWith(password: "");
    }
    inputAreAllInputsValid.add(null);
  }

  @override
  void confirmPassword(String password, String confirmedPassword) {
    inputConfirmPassword.add(confirmedPassword);
    if (_isPasswordMatched(password, confirmedPassword)) {
      registerObject = registerObject.copyWith(
        confirmPassword: confirmedPassword,
      );
    } else {
      registerObject = registerObject.copyWith(confirmPassword: "");
    }
    inputAreAllInputsValid.add(null);
  }

  @override
  void register() async {
    final response = await _registerUsecase.execute(
      RegisterUsecaseInput(
        registerObject.firstName,
        registerObject.lastName,
        registerObject.email,
        registerObject.password,
      ),
    );
    response.fold((failure) {}, (success) {
      isUserRegsiteredSuccessfullyStreamController.add(true);
    });
  }

  // --outputs
  @override
  Stream<bool> get outputIsFirstNameValid => _firstNameStreamController.stream
      .map((firstName) => isNameValid(firstName));

  @override
  Stream<String?> get outputErrorFirstName => outputIsFirstNameValid.map(
    (isFirstName) => isFirstName ? null : AppStrings.firstNameError.tr(),
  );

  @override
  Stream<bool> get outputIsLastNameValid =>
      _lastNameStreamController.stream.map((lastName) => isNameValid(lastName));

  @override
  Stream<String?> get outputErrorLastName => outputIsLastNameValid.map(
    (isLastName) => isLastName ? null : AppStrings.lastNameError.tr(),
  );

  @override
  Stream<bool> get outputIsEmailValid =>
      _emailStreamController.stream.map((email) => isEmailValidChecker(email));

  @override
  Stream<String?> get outputErrorEmail => outputIsEmailValid.map(
    (isEmail) => isEmail ? null : AppStrings.emailError.tr(),
  );

  @override
  Stream<bool> get outputIsPasswordValid => _passwordStreamController.stream
      .map((password) => isPasswordValid(password));

  @override
  Stream<String?> get outputErrorPassword => outputIsPasswordValid.map(
    (isPassword) => isPassword ? null : AppStrings.passwordError.tr(),
  );

  @override
  Stream<bool> get outputIsConfirmPasswordValid =>
      _confirmPasswordStreamController.stream.map(
        (confirmedPassword) => _isPasswordMatched(
          registerObject.password,
          registerObject.confirmPassword,
        ),
      );

  @override
  Stream<String?> get outputErrorConfirmPassword =>
      outputIsConfirmPasswordValid.map((passwordMatch) {
        return passwordMatch ? null : AppStrings.confirmPasswordError.tr();
      });

  @override
  Stream<bool> get outputAreAllInputsValid => _areAllInputsValidStreamController
      .stream
      .map((_) => _areAllInputsValid());

  bool _areAllInputsValid() {
    return registerObject.firstName.isNotEmpty &&
        registerObject.lastName.isNotEmpty &&
        registerObject.email.isNotEmpty &&
        registerObject.password.isNotEmpty &&
        registerObject.confirmPassword.isNotEmpty;
  }

  bool _isPasswordMatched(String password, String confirmedPassword) {
    return password == confirmedPassword;
  }
}

abstract mixin class RegisterViewModelInputs {
  void setFirstName(String firstName);
  void setLastName(String lastName);
  void setEmail(String email);
  void setPassword(String password);
  void confirmPassword(String password, String confirmedPassword);
  void register();

  Sink get inputFirstName;
  Sink get inputLastName;
  Sink get inputEmail;
  Sink get inputPassword;
  Sink get inputConfirmPassword;

  Sink get inputAreAllInputsValid;
}

abstract mixin class RegisterViewModelOutputs {
  Stream<bool> get outputIsFirstNameValid;
  Stream<String?> get outputErrorFirstName;

  Stream<bool> get outputIsLastNameValid;
  Stream<String?> get outputErrorLastName;

  Stream<bool> get outputIsEmailValid;
  Stream<String?> get outputErrorEmail;

  Stream<bool> get outputIsPasswordValid;
  Stream<String?> get outputErrorPassword;

  Stream<bool> get outputIsConfirmPasswordValid;
  Stream<String?> get outputErrorConfirmPassword;

  Stream<bool> get outputAreAllInputsValid;
}
