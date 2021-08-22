import 'package:connect_store/getx_controllers/product_getx_controller.dart';
import 'package:connect_store/models/product.dart';
import 'package:connect_store/storage/preferences/app_pref_controller.dart';
import 'package:connect_store/ui/screens/product/product_details_screen.dart';
import 'package:connect_store/ui/widgets/star.dart';
import 'package:connect_store/utils/app_colors.dart';
import 'package:connect_store/utils/size_config.dart';
import 'package:connect_store/ui/widgets/rate_widget.dart';
import 'package:flutter/material.dart';
import 'app_text.dart';
import 'favorite_icon.dart';

class ProductItem extends StatefulWidget {
  final Product currentProduct;
  final void Function()? onPressed;
  final bool hasMargin;

  bool _isFavorite = false;

  ProductItem({
    required this.currentProduct,
    this.onPressed,
    this.hasMargin = true,
  });

  @override
  _ProductItemState createState() => _ProductItemState();
}

class _ProductItemState extends State<ProductItem> {
  ProductGetxController _productGetxController = ProductGetxController.to;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async => navigateToProductDetailsScreen(),
      child: Container(
        margin: widget.hasMargin
            ? EdgeInsetsDirectional.only(end: SizeConfig().scaleWidth(15))
            : null,
        clipBehavior: Clip.antiAlias,
        width: SizeConfig().scaleWidth(155),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(6),
            boxShadow: [
              BoxShadow(
                blurRadius: 10,
                spreadRadius: 0,
                offset: Offset(0, 8),
                color: AppColors.APP_BLACK_PRIMARY_COLOR.withOpacity(0.14),
              ),
            ]),
        child: Stack(
          alignment: AlignmentDirectional.center,
          children: [
            Container(
              padding: EdgeInsetsDirectional.only(
                top: SizeConfig().scaleHeight(40),
                bottom: SizeConfig().scaleHeight(15),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.network(
                    widget.currentProduct.imageUrl,
                    height: SizeConfig().scaleHeight(110),
                  ),
                  SizedBox(
                    height: SizeConfig().scaleHeight(20),
                  ),
                  AppText(
                      text: AppPrefController().languageCode == 'en'
                          ? widget.currentProduct.nameEn
                          : widget.currentProduct.nameAr),
                  SizedBox(
                    height: SizeConfig().scaleHeight(8),
                  ),
                  AppText(text: widget.currentProduct.price.toString() + '₪'),
                  SizedBox(
                    height: SizeConfig().scaleHeight(8),
                  ),
                  Star(
                    isRated: widget.currentProduct.overalRate != null,
                  ),
                ],
              ),
            ),
            PositionedDirectional(
                end: SizeConfig().scaleWidth(10),
                top: SizeConfig().scaleHeight(10),
                // start: 0,
                child: FavoriteIcon(
                  currentProduct: widget.currentProduct,
                  onPressed: () async => await addRemoveToFavorite(),
                )),
          ],
        ),
      ),
    );
  }

  Future addRemoveToFavorite() async {
    // ProductGetxController.to.favoriteProducts.refresh();
    await _productGetxController.addRemoveToFavorite(
        context: context, currentProduct: widget.currentProduct);
    setState(() {
      widget.currentProduct.isFavorite =
          _productGetxController.product.value!.isFavorite;
    });
  }

  void navigateToProductDetailsScreen() {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) =>
              ProductDetailsScreen(id: widget.currentProduct.id),
        ));
    print('SELECTED ID NEW!!!!!:${widget.currentProduct.id}');
  }
}
