import 'package:connect_store/models/image_object.dart';
import 'package:connect_store/models/sub_category.dart';

class Product {
  late int id;
  late String nameEn;
  late String nameAr;
  late String infoEn;
  late String infoAr;
  late double price;
  late int quantity;
  late double? overalRate;
  late int subCategoryId;
  late double? productRate;
  late int? offerPrice;
  late bool isFavorite;
  late String imageUrl;
  late List<ImageObject> images;
  late SubCategory? subCategory;
  late Pivot pivot;

  Product();

  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nameEn = json['name_en'];
    nameAr = json['name_ar'];
    infoEn = json['info_en'];
    infoAr = json['info_ar'];
    price = double.parse(json['price'].toString());
    quantity = json['quantity'];
    overalRate = double.parse(json['overal_rate'].toString());
    subCategoryId = json['sub_category_id'];
    productRate = double.parse(json['product_rate'].toString());
    offerPrice = json['offer_price'];
    isFavorite = json['is_favorite'];
    imageUrl = json['image_url'];
  }

  Product.detailsFromJson(Map<String, dynamic> json) {
    id = json['id'];
    nameEn = json['name_en'];
    nameAr = json['name_ar'];
    infoEn = json['info_en'];
    infoAr = json['info_ar'];
    price = double.parse(json['price'].toString());
    quantity = json['quantity'];
    overalRate = double.parse(json['overal_rate'].toString());
    subCategoryId = json['sub_category_id'];
    productRate = double.parse(json['product_rate'].toString());
    offerPrice = json['offer_price'];
    isFavorite = json['is_favorite'];
    imageUrl = json['image_url'];
    if (json['images'] != null) {
      images = <ImageObject>[];
      json['images'].forEach((v) {
        images.add(ImageObject.fromJson(v));
      });
    }
    if (json['sub_category'] != null) {
      subCategory = SubCategory.fromJson(json['sub_category']);
    } else {
      subCategory = null;
    }
  }

  Product.favoriteFromJson(Map<String, dynamic> json) {
    id = json['id'];
    nameEn = json['name_en'];
    nameAr = json['name_ar'];
    infoEn = json['info_en'];
    infoAr = json['info_ar'];
    price = double.parse(json['price'].toString());
    quantity = json['quantity'];
    overalRate = double.parse(json['overal_rate'].toString());
    subCategoryId = json['sub_category_id'];
    productRate = double.parse(json['product_rate'].toString());
    offerPrice = json['offer_price'];
    isFavorite = json['is_favorite'];
    imageUrl = json['image_url'];
    pivot = Pivot.fromJson(json['pivot']);
  }
}

class Pivot {
  late int userId;
  late int productId;

  Pivot.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    productId = json['product_id'];
  }
}
