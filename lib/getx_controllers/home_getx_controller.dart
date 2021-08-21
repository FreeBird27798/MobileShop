import 'package:connect_store/api/category_api_controller.dart';
import 'package:connect_store/models/category.dart';
import 'package:connect_store/models/product.dart';
import 'package:connect_store/models/slider_image.dart';
import 'package:get/get.dart';

class HomeGetxController extends GetxController{
  CategoryApiController _categoryApiController = CategoryApiController();

  int? id;

  RxList<SliderImage> sliders = <SliderImage>[].obs;
  RxList<Category> homeCategories = <Category>[].obs;
  RxList<Product> latestProducts = <Product>[].obs;
  RxList<Product> famousProducts = <Product>[].obs;


  static HomeGetxController get to => Get.find();



  bool loading = false;

  @override
  void onInit() {
    getHome();
    super.onInit();
  }


  Future<void> getHome() async {
    _startLoading();
    List homeList = await _categoryApiController.getHomePage();
    if (homeList.isNotEmpty) {
      sliders.value = homeList[0];
      homeCategories.value = homeList[1];
      latestProducts.value = homeList[2];
      famousProducts.value = homeList[3];
    }
    _stopLoading();
    sliders.refresh();
    homeCategories.refresh();
    latestProducts.refresh();
    famousProducts.refresh();
  }

  void _startLoading() {
    loading = true;
  }

  void _stopLoading() {
    loading = false;
  }
}