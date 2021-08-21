import 'package:connect_store/getx_controllers/user_getx_controller.dart';
import 'package:connect_store/storage/preferences/app_pref_controller.dart';
import 'package:connect_store/ui/screens/help/contact_us.dart';
import 'package:connect_store/ui/widgets/app_elevated_button.dart';
import 'package:connect_store/ui/widgets/app_text.dart';
import 'package:connect_store/utils/app_colors.dart';
import 'package:connect_store/utils/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/get.dart';

class HelpCenterScreen extends StatefulWidget {
  const HelpCenterScreen({Key? key}) : super(key: key);

  @override
  _HelpCenterScreenState createState() => _HelpCenterScreenState();
}

class _HelpCenterScreenState extends State<HelpCenterScreen> {
  UserGetxController _userGetxController = Get.put(UserGetxController());

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () async {
      await _userGetxController.getFAQs();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          leading: IconButton(
              onPressed: () => Get.back(),
              icon: Icon(Icons.arrow_back_ios)),
          title: AppText(
            text: AppLocalizations.of(context)!.help_center,
            fontSize: 20,
          ),
        ),

        floatingActionButton: FloatingActionButton(
          onPressed: () => navigateToContactUsScreen(),
          child: Icon(
            Icons.chat_bubble,
            color: Colors.white,
            size: 24,
          ),
          backgroundColor: AppColors.APP_GREEN_PRIMARY_COLOR,
        ),
        body: GetX<UserGetxController>(
          builder: (UserGetxController controller) {
            return Padding(
              padding: EdgeInsetsDirectional.only(
                start: SizeConfig().scaleWidth(15),
                end: SizeConfig().scaleWidth(15),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppText(
                    text: AppLocalizations.of(context)!.frequently_asked,
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    textAlign: TextAlign.start,
                  ),
                  SizedBox(
                    height: SizeConfig().scaleHeight(20),
                  ),
                  Expanded(
                    child: ListView.builder(
                        itemCount: controller.faqs.length,
                        itemBuilder: (context, index) {
                          return ExpansionTile(
                            title: AppText(
                              text: AppPrefController().languageCode == 'en'
                                  ? controller.faqs[index].questionEn
                                  : controller.faqs[index].questionAr,
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              textAlign: TextAlign.start,
                            ),
                            children: [
                              Padding(
                                padding: EdgeInsetsDirectional.only(
                                  start: SizeConfig().scaleWidth(15),
                                  end: SizeConfig().scaleWidth(15),
                                  top: SizeConfig().scaleHeight(15),
                                  bottom: SizeConfig().scaleHeight(15),
                                ),
                                child: AppText(
                                  text: AppPrefController().languageCode == 'en'
                                      ? controller.faqs[index].answerEn
                                      : controller.faqs[index].answerAr,
                                  maxLines: 4,
                                  textColor: AppColors.APP_GREEN_PRIMARY_COLOR,
                                ),
                              ),
                            ],
                          );
                        }),
                  ),
                ],
              ),
            );
          },
        ));
  }

  void navigateToContactUsScreen() {
    Get.to(ContactUsScreen());
  }
}
