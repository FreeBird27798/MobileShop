import 'package:connect_store/utils/app_colors.dart';
import 'package:connect_store/ui/widgets/app_text.dart';
import 'package:flutter/material.dart';

class EmptyData extends StatelessWidget {
  final String text;

  EmptyData({this.text ='No Data!'});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.warning,
            size: 80,
            color: AppColors.APP_GREEN_PRIMARY_COLOR,
          ),
          AppText(
            text: text,
            fontSize: 26,
            textColor: AppColors.APP_GREEN_PRIMARY_COLOR,
          )
        ],
      ),
    );
  }
}
