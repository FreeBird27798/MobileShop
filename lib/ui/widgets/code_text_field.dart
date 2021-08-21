import 'package:connect_store/utils/app_colors.dart';
import 'package:connect_store/utils/size_config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CodeTextField extends StatelessWidget {
  final TextEditingController textController;
  final FocusNode focusNode;
  final void Function(String value) onChanged;
  final double marginEnd;

  CodeTextField({
    required this.textController,
    required this.focusNode,
    required this.onChanged,
    this.marginEnd = 0,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
        height: SizeConfig().scaleHeight(59),
        width: SizeConfig().scaleWidth(74),
        margin:
            EdgeInsetsDirectional.only(end: SizeConfig().scaleWidth(marginEnd)),
        child: TextField(
          controller: textController,
          focusNode: focusNode,
          textAlign: TextAlign.center,
          keyboardType: TextInputType.number,
          maxLength: 1,
          onChanged: onChanged,
          decoration: InputDecoration(
            counterText: '',
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(
                  width: 1,
                  color: AppColors.APP_GREY_PRIMARY_COLOR,
                )),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(
                  width: 1,
                  color: AppColors.APP_GREEN_PRIMARY_COLOR,
                )),
          ),
        ));
  }
}
