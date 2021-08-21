import 'dart:ui';
import 'package:connect_store/utils/app_colors.dart';
import 'package:connect_store/utils/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class PhoneTextField extends StatelessWidget {
  final String hintText;
  final TextEditingController textEditingController;
  final TextInputType keyboardType;
  final Color hintColor;
  final FontWeight fontWeight;
  final String? prefixIcon;
  final bool enablePadding;
  final bool readOnly;
  final int maxLines;
  final int maxLength;
  final double fontSize;
  final void Function(String value)? onChanged;

  PhoneTextField(
      {this.hintText = '599 123 456',
      required this.textEditingController,
      this.keyboardType = TextInputType.phone,
      this.hintColor = AppColors.APP_GREY_PRIMARY_COLOR,
      this.fontSize = 16,
      this.maxLines = 1,
      this.maxLength = 9,
      this.fontWeight = FontWeight.w400,
      this.prefixIcon,
      this.enablePadding = false,
      this.readOnly = false,
      this.onChanged});

  @override
  Widget build(BuildContext context) {
    final style = TextStyle(
      color: hintColor,
      fontSize: SizeConfig().scaleTextFont(fontSize),
      fontWeight: fontWeight,
      fontFamily: 'Roboto',
    );
    return TextField(
      readOnly: readOnly,
      style: style,
      maxLength: maxLength,
      maxLines: maxLines,
      keyboardType: keyboardType,
      controller: textEditingController,
      decoration: InputDecoration(
        counterText: '',
        contentPadding: enablePadding
            ? EdgeInsetsDirectional.only(
                start: SizeConfig().scaleWidth(15),
                end: SizeConfig().scaleWidth(15),
                // top: SizeConfig().scaleHeight(20),
                // bottom: SizeConfig().scaleHeight(20),
              )
            : null,
        enabledBorder: InputBorder.none,
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          borderSide: BorderSide(color: AppColors.APP_GREEN_PRIMARY_COLOR),
        ),
        hintText: hintText,
        hintStyle: style,
        prefixIcon: Padding(
            padding: EdgeInsets.all(10),
            child: SvgPicture.asset(
              'images/prefix_icon.svg',
            )),
        // prefixStyle: TextStyle(
        //   color: AppColors.APP_GREEN_PRIMARY_COLOR,
        //   fontSize: SizeConfig().scaleTextFont(fontSize),
        //   fontWeight: fontWeight,
        //   fontFamily: 'Roboto',
        // ),
      ),
      onChanged: onChanged,
    );
  }
}
