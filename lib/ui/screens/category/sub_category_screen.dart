import 'package:connect_store/getx_controllers/category_getx_controller.dart';
import 'package:connect_store/getx_controllers/product_getx_controller.dart';
import 'package:connect_store/models/product.dart';
import 'package:connect_store/models/sub_category.dart';
import 'package:connect_store/utils/size_config.dart';
import 'package:connect_store/ui/widgets/app_text.dart';
import 'package:connect_store/ui/widgets/circular_progress.dart';
import 'package:connect_store/ui/widgets/empty_data.dart';
import 'package:connect_store/ui/widgets/latest_product_item.dart';
import 'package:connect_store/ui/widgets/sub_category_item.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SubCategoryScreen extends StatefulWidget {
  final int id;

  SubCategoryScreen({required this.id});

  @override
  _SubCategoryScreenState createState() => _SubCategoryScreenState();
}

class _SubCategoryScreenState extends State<SubCategoryScreen> {
  int? _selectedItemId;
  bool? _clicked;
  final controller = Get.put(CategoryGetxController());
  final _productsController = Get.put(ProductGetxController());

  @override
  void initState() {
    Future.delayed(Duration.zero, () async {
      await controller.getSubCategories(id: widget.id);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: false,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
              _productsController.products.clear();
              _productsController.products.refresh();
            },
            icon: Icon(Icons.arrow_back_ios)),
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
            builder: (CategoryGetxController controller) {
          print('SUBCATEGORY LENGTH IS:${controller.subCategories.length}');
          // print('CATEGORY Id IS:${controller.subCategories.first.id}');
          return controller.loading
              ? CircularProgress()
              : controller.subCategories.isNotEmpty
                  ? Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        GridView.builder(
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 15,
                            mainAxisSpacing: 15,
                            //main = > Vertical
                            childAspectRatio: SizeConfig().scaleWidth(135) /
                                SizeConfig().scaleHeight(135),
                          ),
                          shrinkWrap: true,
                          itemCount: controller.subCategories.length,
                          itemBuilder: (context, index) {
                            SubCategory categoryItem =
                                controller.subCategories[index];
                            // SubCategory thisCategory = controller.subCategories
                            //     .firstWhere(((prod) => prod.id == _selectedItemId));
                            // setTitle(thisCategory);
                            return SubCategoryItem(
                                subCategory: categoryItem,
                                onTap: () async {
                                  setState(() {
                                    _selectedItemId = categoryItem.id;
                                  });
                                  print('SubCategory ID = $_selectedItemId');
                                  await getCategoryProducts();
                                });
                          },
                        ),
                        SizedBox(height: SizeConfig().scaleHeight(20),),
                        _productsController.loading
                            ? Expanded(child: CircularProgress())
                            : _productsController.products.isNotEmpty
                                ? Expanded(
                                    child: ListView.builder(
                                        itemCount:
                                            _productsController.products.length,
                                        itemBuilder: (context, index) {
                                          Product currentProduct =
                                              _productsController
                                                  .products[index];
                                          return LatestProductItem(
                                            currentProduct: currentProduct,
                                            context: context,
                                          );
                                        }),
                                  )
                                : Expanded(child: EmptyData()),
                      ],
                    )
                  : EmptyData(
                      text: 'This Category does not have any subCategories!',
                    );
        }),
      ),
    );
  }

  Future getCategoryProducts() async {
    await _productsController.getProducts(id: _selectedItemId!);
  }
}
