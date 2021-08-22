import 'dart:convert';
import 'dart:io';

import 'package:connect_store/mixins/api_mixin.dart';
import 'package:connect_store/utils/helpers.dart';
import 'package:connect_store/models/base_generic_json_array_respone.dart';
import 'package:connect_store/models/city.dart';
import 'package:flutter/cupertino.dart';
import 'api_settings.dart';

import 'package:http/http.dart' as http;

class CityApiController with ApiMixin, Helpers {
  CityApiController();

  Future<List<City>> getCities() async {
    var url = Uri.parse(ApiSettings.GET_CITIES);
    var response = await http.get(url, headers: {
      ApiSettings.ACCEPT: ApiSettings.ACCEPT_VALUE,
    });
    if (isSuccessRequest(response.statusCode)) {
      // print('SUCCESS CODE FROM SUCCESS : ${response.statusCode}');
      BaseGenericArrayResponse<City> citiesResponse =
          BaseGenericArrayResponse.fromJson(jsonDecode(response.body));
      return citiesResponse.list;
    }
    return [];
  }
}
