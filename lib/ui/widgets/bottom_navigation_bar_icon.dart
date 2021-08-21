import 'package:connect_store/utils/app_colors.dart';
import 'package:connect_store/utils/size_config.dart';
import 'package:flutter/material.dart';

class BottomNavigationBarIcon extends StatelessWidget {
  final int index;
  final int itemIndex;
  final IconData icon;

  BottomNavigationBarIcon(this.index, this.itemIndex,this.icon);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: SizeConfig().scaleHeight(32),
      width: SizeConfig().scaleWidth(32),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(6),
        ),
        color: index == itemIndex
            ? AppColors.APP_GREEN_PRIMARY_COLOR
            : Colors.white,
      ),
      child: Icon(icon),
    );
  }
}
