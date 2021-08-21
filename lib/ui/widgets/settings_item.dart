import 'package:connect_store/utils/app_colors.dart';
import 'package:connect_store/utils/size_config.dart';
import 'package:flutter/material.dart';

import 'app_text.dart';

class SettingsItem extends StatelessWidget {
  final void Function() onTap;
  final String text;
  final IconData icon;

  SettingsItem({
    required this.onTap,
    required this.text,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsetsDirectional.only(
          start: SizeConfig().scaleWidth(16),
          top: SizeConfig().scaleHeight(10),
          bottom: SizeConfig().scaleHeight(10),
        ),
        height: SizeConfig().scaleHeight(44),
        margin:
            EdgeInsetsDirectional.only(bottom: SizeConfig().scaleHeight(14)),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(6),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Icon(
              icon,
              color: AppColors.APP_GREEN_PRIMARY_COLOR,
            ),
            SizedBox(
              width: SizeConfig().scaleWidth(24),
            ),
            Expanded(
                child: AppText(
              text: text,
              textAlign: TextAlign.start,
              fontSize: 14,
            )),
          ],
        ),
      ),
    );
  }
}
