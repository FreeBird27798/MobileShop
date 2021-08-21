import 'package:connect_store/api/product_api_controller.dart';
import 'package:connect_store/models/image_object.dart';
import 'package:connect_store/models/offer_product.dart';
import 'package:connect_store/models/product.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class ProductGetxController extends GetxController {
  RxList<Product> products = <Product>[].obs;
  ProductApiController _productApiController = ProductApiController();
  Rx<Product?> product = Product().obs;
  Rx<Product?> myProduct = Product().obs;
  RxList<ImageObject> productImages = <ImageObject>[].obs;
  RxList<Product> favoriteProducts = <Product>[].obs;
  RxList<OfferProduct> offerProducts = <OfferProduct>[].obs;

  static ProductGetxController get to => Get.find();
  bool loading = false;

  @override
  void onInit() {
    super.onInit();
    getFavoriteProducts();
    getProductsOffer();
  }

  Future<void> getProductsOffer() async {
    offerProducts.value = await _productApiController.getProductsOffer();
    offerProducts.refresh();
  }

  Future<void> getProducts({required int id}) async {
    _startLoading();
    products.value = await _productApiController.getProducts(id: id);
    _stopLoading();
    update();
  }

  Future<void> getProductDetails({required int productId}) async {
    _startLoading();
    Product? currentProduct =
        await _productApiController.getProductDetails(productId);
    if (currentProduct != null) {
      product.value = currentProduct;
      productImages.value = currentProduct.images;
    }
    _stopLoading();
    product.refresh();
    productImages.refresh();
    update();
  }

  Future addRemoveToFavorite(
      {required BuildContext context, required Product currentProduct}) async {
    bool status = await _productApiController.addRemoveToFavorite(
        productId: currentProduct.id);
    if (status) {
      int index = favoriteProducts
          .indexWhere((element) => element.id == currentProduct.id);
      if (index != -1) {
        favoriteProducts.removeAt(index);
        product.value!.isFavorite = !product.value!.isFavorite;
      } else {
        favoriteProducts.add(currentProduct);
        product.value!.isFavorite = !product.value!.isFavorite;
      }
    }
    product.refresh();
    favoriteProducts.refresh();
    update();
  }

  Future<void> getFavoriteProducts() async {
    // _startLoading();
    List<Product> products = await _productApiController.getFavoriteProducts();
    if (products.isNotEmpty) {
      favoriteProducts.value = products;
    }
    // _stopLoading();
    favoriteProducts.refresh();
    update();
  }

  Future<void> rateProduct(
      {required BuildContext context,
      required int productId,
      required double rate}) async {
    bool status = await _productApiController.rateProduct(
        productId: productId, rate: rate);
    if (status) {
      int index = products.indexWhere((element) => element.id == productId);
      products[index].productRate = rate;
    }
    products.refresh();
    favoriteProducts.refresh();
    update();
  }

  void _startLoading() {
    loading = true;
  }

  void _stopLoading() {
    loading = false;
  }

  Product? getProduct(int id) {
    int index = products.indexWhere((element) => element.id == id);
    if (index != -1) {
      myProduct.value = products[index];
      myProduct.refresh();
      update();
      return myProduct.value!;
    }
    return null;
  }
}
