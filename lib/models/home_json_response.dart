import 'package:connect_store/models/product.dart';
import 'package:connect_store/models/slider_image.dart';

import 'category.dart';

class HomeJson {
  late List<SliderImage> slider;
  late List<Category> categories;
  late List<Product> latestProducts;
  late List<Product> famousProducts;

  HomeJson({
    required this.slider,
    required this.categories,
    required this.latestProducts,
    required this.famousProducts,
  });

  HomeJson.fromJson(Map<String, dynamic> json) {
    if (json['slider'] != null) {
      slider = <SliderImage>[];
      json['slider'].forEach((v) {
        slider.add(SliderImage.fromJson(v));
      });
    }
    if (json['categories'] != null) {
      categories = <Category>[];
      json['categories'].forEach((v) {
        categories.add(Category.fromJson(v));
      });
    }
    if (json['latest_products'] != null) {
      latestProducts = <Product>[];
      json['latest_products'].forEach((v) {
        latestProducts.add(Product.fromJson(v));
      });
    }
    if (json['famous_products'] != null) {
      famousProducts = <Product>[];
      json['famous_products'].forEach((v) {
        famousProducts.add(Product.fromJson(v));
      });
    }
  }
}
