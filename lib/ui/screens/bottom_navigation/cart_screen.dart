import 'dart:convert';
import 'package:connect_store/getx_controllers/cart_getx_controller.dart';
import 'package:connect_store/utils/helpers.dart';
import 'package:connect_store/models/cart.dart';
import 'package:connect_store/ui/screens/orders/create_order_screen.dart';
import 'package:connect_store/ui/screens/product/product_details_screen.dart';
import 'package:connect_store/ui/widgets/app_elevated_button.dart';
import 'package:connect_store/ui/widgets/app_text.dart';
import 'package:connect_store/ui/widgets/cart_item.dart';
import 'package:connect_store/ui/widgets/empty_data.dart';
import 'package:connect_store/utils/app_colors.dart';
import 'package:connect_store/utils/size_config.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../shopping_screen.dart';

class CartScreen extends StatefulWidget {
  final bool withScaffold;

  CartScreen({this.withScaffold = false});

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> with Helpers {
  int? _selectedId;
  final controller = Get.put(CartGetxController());
  double _total = 0;
  late Cart current;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () async {
      await CartGetxController.to.readCartList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return widget.withScaffold
        ? Scaffold(
            body: screenContent(),
          )
        : screenContent();
  }

  Widget screenContent() {
    return GetX<CartGetxController>(builder: (CartGetxController controller) {
      // print('Id IS:${controller.cartList.first.id}');

      return controller.cartList.isEmpty || controller.cartList == null
          ? EmptyData()
          : Stack(
              children: [
                Container(
                  child:
                      // controller.loading
                      // ? CircularProgress()
                      ListView.builder(
                          // gridDelegate:
                          //     SliverGridDelegateWithFixedCrossAxisCount(
                          //   crossAxisCount: 2,
                          //   crossAxisSpacing: 15,
                          //   mainAxisSpacing: 15,
                          //   //main = > Vertical
                          //   childAspectRatio: SizeConfig().scaleWidth(155) /
                          //       SizeConfig().scaleHeight(270),
                          // ),
                          itemCount: controller.cartList.length,
                          itemBuilder: (context, index) {
                            current = controller.cartList[index];
                            print('Id IS:${controller.cartList.first.id}');
                            return CartItem(
                              onTap: () {},
                              onDeleteTap: () async => await deleteItem(
                                  cartItem: current, context: context),
                              cart: current,
                              total: _total,
                              onIncrease: () => getCartTotal(),
                              onDecrease: () => getCartTotal(),
                            );
                          }),
                ),
                PositionedDirectional(
                  bottom: 0,
                  start: 0,
                  end: 0,
                  child: Container(
                    padding: EdgeInsetsDirectional.only(
                      start: SizeConfig().scaleWidth(25),
                      end: SizeConfig().scaleWidth(25),
                      top: SizeConfig().scaleHeight(20),
                      bottom: SizeConfig().scaleHeight(30),
                    ),
                    alignment: AlignmentDirectional.bottomCenter,
                    height: SizeConfig().scaleHeight(250),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(SizeConfig().scaleWidth(12)),
                        topLeft: Radius.circular(SizeConfig().scaleWidth(12)),
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            AppText(
                                text: AppLocalizations.of(context)!.sub_total),
                            AppText(text: _total.toString() + ' ₪'),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            AppText(
                                text: AppLocalizations.of(context)!.discount),
                            AppText(text: '0'),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            AppText(
                                text: AppLocalizations.of(context)!.shipping),
                            AppText(text: 0.toString()),
                          ],
                        ),
                        Divider(
                          height: SizeConfig().scaleHeight(32),
                          color: AppColors.APP_GREEN_PRIMARY_COLOR,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            AppText(
                              text: AppLocalizations.of(context)!.total,
                              textColor: AppColors.APP_GREEN_PRIMARY_COLOR,
                            ),
                            AppText(
                              text: _total.toString() + ' ₪',
                              textColor: AppColors.APP_GREEN_PRIMARY_COLOR,
                            ),
                          ],
                        ),
                        AppElevatedButton(
                          enabled: true,
                          onPressed: () {
                            setState(() => navigateToCreateOrderScreen());
                          },
                          backgroundColor: AppColors.GREY_BUTTON_COLOR,
                          text:
                              AppLocalizations.of(context)!.proceed_to_checkout,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
    });
  }

  void navigateToProductDetailsScreen() {
    Get.to(ProductDetailsScreen(id: _selectedId!));
  }

  void navigateToCreateOrderScreen() {
    Get.to(CreateOrderScreen(
      cart: cart,
    ));
  }

  // void navigateToShoppingScreen() {
  //   Get.to(() => ShoppingScreen(id: _selectedId!));
// }

  deleteItem({required Cart cartItem, required BuildContext context}) async {
    return await CartGetxController.to.deleteCartItem(cartItem.id);
  }

  void getCartTotal() {
    if (controller.cartList != null) {
      _total = 0;
      for (int i = 0; i < controller.cartList.length; i++) {
        setState(() {
          _total +=
              (controller.cartList[i].price * controller.cartList[i].quantity);
        });
        print('There are ${controller.cartList.length} many items in the cart');
      }
    }
  }

  String get cart {
    List<Map<String, dynamic>> items = [];
    CartGetxController.to.cartList
        .map((element) => items.add(
            {'product_id': element.productId, 'quantity': element.quantity}))
        .toList();
    return jsonEncode(items);
  }
}
