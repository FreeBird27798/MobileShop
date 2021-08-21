import 'package:connect_store/models/category.dart';
import 'package:connect_store/storage/preferences/app_pref_controller.dart';
import 'package:connect_store/utils/size_config.dart';
import 'package:flutter/material.dart';

import 'app_text.dart';

class CategoryItem extends StatelessWidget {
  final Category categoryItem;
  final String item;
  final String items;

  CategoryItem({
    required this.categoryItem,
    required this.item,
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsetsDirectional.only(
                start: SizeConfig().scaleWidth(25),
                end: SizeConfig().scaleWidth(25),
                top: SizeConfig().scaleHeight(25),
                bottom: SizeConfig().scaleHeight(25),
              ),
              child: Image.network(
                categoryItem.imageUrl,
              ),
            ),
            SizedBox(
              height: SizeConfig().scaleHeight(6),
            ),
            AppText(
              text: AppPrefController().languageCode == 'en'
                  ? categoryItem.nameEn
                  : categoryItem.nameAr,
            ),
            SizedBox(
              height: SizeConfig().scaleHeight(5),
            ),
            AppText(
              text: categoryItem.subCategoriesCount == 1
                  ? categoryItem.subCategoriesCount.toString() + ' ' + item
                  : categoryItem.subCategoriesCount.toString() + ' ' + items,
              fontSize: 11,
              fontWeight: FontWeight.w600,
            ),
          ],
        ),
      );
  }
}
