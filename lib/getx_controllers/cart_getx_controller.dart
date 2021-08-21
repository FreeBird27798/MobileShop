import 'package:connect_store/models/cart.dart';
import 'package:connect_store/storage/database/cart_db_controller.dart';
import 'package:get/get.dart';

class CartGetxController extends GetxController {
  RxList<Cart> cartList = <Cart>[].obs;
  CartDbController dbController = CartDbController();
  RxBool loading = false.obs;

  static CartGetxController get to => Get.find();

  @override
  void onInit() {
    readCartList();
    super.onInit();
  }

  @override
  void onClose() {
    cartList.clear();
    super.onClose();
  }

  Future<void> readCartList() async {
    loading = true.obs;
    cartList.value = await dbController.read();
    update();
    loading = false.obs;
  }

  Future<bool> createCartItem(Cart newCartItem) async {
    loading = true.obs;
    int id = await dbController.create(newCartItem);
    if (id != 0) {
      newCartItem.id = id;
      cartList.add(newCartItem);
      update();
      loading = false.obs;
      return true;
    }
    loading = false.obs;
    return false;
  }

  Future<bool> deleteCartItem(int id) async {
    loading = true.obs;
    bool deleted = await dbController.delete(id);
    if (deleted) {
      cartList.removeWhere((element) => element.id == id);
      update();
      loading = false.obs;
      return true;
    }
    loading = false.obs;
    return deleted;
  }

  Future<bool> deleteAllItems() async {
    bool deleted = await dbController.deleteAllItem();
    if (deleted) {
      cartList.clear();
      update();
      return true;
    }

    return deleted;
  }
}
