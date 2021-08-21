import 'dart:convert';
import 'dart:io';
import 'package:connect_store/mixins/api_mixin.dart';
import 'package:connect_store/mixins/helpers.dart';
import 'package:connect_store/models/base_generic_json_array_respone.dart';
import 'package:connect_store/models/offer_product.dart';
import 'package:connect_store/models/product.dart';
import 'package:connect_store/storage/preferences/app_pref_controller.dart';
import 'package:connect_store/storage/preferences/user_pref_controller.dart';
import 'api_settings.dart';

import 'package:http/http.dart' as http;

class ProductApiController with ApiMixin, Helpers {
  ProductApiController();

  Future<List<Product>> getProducts({required int id}) async {
    var response =
        await http.get(getUrl(ApiSettings.GET_PRODUCTS + '/$id'), headers: {
      HttpHeaders.authorizationHeader: UserPrefController().token,
      ApiSettings.X_Requested_With: ApiSettings.X_Requested_With_VALUE,
    });
    if (isSuccessRequest(response.statusCode)) {
      var data = jsonDecode(response.body)['list'] as List;
      List<Product> products = data.map((e) => Product.fromJson(e)).toList();
      return products;
    }
    return [];
  }

  Future<Product?> getProductDetails(int productId) async {
    var response = await http.get(
        getUrl(ApiSettings.GET_PRODUCT_DETAILS + '/${productId.toString()}'),
        headers: {
          HttpHeaders.authorizationHeader: UserPrefController().token,
          ApiSettings.X_Requested_With: ApiSettings.X_Requested_With_VALUE
        });
    if (isSuccessRequest(response.statusCode)) {
      // print('SUCCESS CODE FROM SUCCESS : ${response.statusCode}');
      var jsonResponse = jsonDecode(response.body);
      var message = jsonResponse['message'];
      var jsonProduct = jsonResponse['object'];
      print('DETAILS MESSAGE IS :$message');
      Product product = Product.detailsFromJson(jsonProduct);
      return product;
    }

    /*
    *
    *   if (isSuccessRequest(response.statusCode)) {
      var data = jsonDecode(response.body)['object'];
      var productDetails = ProductDetails.fromJson(data);
      return productDetails;
    }
    * */
    return null;
  }

  Future<bool> addRemoveToFavorite(
      {required int productId}) async {
    var url = Uri.parse(ApiSettings.GET_FAVORITE_PRODUCTS);
    var response = await http.post(url, headers: {
      HttpHeaders.authorizationHeader: UserPrefController().token,
      ApiSettings.X_Requested_With: ApiSettings.X_Requested_With_VALUE,
      ApiSettings.LANG: AppPrefController().languageCode
    }, body: {
      ApiSettings.PRODUCT_ID: productId.toString(),
    });
    if (isSuccessRequest(response.statusCode)) {
      var jsonResponse = jsonDecode(response.body);
      var message = jsonResponse['message'];
      // showMessage(context, response);
      print('MESSAGE IS :$message');
      return true;
    } else if (response.statusCode != 500) {
      // showMessage(context, response, error: true);
    } else {
      // handleServerError(context);
    }
    return false;
  }

  Future<bool> rateProduct({
    required int productId,
    required double rate,
  }) async {
    var url = Uri.parse(ApiSettings.GET_FAVORITE_PRODUCTS);
    var response = await http.post(url, headers: {
      HttpHeaders.authorizationHeader: UserPrefController().token,
      ApiSettings.X_Requested_With: ApiSettings.X_Requested_With_VALUE,
      ApiSettings.LANG: AppPrefController().languageCode
    }, body: {
      ApiSettings.PRODUCT_ID: productId.toString(),
      ApiSettings.RATE: rate.toString(),
    });
    if (isSuccessRequest(response.statusCode)) {
      // showMessage(context, response);
      return true;
    } else if (response.statusCode != 500) {
      // showMessage(context, response,error: true);
    } else {
      // handleServerError(context);
    }
    return false;
  }

  Future<List<Product>> getFavoriteProducts() async {
    var url = Uri.parse(ApiSettings.GET_FAVORITE_PRODUCTS);
    var response = await http.get(url, headers: {
      HttpHeaders.authorizationHeader: UserPrefController().token,
      ApiSettings.ACCEPT: ApiSettings.ACCEPT_VALUE
    });
    if (isSuccessRequest(response.statusCode)) {
      var jsonResponse = jsonDecode(response.body);
      var productsJsonArray = jsonResponse['list'] as List;
      if (productsJsonArray.isNotEmpty) {
        return productsJsonArray
            .map((jsonResponse) => Product.favoriteFromJson(jsonResponse))
            .toList();
      }
      // showMessage(context, response);
    } else if (response.statusCode != 500) {
     // showMessage(context, response,error: true);
    } else {
      // handleServerError(context);
    }
    return [];
  }

  Future<List<OfferProduct>> getProductsOffer() async {
    var url = Uri.parse(ApiSettings.GET_OFFERS_PRODUCTS);
    var response = await http.get(url, headers: {
      HttpHeaders.authorizationHeader: UserPrefController().token,
      ApiSettings.X_Requested_With: ApiSettings.X_Requested_With_VALUE,
    });
    if (isSuccessRequest(response.statusCode)) {
      // showMessage(context, response);
      BaseGenericArrayResponse<OfferProduct> offerProductsResponse =
          BaseGenericArrayResponse.fromJson(jsonDecode(response.body));
      return offerProductsResponse.list;
    }
    return [];
  }

}
