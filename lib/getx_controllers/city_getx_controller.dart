import 'package:connect_store/api/city_api_controller.dart';
import 'package:connect_store/models/city.dart';
import 'package:get/get.dart';

class CityGetxController extends GetxController {
  CityApiController _cityApiController = CityApiController();
  RxList<City> cities = <City>[].obs;

  static CityGetxController get to => Get.find();
  bool loading = false;

  @override
  void onInit() {
    getCities();
    super.onInit();
  }

  Future<void> getCities() async {
    cities.value = await _cityApiController.getCities();
    cities.refresh();
  }
}
