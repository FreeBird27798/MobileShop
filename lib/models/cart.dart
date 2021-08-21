class Cart {
  late int id;
  late int quantity;
  late int productId;
  late String imageUrl;
  late String nameAr;
  late String nameEn;
  late double price;

  Cart();

  Cart.fromMap(Map<String, dynamic> rowMap) {
    this.id = rowMap['id'];
    this.productId = rowMap['product_id'];
    this.imageUrl = rowMap['image'];
    this.nameAr = rowMap['name_ar'];
    this.nameEn = rowMap['name_en'];
    this.price = double.parse(rowMap['price'].toString());
    this.quantity = rowMap['quantity'];
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> data = new Map<String, dynamic>();
    data['product_id'] = this.productId;
    data['quantity'] = this.quantity;
    data['image'] = this.imageUrl;
    data['name_ar'] = this.nameAr;
    data['name_en'] = this.nameEn;
    data['price'] = this.price;
    return data;
  }
}
