import 'dart:convert';

import 'city.dart';

class User {
  late int id;
  late String name;
  String? email;
  late String mobile;
  late String gender;
  late bool active;
  late bool verified;
  late int cityId;
  late int storeId;
  late String token;
  late String tokenType;
  String? fcmToken;
  late String refreshToken;
  late City city;

  User();

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    mobile = json['mobile'];
    gender = json['gender'];
    active = json['active'];
    verified = json['verified'];
    cityId = json['city_id'];
    storeId = json['store_id'];
    token = json['token'];
    tokenType = json['token_type'];
    fcmToken = json['fcm_token'];
    refreshToken = json['refresh_token'];
    city = json['city'] = City.fromJson(json['city']);
  }

}
