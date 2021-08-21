import 'package:connect_store/api/category_api_controller.dart';
import 'package:connect_store/models/category.dart';
import 'package:connect_store/models/sub_category.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class CategoryGetxController extends GetxController {
  CategoryApiController _categoryApiController = CategoryApiController();
  RxList<Category> categories = <Category>[].obs;
  RxList<SubCategory> subCategories = <SubCategory>[].obs;

  static CategoryGetxController get to => Get.find();

  CategoryGetxController();

  bool loading = false;

  @override
  void onInit() {
    getCategories();
    super.onInit();
  }

  Future<void> getCategories() async {
    _startLoading();
    List<Category> categoriesList =
        await _categoryApiController.getCategories();
    if (categoriesList.isNotEmpty) {
      categories.value = categoriesList;
    }
    _stopLoading();
    categories.refresh();
  }

  Future<void> getSubCategories({required int id}) async {
    _startLoading();
    List<SubCategory> subCategoriesList =
        await _categoryApiController.getSubCategories(id:id);
    if (subCategoriesList.isNotEmpty) {
      subCategories.value = subCategoriesList;
    }
    _stopLoading();
    subCategories.refresh();
  }

  void _startLoading() {
    loading = true;
  }

  void _stopLoading() {
    loading = false;
  }
}
