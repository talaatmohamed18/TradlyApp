import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../core/di/di.dart';
import '../../../../core/utils/app_prefs.dart';
import '../../../../core/utils/responsive.dart';
import '../../../../core/widgets/custom_text_form_field.dart';
import '../../../../core/resourcses/colors_manager.dart';
import '../../../../core/resourcses/routes_manager.dart';
import '../../../../core/resourcses/strings_manager.dart';
import '../../../../core/resourcses/values_manager.dart';
import '../viewmodels/login_viewmodel.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final LoginViewModel _viewModel = instance<LoginViewModel>();
  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final AppPreferences _appPreferences = instance<AppPreferences>();

  void _bind() {
    _viewModel.start();
    _emailController.addListener(
      () => _viewModel.setEmail(_emailController.text),
    );
    _passwordController.addListener(
      () => _viewModel.setPassoword(_passwordController.text),
    );

    _viewModel.isUserLoggedInSuccessfullyStreamController.stream.listen((
      isLoggedIn,
    ) {
      if (isLoggedIn) {
        _appPreferences.setUserLoggedIn();
        Navigator.of(
          context,
        ).pushNamedAndRemoveUntil(Routes.homeScreen, (route) => false);
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _bind();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.primary,
      body: _getContentWidget(),
    );
  }

  Widget _getContentWidget() {
    return Container(
      padding: EdgeInsets.only(
        top: (Responsive.height(context) * 0.12)
            .clamp(24.0, AppPadding.p140)
            .toDouble(),
      ),
      child: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                AppStrings.welcome.tr(),
                style: Theme.of(context).textTheme.headlineLarge,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: AppSize.s50),
              Text(
                AppStrings.loginTitle.tr(),
                style: Theme.of(context).textTheme.labelSmall,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: AppSize.s42),
              StreamBuilder<bool>(
                stream: _viewModel.outputIsEmailValid,
                builder: (context, snapshot) => CustomTextFormField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  labelText: AppStrings.emailHint.tr(),
                  errorText: (snapshot.data ?? true)
                      ? null
                      : AppStrings.emailError.tr(),
                ),
              ),
              const SizedBox(height: AppSize.s18),
              StreamBuilder<bool>(
                stream: _viewModel.outputIsPasswordValid,
                builder: (context, snapshot) => CustomTextFormField(
                  controller: _passwordController,
                  keyboardType: TextInputType.visiblePassword,
                  labelText: AppStrings.passwordHint.tr(),
                  errorText: (snapshot.data ?? true)
                      ? null
                      : AppStrings.passwordError.tr(),
                ),
              ),
              const SizedBox(height: AppSize.s50),
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
                                _viewModel.login();
                              }
                            : null,
                        child: Text(
                          AppStrings.login.tr(),
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: AppSize.s20),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pushNamed(Routes.forgotPasswordScreen);
                },
                child: Text(
                  AppStrings.forgotTitle.tr(),
                  style: Theme.of(context).textTheme.titleSmall,
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: AppSize.s35),
              GestureDetector(
                onTap: () =>
                    Navigator.of(context).pushNamed(Routes.registerScreen),
                child: Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: AppStrings.dontHaveAcc.tr(),
                        style: Theme.of(context).textTheme.titleSmall,
                      ),
                      TextSpan(
                        text: " Sign Up",
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
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
