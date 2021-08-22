import 'package:connect_store/getx_controllers/cart_getx_controller.dart';
import 'package:connect_store/getx_controllers/order_getx_controller.dart';
import 'package:connect_store/models/address.dart';
import 'package:connect_store/models/card.dart';
import 'package:connect_store/ui/screens/address/addresses_screen.dart';
import 'package:connect_store/ui/screens/payment_cards/payment_cards_screen.dart';
import 'package:connect_store/ui/widgets/app_elevated_button.dart';
import 'package:connect_store/ui/widgets/app_text.dart';
import 'package:connect_store/utils/app_colors.dart';
import 'package:connect_store/utils/size_config.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CreateOrderScreen extends StatefulWidget {
  final String cart;

  CreateOrderScreen({required this.cart});

  @override
  _CreateOrderScreenState createState() => _CreateOrderScreenState();
}

class _CreateOrderScreenState extends State<CreateOrderScreen> {
  final controller = Get.put(OrderGetxController());

  bool isOnline = true;
  Address? address;
  MyCard? card;
  bool _enabledButton = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        title: AppText(text: 'Buy Now', fontSize: 20),
      ),
      body: ListView(
        padding: EdgeInsets.all(SizeConfig().scaleHeight(32)),
        children: [
          GestureDetector(
            onTap: () async {
              Address selectedAddress = await Get.to(AddressesScreen(
                fromOrder: true,
              ));
              setState(() {
                address = selectedAddress;
              });
              validateForm();
            },
            child: Container(
              padding: EdgeInsetsDirectional.only(
                start: SizeConfig().scaleWidth(30),
                end: SizeConfig().scaleWidth(10),
              ),
              alignment: AlignmentDirectional.centerStart,
              height: SizeConfig().scaleHeight(50),
              width: double.infinity,
              decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Color(0xFF999999).withAlpha(25),
                      offset: Offset(
                        0,
                        5,
                      ),
                      blurRadius: 10,
                      spreadRadius: 0,
                    ),
                  ],
                  borderRadius: BorderRadius.circular(
                    SizeConfig().scaleHeight(25),
                  ),
                  border: Border.all(color: Colors.grey)),
              child: Row(
                children: [
                  getAddress(),
                  Spacer(),
                  Icon(
                    Icons.keyboard_arrow_down_sharp,
                    color: AppColors.APP_GREEN_PRIMARY_COLOR,
                  )
                ],
              ),
            ),
          ),
          SizedBox(
            height: SizeConfig().scaleHeight(20),
          ),
          GestureDetector(
            onTap: () async {
              MyCard selectedCard = await Get.to(PaymentCardsScreen(
                fromOrder: true,
              ));
              setState(() {
                card = selectedCard;
              });
              validateForm();
            },
            child: Container(
                padding: EdgeInsetsDirectional.only(
                  start: SizeConfig().scaleWidth(30),
                  end: SizeConfig().scaleWidth(10),
                ),
                alignment: AlignmentDirectional.centerStart,
                height: SizeConfig().scaleHeight(50),
                width: double.infinity,
                decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Color(0xFF999999).withAlpha(25),
                        offset: Offset(0, 5),
                        blurRadius: 10,
                        spreadRadius: 0,
                      ),
                    ],
                    borderRadius: BorderRadius.circular(
                      SizeConfig().scaleHeight(25),
                    ),
                    border: Border.all(color: Colors.grey)),
                child: Row(
                  children: [
                    getCard(),
                    Spacer(),
                    Icon(
                      Icons.keyboard_arrow_down_sharp,
                      color: AppColors.APP_GREEN_PRIMARY_COLOR,
                    )
                  ],
                )),
          ),
          SizedBox(
            height: SizeConfig().scaleHeight(20),
          ),
          Row(
            children: [
              Expanded(
                child: CheckboxListTile(
                  checkColor: Colors.white,
                  activeColor: AppColors.APP_GREEN_PRIMARY_COLOR,
                  value: isOnline,
                  onChanged: (var selected) {
                    setState(() {
                      isOnline = true;
                    });
                    validateForm();
                  },
                  title: AppText(
                    text: 'Online',
                  ),
                ),
              ),
              VerticalDivider(
                color: Colors.red,
                width: SizeConfig().scaleWidth(50),
                thickness: 5,
              ),
              Expanded(
                child: CheckboxListTile(
                  checkColor: Colors.white,
                  activeColor: AppColors.APP_GREEN_PRIMARY_COLOR,
                  value: !isOnline,
                  onChanged: (var selected) {
                    setState(() {
                      isOnline = false;
                    });
                    validateForm();
                  },
                  title: AppText(
                    text: 'Offline',
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: SizeConfig().scaleHeight(40),
          ),
          AppElevatedButton(
            text: 'Confirm Order',
            enabled: _enabledButton,
            onPressed: () async => await performOrder(),
          ),
        ],
      ),
    );
  }

  Widget getCard() {
    if (card == null) {
      return AppText(
        text: 'Select Card',
        textColor: Colors.grey,
      );
    } else {
      return AppText(
        text: card!.cardNumber,
        textColor: AppColors.APP_BLACK_PRIMARY_COLOR,
      );
    }
  }

  Widget getAddress() {
    if (address == null) {
      return AppText(
        text: 'Select Address',
        textColor: Colors.grey,
      );
    } else {
      return AppText(
        text: address!.info,
        textColor: AppColors.APP_BLACK_PRIMARY_COLOR,
      );
    }
  }

  void validateForm() {
    updateEnableStatus(checkData());
  }

  void updateEnableStatus(bool status) {
    setState(() {
      _enabledButton = status;
    });
  }

  Future<void> performOrder() async {
    if (_enabledButton) await makeOrder();
  }

  bool checkData() {
    if (card != null && address != null) return true;
    return false;
  }

  Future<void> makeOrder() async {
    bool status = await OrderGetxController.to.createOrder(
      context: context,
      cart: widget.cart,
      paymentType: isOnline ? 'Online' : 'Offline',
      addressId: address!.id,
      cardId: card!.id,
      holderName: card!.holderName,
      cardNumber: card!.cardNumber,
      expDate: card!.expDate,
      cvv: card!.cvv,
      type: card!.type,
    );
    if (status) {
      await CartGetxController.to.deleteAllItems();
      Get.back();
    }
  }
}
