class CartOrder {
  late int quantity;
  late int productId;

  CartOrder();

  CartOrder.fromMap(Map<String, dynamic> rowMap) {
    this.productId = rowMap['product_id'];
    this.quantity = rowMap['quantity'];
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> data = Map<String, dynamic>();
    data['product_id'] = this.productId;
    data['quantity'] = this.quantity;
    return data;
  }
}
