import 'dart:convert';
import 'dart:io';
import 'package:connect_store/mixins/api_mixin.dart';
import 'package:connect_store/utils/helpers.dart';
import 'package:connect_store/models/base_generic_json_array_respone.dart';
import 'package:connect_store/models/faq.dart';
import 'package:connect_store/models/user.dart';
import 'package:connect_store/storage/preferences/app_pref_controller.dart';
import 'package:connect_store/storage/preferences/user_pref_controller.dart';
import 'package:flutter/cupertino.dart';
import 'api_settings.dart';

import 'package:http/http.dart' as http;

class UserApiController with ApiMixin, Helpers {
  UserApiController();

  Future<bool> register(
      {required BuildContext context,
      required User user,
      required String password}) async {
    var response = await http.post(getUrl(ApiSettings.REGISTER), body: {
      ApiSettings.NAME: user.name,
      ApiSettings.MOBILE: user.mobile,
      ApiSettings.PASSWORD: password,
      ApiSettings.GENDER: user.gender,
      ApiSettings.STORE_KEY: AppPrefController().storeKey,
      ApiSettings.CITY_ID: user.cityId.toString(),
    });
    if (isSuccessRequest(response.statusCode)) {
      print('SUCCESS CODE FROM SUCCESS : ${response.statusCode}');
      var jsonResponse = jsonDecode(response.body);
      var code = jsonResponse['code'];
      print('CODE IS : $code');
      showSnackBar(context: context, message: 'Your Code is: $code');
      return true;
    } else if (response.statusCode != 500) {
      showMessage(context, response, error: true);
    } else {
      handleServerError(context);
    }
    return false;
  }

  Future<bool> activateAccount(
      {required BuildContext context,
      required String mobile,
      required String code}) async {
    var response = await http.post(getUrl(ApiSettings.ACTIVATE), body: {
      ApiSettings.MOBILE: mobile,
      ApiSettings.CODE: code,
    }, headers: {
      ApiSettings.LANG: AppPrefController().languageCode
    });
    if (isSuccessRequest(response.statusCode)) {
      var jsonResponse = jsonDecode(response.body);
      var message = jsonResponse['message'];
      print('CODE IS : $code');
      showSnackBar(context: context, message: message);
      return true;
    } else if (response.statusCode != 500) {
      showMessage(context, response, error: true);
    } else {
      handleServerError(context);
    }
    return false;
  }

  Future<User?> login(
      {required BuildContext context,
      required String mobile,
      required String password,
      String? fcmToken}) async {
    var response = await http.post(getUrl(ApiSettings.LOGIN), body: {
      ApiSettings.MOBILE: mobile,
      ApiSettings.PASSWORD: password,
      ApiSettings.FCM_TOKEN: fcmToken,
    }, headers: {
      ApiSettings.LANG: AppPrefController().languageCode
    });
    if (isSuccessRequest(response.statusCode)) {
      var jsonResponse = jsonDecode(response.body);
      var message = jsonResponse['message'];
      var data = jsonResponse['data'];
      print('WE ARE HERE!!!');
      showSnackBar(context: context, message: message);
      User user = User.fromJson(data);
      // print('TOKEN IS: ${UserPrefController().token}');
      user.email = user.email ?? '';
      return user;
    } else if (response.statusCode != 500) {
      print('WE ARE HERE FROM ERROR');
      print('CODE IS : ${response.statusCode}');
      showMessage(context, response, error: true);
    } else {
      handleServerError(context);
    }
    return null;
  }

  Future<bool> logout({required BuildContext context}) async {
    var url = getUrl(ApiSettings.LOGOUT);
    var response = await http.get(url, headers: {
      HttpHeaders.authorizationHeader: UserPrefController().token,
      ApiSettings.LANG: AppPrefController().languageCode,
      ApiSettings.X_Requested_With: ApiSettings.X_Requested_With_VALUE,
    });

    if (response.statusCode != 500) {
      return true;
    } else {
      handleServerError(context);
    }
    return false;
  }

  Future<bool> refreshFCMToken(
      {required BuildContext context, required String fcmToken}) async {
    var response =
        await http.post(getUrl(ApiSettings.REFRESH_FCM_TOKEN), body: {
      ApiSettings.FCM_TOKEN: UserPrefController().user.mobile,
    }, headers: {
      ApiSettings.LANG: AppPrefController().languageCode
    });
    if (isSuccessRequest(response.statusCode)) {
      //TODO:
      var jsonResponse = jsonDecode(response.body);
      var message = jsonResponse['message'];
      showSnackBar(context: context, message: message);
      return true;
    } else if (response.statusCode != 500) {
      showMessage(context, response, error: true);
    } else {
      handleServerError(context);
    }
    return false;
  }

  Future<bool> updateProfile(
      {required BuildContext context, required User updatedUser}) async {
    var response = await http.post(getUrl(ApiSettings.UPDATE_PROFILE), body: {
      ApiSettings.CITY_ID: updatedUser.cityId,
      ApiSettings.NAME: updatedUser.name,
      ApiSettings.GENDER: updatedUser.gender
    }, headers: {
      HttpHeaders.authorizationHeader: UserPrefController().token,
      ApiSettings.LANG: AppPrefController().languageCode,
      ApiSettings.ACCEPT: ApiSettings.ACCEPT_VALUE
    });
    if (isSuccessRequest(response.statusCode)) {
      //TODO:
      var jsonResponse = jsonDecode(response.body);
      var message = jsonResponse['message'];
      showSnackBar(context: context, message: message);
      return true;
    } else if (response.statusCode != 500) {
      showMessage(context, response, error: true);
    } else {
      handleServerError(context);
    }
    return false;
  }

  Future<bool> changePassword(
      {required BuildContext context,
      required String currentPassword,
      required String newPassword}) async {
    var response = await http.post(getUrl(ApiSettings.CHANGE_PASSWORD), body: {
      ApiSettings.CURRENT_PASSWORD: currentPassword,
      ApiSettings.NEW_PASSWORD: newPassword,
      ApiSettings.NEW_PASSWORD_CONFIRMATION: newPassword
    }, headers: {
      HttpHeaders.authorizationHeader: UserPrefController().token,
      ApiSettings.LANG: AppPrefController().languageCode,
      ApiSettings.ACCEPT: ApiSettings.ACCEPT_VALUE
    });
    if (isSuccessRequest(response.statusCode)) {
      //TODO:
      var jsonResponse = jsonDecode(response.body);
      var message = jsonResponse['message'];
      showSnackBar(context: context, message: message);
      return true;
    } else if (response.statusCode != 500) {
      showMessage(context, response, error: true);
    } else {
      handleServerError(context);
    }
    return false;
  }

  Future<bool> forgetPassword(
      {required BuildContext context, required String mobile}) async {
    var response = await http.post(getUrl(ApiSettings.FORGET_PASSWORD), body: {
      ApiSettings.MOBILE: mobile
    }, headers: {
      ApiSettings.LANG: AppPrefController().languageCode,
    });
    if (isSuccessRequest(response.statusCode)) {
      //TODO:
      var jsonResponse = jsonDecode(response.body);
      var code = jsonResponse['code'];
      print('CODE IS : $code');
      showSnackBar(context: context, message: 'Your Code is: $code');
      return true;
    } else if (response.statusCode != 500) {
      print('WE ARE HERE FROM ERROR!!!!!!');
      print(' STATUS CODE IS: ${response.statusCode}');
      // showMessage(context, response, error: true);
    } else {
      handleServerError(context);
    }
    return false;
  }

  Future<bool> resetPassword(
      {required BuildContext context,
      required String code,
      required String mobile,
      required String newPassword}) async {
    var response = await http.post(getUrl(ApiSettings.RESET_PASSWORD), body: {
      ApiSettings.MOBILE: mobile,
      ApiSettings.CODE: code,
      ApiSettings.PASSWORD: newPassword,
      ApiSettings.PASSWORD_CONFIRMATION: newPassword,
    }, headers: {
      ApiSettings.LANG: AppPrefController().languageCode
    });
    if (isSuccessRequest(response.statusCode)) {
      //TODO:
      var jsonResponse = jsonDecode(response.body);
      var message = jsonResponse['message'];
      showSnackBar(context: context, message: message);
      return true;
    } else if (response.statusCode != 500) {
      showMessage(context, response, error: true);
    } else {
      handleServerError(context);
    }
    return false;
  }

  Future<bool> contactRequest(
      {required BuildContext context,
      required String subject,
      required String message}) async {
    var response = await http.post(getUrl(ApiSettings.CONTACT_REQUEST), body: {
      ApiSettings.SUBJECT: subject,
      ApiSettings.MESSAGE: message,
    }, headers: {
      ApiSettings.LANG: AppPrefController().languageCode,
      ApiSettings.X_Requested_With: ApiSettings.X_Requested_With_VALUE,
      HttpHeaders.authorizationHeader: UserPrefController().token
    });
    if (isSuccessRequest(response.statusCode)) {
      var jsonResponse = jsonDecode(response.body);
      var message = jsonResponse['message'];
      showSnackBar(context: context, message: message);
      return true;
    } else if (response.statusCode != 500) {
      showMessage(context, response, error: true);
    } else {
      handleServerError(context);
    }
    return false;
  }

  Future<List<FAQ>> getFAQs() async {
    var response = await http.get(getUrl(ApiSettings.FAQS), headers: {
      ApiSettings.LANG: AppPrefController().languageCode,
      ApiSettings.X_Requested_With: ApiSettings.X_Requested_With_VALUE,
      HttpHeaders.authorizationHeader: UserPrefController().token
    });
    if (isSuccessRequest(response.statusCode)) {
      BaseGenericArrayResponse<FAQ> faqsResponse =
          BaseGenericArrayResponse.fromJson(jsonDecode(response.body));
      return faqsResponse.list;
    }
    return [];
  }
}
