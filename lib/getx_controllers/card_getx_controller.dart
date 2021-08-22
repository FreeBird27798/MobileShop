import 'package:connect_store/api/card_api_controller.dart';
import 'package:connect_store/models/card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CardGetxController extends GetxController {
  final CardApiController cardApiController = CardApiController();
  RxList<MyCard> cards = <MyCard>[].obs;
  RxBool loading = false.obs;

  static CardGetxController get to => Get.find();

  Future<void> getCards() async {
    loading.value = true;
    cards.value = await cardApiController.getAllCard();
    loading.value = false;
    update();
  }

  void onInit() {
    super.onInit();
    getCards();
    cards.refresh();
  }

  Future<bool> createCard(
      {required BuildContext context, required MyCard card}) async {
    MyCard? newCard = await cardApiController.createCard(
        context: context,
        holderName: card.holderName,
        cardNumber: card.cardNumber,
        expDate: card.expDate,
        cvv: card.cvv.toString(),
        type: card.type);
    if (newCard != null) {
      cards.add(newCard);
      cards.refresh();
      update();
      return true;
    }
    return false;
  }

  Future<bool> updateCard(
      {required BuildContext context, required MyCard card}) async {
    bool? status =
        await cardApiController.updateCard(context: context, card: card);
    if (status) {
      cards.add(card);
      cards.refresh();
      update();
      return true;
    }
    return false;
  }

  Future<bool> deleteCard(
      {required BuildContext context, required int cardId}) async {
    bool? deleted =
        await cardApiController.deleteCard(context: context, cardId: cardId);
    if (deleted) {
      cards.removeWhere((e) => e.id == cardId);
      cards.refresh();
      update();
      return true;
    }
    return false;
  }
}
