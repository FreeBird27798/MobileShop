import 'dart:convert';
import 'dart:io';
import 'package:connect_store/mixins/api_mixin.dart';
import 'package:connect_store/mixins/helpers.dart';
import 'package:connect_store/models/base_generic_json_array_respone.dart';
import 'package:connect_store/models/category.dart';
import 'package:connect_store/models/home_json_response.dart';
import 'package:connect_store/models/sub_category.dart';
import 'package:connect_store/storage/preferences/user_pref_controller.dart';
import 'api_settings.dart';

import 'package:http/http.dart' as http;

class CategoryApiController with ApiMixin, Helpers {
  CategoryApiController();

  Future<List<Category>> getCategories() async {
    var response = await http.get(getUrl(ApiSettings.GET_CATEGORIES), headers: {
      HttpHeaders.authorizationHeader: UserPrefController().token,
      ApiSettings.X_Requested_With: ApiSettings.X_Requested_With_VALUE,
    });
    if (isSuccessRequest(response.statusCode)) {
      BaseGenericArrayResponse<Category> categoriesResponse =
          BaseGenericArrayResponse.fromJson(jsonDecode(response.body));
      return categoriesResponse.list;
    } else if (response.statusCode != 500) {
      var message = jsonDecode(response.body)['message'];
      print('STATUS CODE : $message');
      // showSnackBar(context: context, message: message);
    } else {
      // handleServerError(context);
    }
    print('STATUS CODE : ${response.statusCode}');
    return [];
  }

  Future<List<SubCategory>> getSubCategories({required int id}) async {
    var response =
        await http.get(getUrl(ApiSettings.GET_CATEGORIES + '/$id'), headers: {
      HttpHeaders.authorizationHeader: UserPrefController().token,
      ApiSettings.X_Requested_With: ApiSettings.X_Requested_With_VALUE,
    });
    if (isSuccessRequest(response.statusCode)) {
      var data = jsonDecode(response.body)['list'] as List;
      List<SubCategory> subCategories =
          data.map((e) => SubCategory.fromJson(e)).toList();
      return subCategories;
    }
    return [];
  }

  Future getHomePage() async {
    var response = await http.get(getUrl(ApiSettings.GET_HOME), headers: {
      HttpHeaders.authorizationHeader: UserPrefController().token,
      ApiSettings.ACCEPT: ApiSettings.ACCEPT_VALUE,
    });
    if (isSuccessRequest(response.statusCode)) {
      var jsonResponse = jsonDecode(response.body);
      var message = jsonResponse['message'];
      var data = jsonResponse['data'];
      print('MESSAGE IS : $message');
      HomeJson home = HomeJson.fromJson(data);
      // showSnackBar(context: context, message: message);
      return [
        home.slider,
        home.categories,
        home.latestProducts,
        home.famousProducts
      ];
    }
    return [];
  }
}
