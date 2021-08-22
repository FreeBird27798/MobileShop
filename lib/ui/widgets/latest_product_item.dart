import 'package:connect_store/getx_controllers/cart_getx_controller.dart';
import 'package:connect_store/models/cart.dart';
import 'package:connect_store/models/product.dart';
import 'package:connect_store/storage/preferences/app_pref_controller.dart';
import 'package:connect_store/ui/widgets/star.dart';
import 'package:connect_store/utils/app_colors.dart';
import 'package:connect_store/utils/size_config.dart';
import 'package:connect_store/ui/widgets/app_elevated_button.dart';
import 'package:connect_store/ui/widgets/rate_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/get.dart';

import 'app_text.dart';

class LatestProductItem extends StatelessWidget {
  final Product currentProduct;
  final BuildContext context;

  LatestProductItem({
    required this.currentProduct,
    required this.context,
  });

  final _cartGetxController = Get.put(CartGetxController());

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsetsDirectional.only(bottom: SizeConfig().scaleHeight(15)),
      padding: EdgeInsetsDirectional.all(5),
      clipBehavior: Clip.antiAlias,
      height: SizeConfig().scaleHeight(155),
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
      child: Row(
        children: [
          Image.network(
            currentProduct.imageUrl,
            width: SizeConfig().scaleHeight(115),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppText(
                text: AppPrefController().languageCode == 'en'
                    ? currentProduct.nameEn
                    : currentProduct.nameAr,
                fontWeight: FontWeight.w700,
                textAlign: TextAlign.start,
              ),
              SizedBox(
                width: SizeConfig().scaleWidth(8),
              ),
              AppText(
                text: currentProduct.price.toString() + '₪',
                textColor: AppColors.APP_GREEN_PRIMARY_COLOR,
              ),
              SizedBox(
                height: SizeConfig().scaleHeight(8),
              ),
              Star(
                isRated: currentProduct.overalRate != null,
              ),
            ],
          ),
          SizedBox(
            width: SizeConfig().scaleWidth(20),
          ),
          Expanded(
            child: AppElevatedButton(
              width: SizeConfig().scaleWidth(70),
              borderRadius: 32,
              enabled: true,
              text: AppLocalizations.of(context)!.add_to_cart,
              onPressed: () async =>
                  await _cartGetxController.createCartItem(cart),
            ),
          ),
        ],
      ),
    );
  }

  Cart get cart {
    Product product = currentProduct;
    Cart cart = Cart();
    cart.imageUrl = product.imageUrl;
    cart.productId = product.id;
    cart.price = product.price;
    cart.nameEn = product.nameEn;
    cart.nameAr = product.nameAr;
    cart.quantity = product.quantity;
    return cart;
  }
}
