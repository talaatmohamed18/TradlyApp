import 'package:flutter/material.dart';
import 'package:tradly/core/utils/responsive.dart';

class CustomTextFormField extends StatelessWidget {
  final TextEditingController? controller;
  final String? errorText;
  final TextInputType? keyboardType;
  final String? labelText;
  const CustomTextFormField({
    super.key,
    required this.controller,
    this.errorText,
    this.keyboardType,
    this.labelText,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: Responsive.horizontalPadding(context),
      ),
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        decoration: InputDecoration(labelText: labelText, errorText: errorText),
      ),
    );
  }
}
