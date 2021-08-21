import 'package:connect_store/getx_controllers/product_getx_controller.dart';
import 'package:connect_store/models/product.dart';
import 'package:connect_store/utils/app_colors.dart';
import 'package:flutter/material.dart';

class FavoriteIcon extends StatelessWidget {
  final Product currentProduct;
  final void Function() onPressed;

  FavoriteIcon({
    required this.currentProduct,
    required this.onPressed,
  });
  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed:onPressed,
        icon: Icon(
          currentProduct.isFavorite
              ? Icons.favorite
              : Icons.favorite_border,
          color: currentProduct.isFavorite
              ? AppColors.APP_GREEN_PRIMARY_COLOR
              : Colors.grey,
        ));
  }
}
