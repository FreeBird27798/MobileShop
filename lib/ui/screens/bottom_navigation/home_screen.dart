import 'package:carousel_slider/carousel_slider.dart';
import 'package:connect_store/getx_controllers/home_getx_controller.dart';
import 'package:connect_store/models/product.dart';
import 'package:connect_store/utils/app_colors.dart';
import 'package:connect_store/utils/size_config.dart';
import 'package:connect_store/ui/widgets/app_elevated_button.dart';
import 'package:connect_store/ui/widgets/app_text.dart';
import 'package:connect_store/ui/widgets/app_text_field.dart';
import 'package:connect_store/ui/widgets/circular_progress.dart';
import 'package:connect_store/ui/widgets/product_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/get.dart';

import '../product/product_details_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late TextEditingController _searchTextController;
  int? _selectedId;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _searchTextController = TextEditingController();

  }

  @override
  void dispose() {
    // TODO: implement dispose
    _searchTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool isRated = false;
    // print('TOKEN IS: ${UserPrefController().user.token}');
    return GetX<HomeGetxController>(
        builder: (HomeGetxController controller) {
      print('SLIDER LENGTH IS:${controller.sliders.length}');
      return controller.loading
          ? CircularProgress()
          : Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: DecoratedBox(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(6)),
                              boxShadow: [
                                BoxShadow(
                                  blurRadius: 10,
                                  spreadRadius: 0,
                                  offset: Offset(0, 4),
                                  color: Colors.black.withOpacity(0.07),
                                ),
                              ]),
                          child: AppTextField(
                            height: 50,
                            hintText: AppLocalizations.of(context)!.search,
                            textEditingController: _searchTextController,
                            icon: Icons.search,
                            iconColor: AppColors.APP_GREY_PRIMARY_COLOR,
                            enablePadding: true,
                            onChanged: (value) {},
                          )),
                    ),
                    SizedBox(
                      width: SizeConfig().scaleWidth(10),
                    ),
                    DecoratedBox(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(6)),
                          boxShadow: [
                            BoxShadow(
                              blurRadius: 10,
                              spreadRadius: 0,
                              offset: Offset(0, 4),
                              color: Colors.black.withOpacity(0.07),
                            ),
                          ]),
                      child: AppElevatedButton(
                        height: 50,
                        width: 50,
                        hasIcon: true,
                        icon: Icons.filter_alt_outlined,
                        enabled: true,
                        backgroundColor: AppColors.APP_BLACK_PRIMARY_COLOR,
                        onPressed: () {},
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: SizeConfig().scaleHeight(32),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        CarouselSlider.builder(
                            itemCount: controller.sliders.length,
                            itemBuilder: (context, index, realIndex) {
                              print(
                                  'SLIDER LENGTH: ${controller.sliders.length.toString()}');
                              print('INDEX IS $index');
                              print('REAL INDEX IS $realIndex');
                              return Container(
                                  alignment: AlignmentDirectional.center,
                                  width: SizeConfig().scaleWidth(325),
                                  height: double.infinity,
                                  margin: EdgeInsets.symmetric(horizontal: 5.0),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                  child: Image.network(
                                    controller.sliders[index].imageUrl,
                                    fit: BoxFit.cover,
                                  ));
                            },
                            options: CarouselOptions(autoPlay: true)),
                        SizedBox(
                          height: SizeConfig().scaleHeight(16),
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: AppText(
                                text: AppLocalizations.of(context)!
                                    .latest_products,
                                textAlign: TextAlign.start,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            TextButton(
                              onPressed: () => navigateToLatestProductsScreen(),
                              style: TextButton.styleFrom(
                                padding: EdgeInsetsDirectional.zero,
                                minimumSize: Size(
                                  SizeConfig().scaleWidth(34),
                                  SizeConfig().scaleHeight(11),
                                ),
                              ),
                              child: AppText(
                                text: AppLocalizations.of(context)!.see_all,
                                textColor: AppColors.APP_GREEN_PRIMARY_COLOR,
                                fontSize: 12,
                                textAlign: TextAlign.end,
                              ),
                            ),
                          ],
                        ),
                        Container(
                          height: SizeConfig().scaleHeight(270),
                          child: ListView.builder(
                              physics: AlwaysScrollableScrollPhysics(),
                              itemCount: controller.latestProducts.length,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) {
                                Product currentProduct =
                                    controller.latestProducts[index];
                                return ProductItem(
                                  currentProduct: currentProduct,
                                );
                              }),
                        ),
                        SizedBox(
                          height: SizeConfig().scaleHeight(16),
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: AppText(
                                text:
                                    AppLocalizations.of(context)!.popular_item,
                                textAlign: TextAlign.start,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            TextButton(
                              onPressed: () => navigateToFamousProductsScreen(),
                              style: TextButton.styleFrom(
                                padding: EdgeInsetsDirectional.zero,
                                minimumSize: Size(
                                  SizeConfig().scaleWidth(34),
                                  SizeConfig().scaleHeight(11),
                                ),
                              ),
                              child: AppText(
                                text: AppLocalizations.of(context)!.see_all,
                                textColor: AppColors.APP_GREEN_PRIMARY_COLOR,
                                fontSize: 12,
                                textAlign: TextAlign.end,
                              ),
                            ),
                          ],
                        ),
                        Container(
                          height: SizeConfig().scaleHeight(270),
                          child: ListView.builder(
                              itemCount: controller.famousProducts.length,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) {
                                Product currentProduct =
                                    controller.famousProducts[index];
                                return ProductItem(
                                  currentProduct: currentProduct,
                                );
                              }),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
    });
  }

  void setIsFavorite(Product currentProduct) {
    setState(() {
      currentProduct.isFavorite = !currentProduct.isFavorite;
    });
  }

  navigateToLatestProductsScreen() {
    Navigator.pushNamed(context, '/latest_products_screen');
  }

  navigateToFamousProductsScreen() {
    Navigator.pushNamed(context, '/famous_products_screen');
  }

  void navigateToProductDetailsScreen() {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ProductDetailsScreen(id: _selectedId!),
        ));
    print('SELECTED ID NEW!!!!!:$_selectedId');
  }
}
