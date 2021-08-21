import 'package:connect_store/api/address_api_controller.dart';
import 'package:connect_store/models/address.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddressGetxController extends GetxController {
  final AddressApiController addressApiController = AddressApiController();
  RxList<Address> addresses = <Address>[].obs;
  RxBool loading = false.obs;

  static AddressGetxController get to => Get.find();

  Future<void> getAddresses() async {
    loading.value = true;
    addresses.value = await addressApiController.getAllAddress();
    loading.value = false;
    update();
  }

  void onInit() {
    super.onInit();
    getAddresses();
    addresses.refresh();
  }

  Future<void> deleteAddress(
      {required BuildContext context, required int addressId}) async {
    loading.value = true;
    bool isDeleted = await addressApiController.deleteAddress(
        addressId: addressId, context: context);
    if (isDeleted) {
      int index = addresses.indexWhere((element) => element.id == addressId);
      addresses.removeAt(index);
    }
    addresses.refresh();
    update();
    loading.value = false;
  }

  Future<bool> updateAddress(
      {required BuildContext context, required Address address}) async {
    bool isUpdated = await addressApiController.updateAddress(
        address: address, context: context);
    if (isUpdated) {
      int index = addresses.indexWhere((element) => element.id == address.id);
      addresses[index].name = address.name;
      addresses[index].info = address.info;
      addresses[index].contactNumber = address.contactNumber;
      addresses[index].lang = address.lang;
      addresses[index].lat = address.lat;
      addresses[index].cityId = address.cityId;
      addresses.refresh();
      update();
      return isUpdated;
    }
    return false;
  }

  Future<bool> createAddress(
      {required BuildContext context, required Address address}) async {
    Address? newAddress = await addressApiController.createAddress(
        context: context, address: address);
    if (newAddress != null) {
      Address addressDetails = Address();
      addressDetails.name = address.name;
      addressDetails.info = address.info;
      addressDetails.contactNumber = address.contactNumber;
      addressDetails.lang = address.lang;
      addressDetails.lat = address.lat;
      addressDetails.cityId = address.cityId;
      addresses.add(addressDetails);
      addresses.refresh();
      update();
      return true;
    }
    return false;
  }
}
