import 'package:connect_store/getx_controllers/product_getx_controller.dart';
import 'package:connect_store/models/offer_product.dart';
import 'package:connect_store/storage/preferences/app_pref_controller.dart';
import 'package:connect_store/ui/screens/product/product_details_screen.dart';
import 'package:connect_store/utils/app_colors.dart';
import 'package:connect_store/utils/size_config.dart';
import 'package:flutter/material.dart';
import 'app_text.dart';

class OfferProductItem extends StatefulWidget {
  final OfferProduct currentProduct;
  final void Function()? onPressed;
  final bool hasMargin;

  bool _isFavorite = false;

  OfferProductItem({
    required this.currentProduct,
    this.onPressed,
    this.hasMargin = true,
  });

  @override
  _OfferProductItemState createState() => _OfferProductItemState();
}

class _OfferProductItemState extends State<OfferProductItem> {
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
                top: SizeConfig().scaleHeight(15),
                bottom: SizeConfig().scaleHeight(15),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Image.network(
                  //       widget.currentProduct.image,
                  //   height: SizeConfig().scaleHeight(110),
                  // ),
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
                  AppText(
                    text: widget.currentProduct.originalPrice.toString() + '₪',
                    textDecoration: TextDecoration.lineThrough,
                    textColor: AppColors.DELETE_COLOR,
                  ),
                  SizedBox(
                    height: SizeConfig().scaleHeight(8),
                  ),
                  AppText(
                    text: widget.currentProduct.discountPrice.toString() + '₪',
                    fontWeight: FontWeight.bold,
                  ),
                  SizedBox(
                    height: SizeConfig().scaleHeight(8),
                  ),
                ],
              ),
            ),
            PositionedDirectional(
                start: SizeConfig().scaleWidth(10),
                top: SizeConfig().scaleHeight(10),
                // start: 0,
                child: AppText(
                    text: widget.currentProduct.discountRatio.toString())),
          ],
        ),
      ),
    );
  }

  // Future addRemoveToFavorite() async {
  //   // ProductGetxController.to.favoriteProducts.refresh();
  //   // setState(() {
  //   //   widget.currentProduct.isFavorite = !widget.currentProduct.isFavorite;
  //   // });
  //   await _productGetxController.addRemoveToFavorite(
  //       context: context, currentProduct: widget.currentProduct);
  // }

  void navigateToProductDetailsScreen() {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) =>
              ProductDetailsScreen(id: widget.currentProduct.productId),
        ));
    print('SELECTED ID NEW!!!!!:${widget.currentProduct.productId}');
  }
}
