import 'package:connect_store/models/category.dart';
import 'package:connect_store/models/city.dart';
import 'package:connect_store/models/offer_product.dart';
import 'package:connect_store/models/product.dart';
import 'package:connect_store/models/sub_category.dart';

import 'faq.dart';

class BaseGenericArrayResponse<T> {
  late bool status;
  late String message;
  late List<T> list;

  BaseGenericArrayResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['list'] != null) {
      list = <T>[];
      if (T == Product) {
        json['list'].forEach((v) {
          list.add(Product.fromJson(v) as T);
        });
      } else if (T == City) {
        json['list'].forEach((v) {
          list.add(City.fromJson(v) as T);
        });
      } else if (T == Category) {
        json['list'].forEach((v) {
          list.add(Category.fromJson(v) as T);
        });
      } else if (T == SubCategory) {
        json['list'].forEach((v) {
          list.add(SubCategory.fromJson(v) as T);
        });
      } else if (T == OfferProduct) {
        json['list'].forEach((v) {
          list.add(OfferProduct.fromJson(v) as T);
        });
      } else if (T == FAQ) {
        json['list'].forEach((v) {
          list.add(FAQ.fromJson(v) as T);
        });
      }
    }
  }
}
