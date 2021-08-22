import 'package:connect_store/models/cart_order.dart';

class Order {
  late int id;
  late int? total;
  late String? date;
  late List<CartOrder> carts;
  late String? paymentType;
  late String? status;
  late int? storeId;
  late int? userId;
  late int? addressId;
  late int? paymentCardId;
  late int? orderProductsCount;

  Order();

  Order.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    total = json['total'];
    date = json['date'];
    paymentType = json['payment_type'];
    status = json['status'];
    storeId = json['store_id'];
    userId = json['user_id'];
    addressId = json['address_id'];
    paymentCardId = json['payment_card_id'];
    orderProductsCount = json['order_products_count'];
    if (json['cart'] != null) {
      carts = <CartOrder>[];
      json['cart'].forEach((v) {
        carts.add(CartOrder.fromMap(v));
      });
    }

    Map<String, dynamic> toJson() {
      final Map<String, dynamic> data = new Map<String, dynamic>();
      data['id'] = this.id;
      data['total'] = this.total;
      data['date'] = this.date;
      data['payment_type'] = this.paymentType;
      data['status'] = this.status;
      data['store_id'] = this.storeId;
      data['user_id'] = this.userId;
      data['address_id'] = this.addressId;
      data['payment_card_id'] = this.paymentCardId;
      data['order_products_count'] = this.orderProductsCount;
      data['cart'] = this.carts;
      return data;
    }
  }
}
