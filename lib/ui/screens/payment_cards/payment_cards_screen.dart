import 'package:connect_store/getx_controllers/card_getx_controller.dart';
import 'package:connect_store/models/card.dart';
import 'package:connect_store/ui/widgets/app_text.dart';
import 'package:connect_store/ui/widgets/circular_progress.dart';
import 'package:connect_store/ui/widgets/empty_data.dart';
import 'package:connect_store/ui/widgets/my_card_item.dart';
import 'package:connect_store/utils/app_colors.dart';
import 'package:connect_store/utils/size_config.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'create_credit_card.dart';

class PaymentCardsScreen extends StatelessWidget {
  CardGetxController controller = Get.put(CardGetxController());
  final bool fromOrder;

  PaymentCardsScreen({this.fromOrder = false});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: AppText(
            text: AppLocalizations.of(context)!.payment_method,
            fontSize: 17,
            fontWeight: FontWeight.w600,
            textColor: AppColors.APP_BLACK_PRIMARY_COLOR),
        automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: Icon(Icons.arrow_back_ios),
        ),
      ),
      body: GetX<CardGetxController>(
        builder: (CardGetxController controller) {
          return controller.loading.value
              ? CircularProgress()
              : controller.cards.isNotEmpty
                  ? Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: SizeConfig().scaleWidth(30),
                          vertical: SizeConfig().scaleHeight(10)),
                      child: ListView.builder(
                        scrollDirection: Axis.vertical,
                        itemCount: controller.cards.length,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              popScreen(card: controller.cards[index]);
                            },
                            child: MyCardItem(
                              cardId: controller.cards[index].id,
                              expiryDate: controller.cards[index].expDate,
                              flag: false,
                              cardHolderName:
                                  controller.cards[index].holderName,
                              cardNumber: controller.cards[index].cardNumber,
                              cardType: controller.cards[index].type == 'Visa'
                                  ? CardType.visa
                                  : CardType.mastercard,
                            ),
                          );
                        },
                      ),
                    )
                  : EmptyData(text: AppLocalizations.of(context)!.no_cards);
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(CreateCreditCard());
        },
        backgroundColor: AppColors.APP_GREEN_PRIMARY_COLOR,
        child: Icon(Icons.add),
      ),
    );
  }

  popScreen({required MyCard card}) {
    print(fromOrder);
    if (fromOrder) Get.back(result: card);
  }
}
