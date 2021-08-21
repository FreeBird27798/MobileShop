import 'package:connect_store/utils/app_colors.dart';
import 'package:connect_store/utils/size_config.dart';
import 'package:connect_store/ui/widgets/app_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class OnBoardingContent extends StatelessWidget {
  final String image;
  final String message;
  final String title;

  OnBoardingContent({
    required this.image,
    required this.message,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: Colors.white),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            // color: Colors.red,
            margin: EdgeInsetsDirectional.only(
              top: SizeConfig().scaleHeight(130),
              bottom: SizeConfig().scaleHeight(110),
            ),
            child: SvgPicture.asset(
              'images/$image.svg',
              fit: BoxFit.fitHeight,
            ),
          ),
          AppText(
            text: title,
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
          SizedBox(
            height: SizeConfig().scaleHeight(16),
          ),
          AppText(
            text: message,
            textColor: AppColors.APP_GREY_PRIMARY_COLOR,
          ),
        ],
      ),
    );
  }
}
