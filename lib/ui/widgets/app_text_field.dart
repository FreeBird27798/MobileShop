import 'package:connect_store/utils/app_colors.dart';
import 'package:connect_store/utils/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class AppTextField extends StatelessWidget {
  final String hintText;
  final TextEditingController textEditingController;
  final TextInputType keyboardType;
  final Color hintColor;
  final Color iconColor;
  final double fontSize;
  final double height;
  final double width;
  final double iconSize;
  final FontWeight fontWeight;
  final bool obscureText;
  final bool readOnly;

  // final bool isHidden;
  final String? image;
  final IconData? icon;
  final bool enablePadding;
  final int maxLines;
  final int? maxLength;
  final void Function(String value)? onChanged;

  AppTextField(
      {required this.hintText,
      required this.textEditingController,
      this.keyboardType = TextInputType.text,
      this.hintColor = AppColors.APP_GREY_PRIMARY_COLOR,
      this.iconColor = AppColors.APP_GREEN_PRIMARY_COLOR,
      this.fontSize = 16,
      this.height = 60,
      this.width = double.infinity,
      this.iconSize = 24,
      this.maxLines = 1,
      this.maxLength,
      this.fontWeight = FontWeight.w400,
      this.obscureText = false,
      this.readOnly = false,
      this.image,
      this.icon,
      // this.isHidden = false,
      this.enablePadding = false,
      this.onChanged});

  @override
  Widget build(BuildContext context) {
    final style = TextStyle(
      color: hintColor,
      fontSize: SizeConfig().scaleTextFont(fontSize),
      fontWeight: fontWeight,
      fontFamily: 'Roboto',
    );
    return SizedBox(
      height: SizeConfig().scaleHeight(height),
      width: SizeConfig().scaleWidth(width),
      child: TextField(
        readOnly: readOnly,
        style: style,
        maxLines: maxLines,
        maxLength: maxLength,
        keyboardType: keyboardType,
        controller: textEditingController,
        obscureText: obscureText,
        decoration: InputDecoration(
          counterText: '',
          contentPadding: enablePadding
              ? EdgeInsetsDirectional.only(
                  start: SizeConfig().scaleWidth(15),
                  end: SizeConfig().scaleWidth(15),
                  top: SizeConfig().scaleHeight(20),
                  bottom: SizeConfig().scaleHeight(20),
                )
              : null,
          enabledBorder: InputBorder.none,
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            borderSide: BorderSide(color: AppColors.APP_GREEN_PRIMARY_COLOR),
          ),
          hintText: hintText,
          hintStyle: style,
          prefixIconConstraints: BoxConstraints(),
          prefixIcon: image != null
              ? Padding(
                  padding: EdgeInsets.all(20.0),
                  child: SvgPicture.asset(
                    'images/${image}.svg',
                  ),
                )
              : icon != null
                  ? Padding(
                      padding: EdgeInsets.all(15.0),
                      child: Icon(
                        icon,
                        color: iconColor,
                        size: SizeConfig().scaleWidth(iconSize),
                      ),
                    )
                  : null,
        ),
        onChanged: onChanged,
      ),
    );
  }
}
