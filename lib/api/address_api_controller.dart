import 'dart:convert';

import 'package:connect_store/mixins/api_mixin.dart';
import 'package:connect_store/utils/helpers.dart';
import 'package:connect_store/models/address.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

import 'api_settings.dart';

class AddressApiController with ApiMixin, Helpers {
  Future<List<Address>> getAllAddress() async {
    var response =
        await http.get(getUrl(ApiSettings.ADDRESS), headers: requestHeaders);
    if (isSuccessRequest(response.statusCode)) {
      var data = jsonDecode(response.body)['list'] as List;
      List<Address> addresses =
          data.map((e) => Address.fromJson(e)).toList();
      return addresses;
    }
    return [];
  }

  Future<Address?> createAddress(
      {required BuildContext context, required Address address}) async {
    var response = await http.post(
      getUrl(ApiSettings.ADDRESS),
      headers: requestHeaders,
      body: {
        ApiSettings.NAME: address.name,
        ApiSettings.INFO: address.info,
        ApiSettings.CONTACT_NUMBER: address.contactNumber,
        ApiSettings.CITY_ID: address.cityId.toString(),
        ApiSettings.LAT: address.lat ?? '',
        ApiSettings.LANG: address.lang ?? '',
      },
    );
    if (isSuccessRequest(response.statusCode)) {
      var jsonObject = jsonDecode(response.body)['object'];
      return Address.fromJson(jsonObject);
    } else if (response.statusCode != 500) {
      showMessage(context, response, error: true);
    }
    handleServerError(context);
    return null;
  }

  Future<bool> updateAddress(
      {required BuildContext context, required Address address}) async {
    var response = await http.put(
      getUrl(ApiSettings.ADDRESS + '/${address.id}'),
      headers: requestHeaders,
      body: {
        ApiSettings.NAME: address.name,
        ApiSettings.INFO: address.info,
        ApiSettings.CONTACT_NUMBER: address.contactNumber,
        ApiSettings.CITY_ID: address.cityId.toString(),
        ApiSettings.LAT: address.lat ?? '',
        ApiSettings.LANG: address.lang ?? '',
      },
    );
    if (isSuccessRequest(response.statusCode)) {
      print('STATUS CODE IS ${response.statusCode}');
      return true;
    } else if (response.statusCode != 500) {
      showMessage(context, response);
      return false;
    }
    handleServerError(context);
    return false;
  }

  Future<bool> deleteAddress(
      {required BuildContext context, required addressId}) async {
    var response = await http.delete(
      getUrl(ApiSettings.ADDRESS + '/$addressId'),
      headers: requestHeaders,
    );

    if (isSuccessRequest(response.statusCode)) {
      return true;
    } else if (response.statusCode != 500) {
      showMessage(context, response);
      return false;
    }
    handleServerError(context);
    return false;
  }
}
