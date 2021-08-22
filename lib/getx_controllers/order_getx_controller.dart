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
    List<Order> myOrders = await orderApiController.getAllOrders();
    if (myOrders.isNotEmpty || myOrders != null) {
      orders.value = myOrders;
    }
    // orders.refresh();
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
    required String cart,
    required String paymentType,
    required int addressId,
    required int cardId,
    required String holderName,
    required String cardNumber,
    required String expDate,
    required String cvv,
    required String type,
  }) async {
    bool isAdded = await orderApiController.createOrder(
      context: context,
      cart: cart,
      paymentType: paymentType,
      addressId: addressId,
      cardId: cardId,
      holderName: holderName,
      cardNumber: cardNumber,
      expDate: expDate,
      cvv: cvv,
      type: type,
    );
    if (isAdded) {
      return true;
    }
    return false;
  }
}
