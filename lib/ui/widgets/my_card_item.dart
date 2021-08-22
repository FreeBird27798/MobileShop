import 'package:connect_store/getx_controllers/card_getx_controller.dart';
import 'package:connect_store/utils/helpers.dart';
import 'package:flutter/material.dart';

import 'app_text.dart';

class MyCardItem extends StatefulWidget {
  final String? cardNumber;
  final String? expiryDate;
  final String? cardHolderName;
  final String? cvvCode;
  final bool flag;
  final CardType? cardType;
  final int? cardId;
  final void Function()? onLongPress;

  MyCardItem({
    this.cardNumber,
    this.cardId,
    this.onLongPress,
    this.expiryDate,
    this.cardHolderName,
    this.cvvCode,
    this.cardType,
    this.flag = false,
  });

  @override
  _MyCardItemState createState() => _MyCardItemState();
}

class _MyCardItemState extends State<MyCardItem> with Helpers {
  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    final Orientation orientation = MediaQuery.of(context).orientation;

    return GestureDetector(
      onLongPress: () async => await performDialog(context,widget.cardId!),
      child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              stops: const <double>[0.1, 0.4, 0.7, 0.9],
              colors: <Color>[
                Color(0xff320055).withOpacity(1),
                Color(0xff320055).withOpacity(0.97),
                Color(0xff320055).withOpacity(0.90),
                Color(0xff320055).withOpacity(0.86),
              ],
            ),
          ),
          margin: const EdgeInsets.all(16),
          width: width,
          height:
              (orientation == Orientation.portrait ? height / 4 : height / 2),
          child: widget.flag == false
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Align(
                      alignment: Alignment.topRight,
                      child: Padding(
                          padding: const EdgeInsets.only(
                              left: 16, right: 16, top: 8),
                          child: widget.cardType == null
                              ? Container()
                              : widget.cardType == CardType.visa
                                  ? Image.asset(
                                      'images/visa.png',
                                      width: 50,
                                      height: 50,
                                    )
                                  : Image.asset(
                                      'images/master.png',
                                      width: 50,
                                      height: 50,
                                    )),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 16),
                        child: widget.cardNumber == null
                            ? AppText(
                                text: 'XXXX XXXX XXXX XXXX',
                                textColor: Colors.white,
                                fontFamily: 'Credit Card',
                                fontSize: 16,
                              )
                            : AppText(
                                text: widget.cardNumber!,
                                textColor: Colors.white,
                                fontFamily: 'Credit Card',
                                fontSize: 16,
                              ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 16),
                        child: widget.expiryDate == null
                            ? AppText(
                                text: 'MM/YY',
                                textColor: Colors.white,
                                fontFamily: 'Credit Card',
                                fontSize: 16,
                              )
                            : AppText(
                                text: widget.expiryDate!,
                                textColor: Colors.white,
                                fontFamily: 'Credit Card',
                                fontSize: 16,
                              ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 16, right: 16, bottom: 16),
                        child: widget.cardHolderName == null
                            ? AppText(
                                text: 'CARD HOLDER',
                                textColor: Colors.white,
                                fontFamily: 'Roboto',
                                fontSize: 16,
                              )
                            : AppText(
                                text: widget.cardHolderName!,
                                textColor: Colors.white,
                                fontFamily: 'Credit Card',
                                fontSize: 16,
                              ),
                      ),
                    ),
                  ],
                )
              : Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Expanded(
                      flex: 2,
                      child: Container(
                        margin: const EdgeInsets.only(top: 16),
                        height: 48,
                        color: Colors.black,
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Container(
                        margin: const EdgeInsets.only(top: 16),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Expanded(
                              flex: 9,
                              child: Container(
                                height: 48,
                                color: Colors.white70,
                              ),
                            ),
                            Expanded(
                              flex: 3,
                              child: Container(
                                color: Colors.black,
                                child: Padding(
                                  padding: const EdgeInsets.all(5),
                                  child: AppText(
                                    text: widget.cvvCode == null
                                        ? 'XXX'
                                        : widget.cvvCode!,
                                    maxLines: 1,
                                    textColor: Colors.white,
                                    fontFamily: 'Credit Card',
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Align(
                        alignment: Alignment.bottomRight,
                        child: Padding(
                            padding: const EdgeInsets.only(
                                left: 16, right: 16, bottom: 16),
                            child: widget.cardType == null
                                ? Container()
                                : widget.cardType == CardType.visa
                                    ? Image.asset(
                                        'images/visa.png',
                                        width: 50,
                                        height: 50,
                                      )
                                    : Image.asset(
                                        'images/master.png',
                                        width: 50,
                                        height: 50,
                                      )),
                      ),
                    ),
                  ],
                )),
    );
  }

  Future<void> performDialog(BuildContext context,int cardId) async {
    bool status = await deleteDialog(context: context);
    if (status) {
      await CardGetxController.to
          .deleteCard(context: context, cardId: cardId);
    }
  }
}

enum CardType {
  mastercard,
  visa,
}
