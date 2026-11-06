import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../core/di/di.dart';
import '../../../../core/resourcses/colors_manager.dart';
import '../../../../core/resourcses/strings_manager.dart';
import '../../../../core/resourcses/values_manager.dart';
import '../viewmodels/resetpassword_view_model.dart';

class ResetpasswordView extends StatefulWidget {
  const ResetpasswordView({super.key});

  @override
  State<ResetpasswordView> createState() => _ResetpasswordViewState();
}

class _ResetpasswordViewState extends State<ResetpasswordView> {
  final ResetPasswordViewModel _viewModel = instance<ResetPasswordViewModel>();
  late final TextEditingController _emailController;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  void _bind() {
    _viewModel.start();
    _emailController.addListener(
      () => _viewModel.setEmail(_emailController.text),
    );
  }

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _bind();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppStrings.forgotPassword).tr(),
        elevation: 0.0,
        iconTheme: IconThemeData(color: ColorManager.primary),
      ),
      backgroundColor: ColorManager.primary,
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
              Padding(
                padding: const EdgeInsets.only(
                  left: AppPadding.p40,
                  right: AppPadding.p40,
                ),
                child: StreamBuilder<bool>(
                  stream: _viewModel.outIsEmailValid,
                  builder: (context, snapshot) {
                    return TextFormField(
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        labelText: AppStrings.emailHint.tr(),
                        errorText: (snapshot.data ?? true)
                            ? null
                            : AppStrings.emailError.tr(),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: AppSize.s18),
              Padding(
                padding: const EdgeInsets.only(
                  left: AppPadding.p40,
                  right: AppPadding.p40,
                ),
                child: StreamBuilder<bool>(
                  stream: _viewModel.outIsInputValid,
                  builder: (context, snapshot) {
                    return SizedBox(
                      width: double.infinity,
                      height: AppSize.s42,
                      child: ElevatedButton(
                        onPressed: (snapshot.data ?? false)
                            ? () {
                                _viewModel.resetPassword();
                              }
                            : null,
                        child: Text(
                          AppStrings.forgotPassword.tr(),
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                      ),
                    );
                  },
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
    super.dispose();
  }
}
