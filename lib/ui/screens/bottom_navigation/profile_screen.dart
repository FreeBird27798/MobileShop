import 'package:connect_store/getx_controllers/user_getx_controller.dart';
import 'package:connect_store/models/user.dart';
import 'package:connect_store/storage/preferences/app_pref_controller.dart';
import 'package:connect_store/ui/profile_details.dart';
import 'package:connect_store/ui/screens/address/addresses_screen.dart';
import 'package:connect_store/ui/screens/help/help_center.dart';
import 'package:connect_store/ui/screens/orders/orders_screen.dart';
import 'package:connect_store/ui/screens/payment_cards/payment_cards_screen.dart';
import 'package:connect_store/ui/widgets/profile_widget.dart';
import 'package:connect_store/utils/app_colors.dart';
import 'package:connect_store/utils/size_config.dart';
import 'package:connect_store/ui/widgets/settings_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/get.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String _lang = AppPrefController().languageCode;
  User _user = UserGetxController().user;

  @override
  Widget build(BuildContext context) {
    return Container(
      // padding: EdgeInsetsDirectional.only(
      //   top: SizeConfig().scaleHeight(33),
      // ),
      child: Column(
        children: [
          ProfileWidget(
            userName: _user.name,
            onPressed: () => navigateToProfileDetailsScreen(),
            icon: Icons.arrow_forward_ios,
          ),
          Divider(
            color: AppColors.APP_GREY_WHITE_2_COLOR,
            height: SizeConfig().scaleHeight(64),
            thickness: 1,
          ),
          SettingsItem(
            text: AppLocalizations.of(context)!.orders,
            onTap: () => navigateToOrdersScreen(),
            icon: Icons.code,
          ),
          SettingsItem(
            text: AppLocalizations.of(context)!.payment_method,
            onTap: () => navigateToPaymentCardsScreen(),
            icon: Icons.payment,
          ),
          SettingsItem(
            text: AppLocalizations.of(context)!.address,
            onTap: () => navigateToAddressesScreen(),
            icon: Icons.location_on_outlined,
          ),
          SettingsItem(
            text: AppLocalizations.of(context)!.lang,
            onTap: () => showLanguageBottomSheet(),
            icon: Icons.language,
          ),
          SettingsItem(
            text: AppLocalizations.of(context)!.help_center,
            onTap: () => navigateToHelpCenterScreen(),
            icon: Icons.help_outline,
          ),
          SettingsItem(
            text: AppLocalizations.of(context)!.log_out,
            onTap: () async => await logout(),
            icon: Icons.logout,
          ),
        ],
      ),
    );
  }

  Future logout() async {
    bool loggedOut = await UserGetxController.to.logout(context: context);
    if (loggedOut) navigateToLoginScreen();
  }

  void navigateToLoginScreen() {
    Get.offAllNamed('/login_screen');
  }

  void navigateToHelpCenterScreen() {
    Get.to(HelpCenterScreen());
  }

  void navigateToOrdersScreen() {
    Get.to(OrdersScreen());
  }

  void navigateToPaymentCardsScreen() {
    Get.to(PaymentCardsScreen());
  }

  void navigateToAddressesScreen() {
    Get.to(AddressesScreen());
  }

  void navigateToProfileDetailsScreen() {
    Get.to(ProfileDetails());
  }

  void showLanguageBottomSheet() {
    showModalBottomSheet(
        isDismissible: true,
        barrierColor: AppColors.APP_BLACK_PRIMARY_COLOR.withOpacity(0.1),
        clipBehavior: Clip.antiAlias,
        context: context,
        builder: (context) {
          return StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
            return Container(
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(20),
                    topLeft: Radius.circular(20),
                  ),
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 18,
                      spreadRadius: 0,
                      offset: Offset(0, 10),
                    )
                  ]),
              child: BottomSheet(
                  onClosing: () {},
                  builder: (context) {
                    return SizedBox(
                      height: SizeConfig().scaleHeight(200),
                      child: ListView(
                        children: [
                          RadioListTile<String>(
                              title: Text("English"),
                              value: 'en',
                              groupValue: _lang,
                              onChanged: (String? value) {
                                setState(() {
                                  if (value != null)
                                    setState(() {
                                      _lang = value;
                                      changeLang(_lang);
                                      Get.back();
                                    });
                                });
                              }),
                          RadioListTile<String>(
                              title: Text("عربي"),
                              value: 'ar',
                              groupValue: _lang,
                              onChanged: (String? value) {
                                if (value != null)
                                  setState(() {
                                    _lang = value;
                                    changeLang(_lang);
                                    Get.back();
                                  });
                              }),
                        ],
                      ),
                    );
                  }),
            );
          });
        });
  }

  void changeLang(String newLocaleLanguage) {
    AppPrefController().setLanguage(newLocaleLanguage);
    Get.updateLocale(Locale(newLocaleLanguage));
  }
}
