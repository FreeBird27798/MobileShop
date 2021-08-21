import 'package:connect_store/getx_controllers/category_getx_controller.dart';
import 'package:connect_store/models/category.dart';
import 'package:connect_store/ui/screens/category/sub_category_screen.dart';
import 'package:connect_store/utils/size_config.dart';
import 'package:connect_store/ui/widgets/app_text.dart';
import 'package:connect_store/ui/widgets/category_item.dart';
import 'package:connect_store/ui/widgets/circular_progress.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/get.dart';

class CategoryScreen extends StatefulWidget {
  @override
  _CategoryScreenState createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  int? _selectedId;
  CategoryGetxController controller = Get.put(CategoryGetxController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
            onPressed: () => Get.back(), icon: Icon(Icons.arrow_back_ios)),
        title: AppText(
          text: AppLocalizations.of(context)!.category,
        ),
      ),
      body: Padding(
        padding: EdgeInsetsDirectional.only(
          start: SizeConfig().scaleWidth(25),
          end: SizeConfig().scaleWidth(25),
          top: SizeConfig().scaleHeight(10),
        ),
        child: GetX<CategoryGetxController>(
            init: CategoryGetxController(),
            builder: (CategoryGetxController controller) {
              print('CATEGORY Id IS:${controller.categories.first.id}');
              return controller.loading
                  ? CircularProgress()
                  : GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 15,
                        mainAxisSpacing: 15,
                        //main = > Vertical
                        childAspectRatio: SizeConfig().scaleWidth(155) /
                            SizeConfig().scaleHeight(180),
                      ),
                      itemCount: controller.categories.length,
                      itemBuilder: (context, index) {
                        Category categoryItem = controller.categories[index];
                        print('CURRENT CATEGORY IS :${categoryItem.nameEn}');
                        return InkWell(
                          onTap: () async {
                            setState(() {
                              _selectedId = categoryItem.id;
                            });
                            navigateToSubCategoryScreen();
                            // await CategoryGetxController(_selectedId)
                            //     .getSubCategories();
                            // print('SELECTED ID: $_selectedId');
                            // print('WE ARE NOT NUMBERS');
                          },
                          child: CategoryItem(
                            categoryItem: categoryItem,
                            item: AppLocalizations.of(context)!.item,
                            items: AppLocalizations.of(context)!.items,
                          ),
                        );
                      });
            }),
      ),
    );
  }

  void navigateToSubCategoryScreen() {
    // Get.to(SubCategoryScreen(id: _selectedId!));
    Get.to(() => SubCategoryScreen(id: _selectedId!));
    // Navigator.pushReplacement(
    //     context,
    //     MaterialPageRoute(
    //       builder: (context) => SubCategoryScreen(id: _selectedId!),
    //     ));
    print('SELECTED ID NEW!!!!!:$_selectedId');
  }
}
