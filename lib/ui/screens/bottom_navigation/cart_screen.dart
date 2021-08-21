import 'dart:convert';
import 'package:connect_store/getx_controllers/cart_getx_controller.dart';
import 'package:connect_store/mixins/helpers.dart';
import 'package:connect_store/models/cart.dart';
import 'package:connect_store/ui/screens/product/product_details_screen.dart';
import 'package:connect_store/ui/widgets/app_text.dart';
import 'package:connect_store/ui/widgets/cart_item.dart';
import 'package:connect_store/ui/widgets/empty_data.dart';
import 'package:connect_store/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
    return Container(
      child:
          // controller.loading
          // ? CircularProgress()
          controller.cartList.isEmpty || controller.cartList == null
              ? EmptyData()
              : GetX<CartGetxController>(
                  builder: (CartGetxController controller) {
                  print('Id IS:${controller.cartList.first.id}');
                  return
                      // controller.loading
                      // ? CircularProgress():
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
                            Cart current = controller.cartList[index];
                            print('Id IS:${controller.cartList.first.id}');
                            return CartItem(
                              onTap: () => navigateToProductDetailsScreen(),
                              onDeleteTap: () async => await deleteItem(
                                  cartItem: current, context: context),
                              cart: current,
                            );
                          });
                }),
    );
  }

  void navigateToProductDetailsScreen() {
    Get.to(ProductDetailsScreen(id: _selectedId!));
    // Navigator.push(
    //     context,
    //     MaterialPageRoute(
    //       builder: (context) => ProductDetailsScreen(id: _selectedId!),
    //     ));
    print('SELECTED ID NEW!!!!!:$_selectedId');
  }

  void navigateToShoppingScreen() {
    // Get.to(SubCategoryScreen(id: _selectedId!));
    Get.to(() => ShoppingScreen(id: _selectedId!));
    // Navigator.pushReplacement(
    //     context,
    //     MaterialPageRoute(
    //       builder: (context) => SubCategoryScreen(id: _selectedId!),
    //     ));
    print('SELECTED ID NEW!!!!!:$_selectedId');
  }

  deleteItem({required Cart cartItem, required BuildContext context}) async {
    return await CartGetxController.to.deleteCartItem(cartItem.id);
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
