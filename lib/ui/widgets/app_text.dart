import 'package:connect_store/utils/app_colors.dart';
import 'package:connect_store/utils/size_config.dart';
import 'package:flutter/material.dart';

class AppText extends StatelessWidget {
  final String text;
  final Color textColor;
  final double fontSize;
  final FontWeight fontWeight;
  final String fontFamily;
  final FontStyle fontStyle;
  final TextAlign textAlign;
  final TextDecoration textDecoration;
  final Color decorationColor;
  final int maxLines;

  AppText({
    required this.text,
    this.textColor = AppColors.APP_BLACK_PRIMARY_COLOR,
    this.fontSize = 16,
    this.fontWeight = FontWeight.w400,
    this.fontFamily = 'Open Sans',
    this.fontStyle = FontStyle.normal,
    this.textAlign = TextAlign.center,
    this.textDecoration =TextDecoration.none,
    this.decorationColor = AppColors.DELETE_COLOR,
    this.maxLines = 1,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign,
      maxLines: maxLines,
      style: TextStyle(
        color: textColor,
        fontSize: SizeConfig().scaleTextFont(fontSize),
        fontWeight: fontWeight,
        fontFamily: fontFamily,
        fontStyle: fontStyle,
        decoration: textDecoration,
        decorationColor: decorationColor,
      ),
    );
  }
}
