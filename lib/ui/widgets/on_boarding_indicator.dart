import 'package:connect_store/utils/app_colors.dart';
import 'package:connect_store/utils/size_config.dart';
import 'package:flutter/material.dart';

class OnBoardingIndicator extends StatelessWidget {
  final double marginEnd;
  final bool selected;

  OnBoardingIndicator({
    this.marginEnd = 0,
    this.selected = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsetsDirectional.only(
        end: SizeConfig().scaleWidth(marginEnd),
      ),
      width: SizeConfig().scaleWidth(10),
      height: SizeConfig().scaleHeight(10),
      color: selected
          ? AppColors.APP_GREEN_PRIMARY_COLOR
          : AppColors.APP_GREY_WHITE_2_COLOR,
    );
  }
}
