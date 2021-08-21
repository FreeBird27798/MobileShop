import 'package:connect_store/utils/app_colors.dart';
import 'package:connect_store/utils/size_config.dart';
import 'package:flutter/material.dart';
import 'app_text.dart';

class AppElevatedButton extends StatelessWidget {
  final String? text;
  final FontWeight fontWeight;
  final Color textColor;
  final Color iconColor;
  final IconData? icon;
  final Color backgroundColor;
  final Color borderColor;
  final Function()? onPressed;
  final double fontSize;
  final double borderRadius;
  final double width;
  final double height;
  final bool hasBorder;
  final bool enabled;
  final bool hasIcon;

  AppElevatedButton({
    this.text = '',
    this.icon = Icons.arrow_forward_ios,
    this.fontWeight = FontWeight.bold,
    this.textColor = Colors.white,
    this.iconColor = Colors.white,
    this.backgroundColor = AppColors.APP_GREEN_PRIMARY_COLOR,
    this.borderColor = AppColors.APP_BLACK_PRIMARY_COLOR,
    this.onPressed,
    this.hasBorder = false,
    this.enabled = false,
    this.fontSize = 17,
    this.borderRadius = 6,
    this.width = double.infinity,
    this.height = 44,
    this.hasIcon = false,
  });

  @override
  Widget build(BuildContext context) {
    final ButtonStyle style = ElevatedButton.styleFrom(
      padding: EdgeInsetsDirectional.zero,
      alignment: Alignment.center,
      primary: enabled ? backgroundColor : AppColors.APP_GREY_WHITE_2_COLOR,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(borderRadius),
        side: hasBorder
            ? BorderSide(
                color: borderColor,
                width: 1,
              )
            : BorderSide.none,
      ),
    );
    return SizedBox(
      height: SizeConfig().scaleHeight(height),
      width: SizeConfig().scaleWidth(width),
      child: ElevatedButton(
        onPressed: enabled ? onPressed : null,
        child: hasIcon
            ? Icon(
                icon,
                color: iconColor,
              )
            : AppText(
                text: text!,
                fontWeight: fontWeight,
                textColor: textColor,
                fontSize: fontSize,
              ),
        style: style,
      ),
    );
  }
}
