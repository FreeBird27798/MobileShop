import 'dart:convert';
import 'package:connect_store/mixins/api_mixin.dart';
import 'package:connect_store/mixins/helpers.dart';
import 'package:connect_store/models/card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'api_settings.dart';


class CardApiController with ApiMixin,Helpers{

  Future<List<MyCard>> getAllCard() async {
    var response = await http.get(getUrl(ApiSettings.PAYMENT_CARDS), headers: requestHeaders);
    if (isSuccessRequest(response.statusCode)) {
      var data = jsonDecode(response.body)['list'] as List;
      List<MyCard> cards = data.map((e) => MyCard.fromJson(e)).toList();
      return cards;
    }
    return [];
  }


  Future<MyCard?> createCard({required BuildContext context
    , required String holderName,
    required String cardNumber,
    required String expDate,
    required String cvv,
    required String type,
  }) async {

    var response = await http.post(
      getUrl(ApiSettings.PAYMENT_CARDS),
      headers: requestHeaders,
      body: {
        ApiSettings.HOLDER_NAME: holderName,
        ApiSettings.CARD_NUMBER: cardNumber,
        ApiSettings.EXP_DATE: expDate,
        ApiSettings.CVV: cvv.toString(),
        ApiSettings.TYPE: type,
      },
    );

    if (isSuccessRequest(response.statusCode)) {
      var jsonObject = jsonDecode(response.body)['object'];
      print('true');
      return MyCard.fromJson(jsonObject);
    }
    else if (response.statusCode != 500) {
      showMessage(context, response, error: true);
    }
    handleServerError(context);
    return null;
  }

  Future<bool> updateCard(
      {required BuildContext context, required MyCard card}) async {
    var response = await http.put(
      getUrl(ApiSettings.PAYMENT_CARDS + '/${card.id}'),
      headers: requestHeaders,
      body: {
        ApiSettings.HOLDER_NAME: card.holderName,
        ApiSettings.CARD_NUMBER: card.cardNumber,
        ApiSettings.EXP_DATE: card.expDate,
        ApiSettings.CVV: card.cvv.toString(),
        ApiSettings.TYPE: card.type,
      },
    );
    if (isSuccessRequest(response.statusCode)) {
      print('STATUS CODE IS ${response.statusCode}');
      var message = jsonDecode(response.body)['message'];
      showSnackBar(context: context, message:message );
      return true;
    } else if (response.statusCode != 500) {
      showMessage(context, response);
      return false;
    }
    handleServerError(context);
    return false;
  }

  Future<bool> deleteCard(
      {required BuildContext context, required cardId}) async {
    var response = await http.delete(
      getUrl(ApiSettings.PAYMENT_CARDS + '/$cardId'),
      headers: requestHeaders,
    );

    if (isSuccessRequest(response.statusCode)) {
      var message = jsonDecode(response.body)['message'];
      showSnackBar(context: context, message:message );
      return true;
    } else if (response.statusCode != 500) {
      showMessage(context, response);
      return false;
    }
    handleServerError(context);
    return false;
  }

}