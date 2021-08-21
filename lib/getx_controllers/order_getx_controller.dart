import 'package:connect_store/api/order_api_controller.dart';
import 'package:connect_store/models/cart_order.dart';
import 'package:connect_store/models/order.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OrderGetxController extends GetxController {
  final OrderApiController orderApiController = OrderApiController();
  RxList<Order> orders = <Order>[].obs;
  RxBool loading = false.obs;

  static OrderGetxController get to => Get.find();

  Future<void> getOrders() async {
    loading.value = true;
    orders.value = await orderApiController.getAllOrders();
    loading.value = false;
    update();
  }

  void onInit() {
    super.onInit();
    getOrders();
    orders.refresh();
  }

  Future<bool> createOrder({
    required BuildContext context,
    required List<CartOrder> cart,
    required String paymentType,
    required int addressId,
    required int cardId,
  }) async {
    bool isAdded = await orderApiController.createOrder(
      context: context,
      cart: cart,
      paymentType: paymentType,
      addressId: addressId,
      cardId: cardId,
    );
    if (isAdded) {
      return true;
    }
    return false;
  }
}
