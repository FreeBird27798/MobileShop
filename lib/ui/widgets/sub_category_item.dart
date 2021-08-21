import 'package:connect_store/models/sub_category.dart';
import 'package:connect_store/storage/preferences/app_pref_controller.dart';
import 'package:connect_store/utils/app_colors.dart';
import 'package:connect_store/utils/size_config.dart';
import 'package:flutter/material.dart';
import 'app_text.dart';

class SubCategoryItem extends StatelessWidget {
  final SubCategory subCategory;
  final void Function() onTap;

  SubCategoryItem({required this.subCategory, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: SizeConfig().scaleHeight(135),
        width: SizeConfig().scaleWidth(135),
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Image.network(
              subCategory.imageUrl,
              width: SizeConfig().scaleWidth(50),
            ),
            AppText(
              text: AppPrefController().languageCode == 'en'
                  ? subCategory.nameEn
                  : subCategory.nameAr,
              textColor: AppColors.APP_BLACK_PRIMARY_COLOR,
              fontWeight: FontWeight.w600,
            ),
          ],
        ),
      ),
    );
  }
}
