import 'dart:convert';
import 'package:connect_store/mixins/api_mixin.dart';
import 'package:connect_store/mixins/helpers.dart';
import 'package:connect_store/models/cart_order.dart';
import 'package:connect_store/models/order.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

import 'api_settings.dart';

class OrderApiController with ApiMixin, Helpers {
  Future<bool> createOrder({
    required BuildContext context,
    required List<CartOrder> cart,
    required String paymentType,
    required int addressId,
    required int cardId,
  }) async {
    var response = await http.post(
      getUrl(ApiSettings.ORDERS),
      headers: requestHeaders,
      body: {
        ApiSettings.CART: cart,
        ApiSettings.PAYMENT_TYPE: paymentType,
        ApiSettings.ADDRESS_ID: addressId.toString(),
        ApiSettings.CARD_ID: cardId.toString(),
      },
    );
    if (isSuccessRequest(response.statusCode)) {
      var message = jsonDecode(response.body)['message'];
      showSnackBar(context: context, message: message);
      return true;
    } else if (response.statusCode != 500)
      showMessage(context, response, error: true);
    else
      handleServerError(context);

    return false;
  }

  Future<List<Order>> getAllOrders() async {
    var response =
        await http.get(getUrl(ApiSettings.ORDERS), headers: requestHeaders);
    if (isSuccessRequest(response.statusCode)) {
      var data = jsonDecode(response.body)['list'] as List;
      List<Order> orders = data.map((e) => Order.fromJson(e)).toList();
      return orders;
    }
    return [];
  }

  Future getOrderDetails(
      {required int orderId, required BuildContext context}) async {
    var response = await http.get(getUrl(ApiSettings.ORDERS + '/$orderId'),
        headers: requestHeaders);
    if (isSuccessRequest(response.statusCode)) {
      var message = jsonDecode(response.body)['message'];
      showSnackBar(context: context, message: message);
    }
  }
}
