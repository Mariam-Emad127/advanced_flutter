import 'package:advanced_flutter/presentation/resources/font_manger.dart';
import 'package:flutter/material.dart';

TextStyle _getTextStyle(double fontSize, FontWeight fontWeight,  Color color) {
  return TextStyle(
      fontSize: fontSize,
      fontFamily: FontConstant.fontFamily,
      fontWeight: fontWeight,
      color: color);
}

TextStyle getRegularStyle({double fontSize = FontSize.s12, required color}) {
  return _getTextStyle(fontSize, FontManger.regular, color);
}



TextStyle getLightStyle({double fontSize=FontSize.s12,required color}){

return _getTextStyle(fontSize, FontManger.light, color);

}

TextStyle getBoldStyle(
    {double fontSize = FontSize.s12, required Color color}) {
  return _getTextStyle(fontSize, FontManger.bold , color);
}

// semibold style

TextStyle getSemiBoldStyle(
    {double fontSize = FontSize.s12, required Color color}) {
  return _getTextStyle(fontSize, FontManger.semiBold, color);
}

TextStyle getMediumStyle(
    {double fontSize = FontSize.s12, required Color color}) {
  return _getTextStyle(fontSize, FontManger.semiBold, color);
}