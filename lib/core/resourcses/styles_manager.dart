import 'package:tradly/core/resourcses/fonts_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

TextStyle _getTextStyle(double fontSize, FontWeight fontWeight, Color color) {
  return TextStyle(
    fontFamily: FontsConstants.fontFamily,
    fontSize: fontSize,
    fontWeight: fontWeight,
    color: color,
  );
}

// Light
TextStyle getLightStyle({
  double fontSize = FontSize.s12,
  required Color color,
}) {
  return _getTextStyle(fontSize, FontsWeight.light, color);
}

// Regular
TextStyle getRegularStyle({
  double fontsize = FontSize.s12,
  required Color color,
}) {
  return _getTextStyle(fontsize, FontsWeight.regular, color);
}

// Medium
TextStyle getMeduimStyle({
  double fontSize = FontSize.s12,
  required Color color,
}) {
  return _getTextStyle(fontSize, FontsWeight.medium, color);
}

// Semi-Bold
TextStyle getSemiBoldStyle({
  double fontSize = FontSize.s12,
  required Color color,
}) {
  return _getTextStyle(fontSize, FontsWeight.semiBold, color);
}

// Bold
TextStyle getBoldStyle({double fontSize = FontSize.s12, required Color color}) {
  return _getTextStyle(fontSize, FontsWeight.bold, color);
}
