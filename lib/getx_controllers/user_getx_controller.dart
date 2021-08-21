import 'package:connect_store/api/user_api_controller.dart';
import 'package:connect_store/models/faq.dart';
import 'package:connect_store/models/user.dart';
import 'package:connect_store/storage/preferences/app_pref_controller.dart';
import 'package:connect_store/storage/preferences/user_pref_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UserGetxController extends GetxController {
  UserApiController _userApiController = UserApiController();
  RxList<FAQ> faqs = <FAQ>[].obs;

  final User user = UserPrefController().user;

  static UserGetxController get to => Get.find();
  bool loading = false;

  @override
  void onInit() {
    getFAQs();
    super.onInit();
  }

  Future<bool> register(
      {required BuildContext context,
      required User user,
      required String password}) async {
    bool registered = await _userApiController.register(
        context: context, user: user, password: password);
    if (registered) {
      UserPrefController().setIsRegistered(true);
      AppPrefController().setIsFirstTime(false);
      await UserPrefController().save(user: user, password: password);
      return true;
    }

    return false;
  }

  Future<bool> login(
      {required BuildContext context,
      required String mobile,
      required String password,
      String? fcmToken}) async {
    User? user = await _userApiController.login(
        context: context,
        mobile: mobile,
        password: password,
        fcmToken: fcmToken);
    if (user != null) {
      UserPrefController().setIsRegistered(true);
      UserPrefController().setIsActivated(true);
      AppPrefController().setIsFirstTime(false);
      await UserPrefController().save(user: user, password: password);
      return true;
    } else {
      return false;
    }
  }

  Future<bool> activateAccount(
      {required BuildContext context,
      required String mobile,
      required String code}) async {
    bool status = await _userApiController.activateAccount(
        context: context, mobile: mobile, code: code);
    if (status) {
      UserPrefController().setIsActivated(true);
      UserPrefController().setIsRegistered(true);
      return true;
    } else {
      return false;
    }
  }

  Future<bool> logout({required BuildContext context}) async {
    bool loggedOut = await _userApiController.logout(context: context);
    if (loggedOut) {
      UserPrefController().logout();
      return true;
    } else {
      return false;
    }
  }

  Future<bool> updateProfile(
      {required BuildContext context, required User updatedUser}) async {
    bool profileUpdated = await _userApiController.updateProfile(
        context: context, updatedUser: updatedUser);
    if (profileUpdated) {
      return true;
    }
    return false;
  }

  Future<bool> changePassword(
      {required BuildContext context,
      required String currentPassword,
      required String newPassword}) async {
    bool passwordChanged = await _userApiController.changePassword(
        context: context,
        currentPassword: currentPassword,
        newPassword: newPassword);
    if (passwordChanged) {
      return true;
    }
    return false;
  }

  Future<bool> contactRequest(
      {required BuildContext context,
      required String subject,
      required String message}) async {
    return await _userApiController.contactRequest(
        context: context, subject: subject, message: message);
  }

  Future<void> getFAQs() async {
    _startLoading();
    faqs.value = await _userApiController.getFAQs();
    _stopLoading();
    faqs.refresh();
  }

  void _startLoading() {
    loading = true;
  }

  void _stopLoading() {
    loading = false;
  }
}
