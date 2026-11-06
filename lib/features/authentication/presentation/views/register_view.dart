import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../core/di/di.dart';
import '../../../../core/utils/app_prefs.dart';
import '../../../../core/widgets/custom_text_form_field.dart';
import '../../../../core/resourcses/colors_manager.dart';
import '../../../../core/resourcses/routes_manager.dart';
import '../../../../core/resourcses/strings_manager.dart';
import '../../../../core/resourcses/values_manager.dart';
import '../viewmodels/register_viewmodel.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  final RegisterViewModel _viewModel = instance<RegisterViewModel>();

  late final TextEditingController _firstNameController;
  late final TextEditingController _lastNameController;
  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;
  late final TextEditingController _confirmPasswordController;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final AppPreferences _appPreferences = instance<AppPreferences>();

  void _bind() {
    _viewModel.start();
    _firstNameController.addListener(
      () => _viewModel.setFirstName(_firstNameController.text),
    );
    _lastNameController.addListener(
      () => _viewModel.setLastName(_lastNameController.text),
    );
    _emailController.addListener(
      () => _viewModel.setEmail(_emailController.text),
    );
    _passwordController.addListener(
      () => _viewModel.setPassword(_passwordController.text),
    );
    _confirmPasswordController.addListener(
      () => _viewModel.confirmPassword(
        _passwordController.text,
        _confirmPasswordController.text,
      ),
    );
    _viewModel.isUserRegsiteredSuccessfullyStreamController.stream.listen((
      isRegistered,
    ) {
      if (isRegistered) {
        _appPreferences.setUserRegistered();
        Navigator.of(
          context,
        ).pushNamedAndRemoveUntil(Routes.loginScreen, (route) => false);
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _firstNameController = TextEditingController();
    _lastNameController = TextEditingController();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _confirmPasswordController = TextEditingController();
    _bind();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.primary,
      appBar: AppBar(
        elevation: AppSize.s0,
        iconTheme: IconThemeData(color: ColorManager.white),
      ),
      body: _getContentWidget(),
    );
  }

  Widget _getContentWidget() {
    return Container(
      padding: const EdgeInsets.only(top: AppPadding.p40),
      child: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Text(
                AppStrings.welcome.tr(),
                style: Theme.of(context).textTheme.headlineLarge,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: AppSize.s50),
              Text(
                AppStrings.signUpTitle.tr(),
                style: Theme.of(context).textTheme.labelSmall,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: AppSize.s42),
              StreamBuilder<String?>(
                stream: _viewModel.outputErrorFirstName,
                builder: (context, snapshot) => CustomTextFormField(
                  controller: _firstNameController,
                  keyboardType: TextInputType.text,
                  labelText: AppStrings.firstNameHint.tr(),
                  errorText: snapshot.data,
                ),
              ),
              const SizedBox(height: AppSize.s20),
              StreamBuilder<String?>(
                stream: _viewModel.outputErrorLastName,
                builder: (context, snapshot) => CustomTextFormField(
                  controller: _lastNameController,
                  keyboardType: TextInputType.name,
                  labelText: AppStrings.lastNameHint.tr(),
                  errorText: snapshot.data,
                ),
              ),
              const SizedBox(height: AppSize.s20),
              StreamBuilder<String?>(
                stream: _viewModel.outputErrorEmail,
                builder: (context, snapshot) => CustomTextFormField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  labelText: AppStrings.registerEmailHint.tr(),
                  errorText: snapshot.data,
                ),
              ),
              const SizedBox(height: AppSize.s20),
              StreamBuilder<String?>(
                stream: _viewModel.outputErrorPassword,
                builder: (context, snapshot) => CustomTextFormField(
                  controller: _passwordController,
                  keyboardType: TextInputType.visiblePassword,
                  labelText: AppStrings.passwordHint.tr(),
                  errorText: snapshot.data,
                ),
              ),
              const SizedBox(height: AppSize.s20),
              StreamBuilder<String?>(
                stream: _viewModel.outputErrorConfirmPassword,
                builder: (context, snapshot) => CustomTextFormField(
                  controller: _confirmPasswordController,
                  keyboardType: TextInputType.visiblePassword,
                  labelText: AppStrings.rePasswordHint.tr(),
                  errorText: snapshot.data,
                ),
              ),
              const SizedBox(height: AppSize.s35),
              Padding(
                padding: const EdgeInsets.only(
                  left: AppPadding.p40,
                  right: AppPadding.p40,
                ),
                child: StreamBuilder<bool>(
                  stream: _viewModel.outputAreAllInputsValid,
                  builder: (context, snapshot) {
                    return SizedBox(
                      width: double.infinity,
                      height: AppSize.s42,
                      child: ElevatedButton(
                        onPressed: (snapshot.data ?? false)
                            ? () {
                                _viewModel.register();
                              }
                            : null,
                        child: Text(
                          AppStrings.create.tr(),
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: AppSize.s20),
              GestureDetector(
                onTap: () => Navigator.of(context).pop(),
                child: Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: AppStrings.haveAnAccount.tr(),
                        style: Theme.of(context).textTheme.titleSmall,
                      ),
                      TextSpan(
                        text: " Sign in",
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _viewModel.dispose();
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }
}
