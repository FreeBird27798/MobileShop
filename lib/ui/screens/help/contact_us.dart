import 'package:connect_store/getx_controllers/user_getx_controller.dart';
import 'package:connect_store/mixins/helpers.dart';
import 'package:connect_store/ui/widgets/app_elevated_button.dart';
import 'package:connect_store/ui/widgets/app_text.dart';
import 'package:connect_store/ui/widgets/app_text_field.dart';
import 'package:connect_store/utils/app_colors.dart';
import 'package:connect_store/utils/size_config.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ContactUsScreen extends StatefulWidget {
  @override
  _ContactUsScreenState createState() => _ContactUsScreenState();
}

class _ContactUsScreenState extends State<ContactUsScreen> with Helpers {
  late TextEditingController _subjectEditingController;
  late TextEditingController _messageEditingController;
  bool _buttonEnabled = false;

  @override
  void initState() {
    super.initState();
    _subjectEditingController = TextEditingController();
    _messageEditingController = TextEditingController();
  }

  @override
  void dispose() {
    _subjectEditingController.dispose();
    _messageEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: AppText(
          text: AppLocalizations.of(context)!.contact_us,
          fontSize: 20,
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsetsDirectional.only(
            top: SizeConfig().scaleHeight(50),
            start: SizeConfig().scaleWidth(25),
            end: SizeConfig().scaleWidth(25),
          ),
          child: Column(
            children: [
              AppText(
                text: AppLocalizations.of(context)!.contact_us_message,
                textColor:AppColors.APP_GREEN_PRIMARY_COLOR,
                fontSize: 22,
                textAlign: TextAlign.center,
                fontWeight: FontWeight.normal,
                maxLines: 2,
              ),
              Container(
                height: SizeConfig().scaleHeight(200),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: AppColors.APP_GREEN_PRIMARY_COLOR),
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 20,
                      offset: Offset(0, -10),
                      color: AppColors.APP_BLACK_PRIMARY_COLOR.withOpacity(0.1),
                    ),
                  ],
                  color: Colors.white,
                ),
                margin: EdgeInsetsDirectional.only(
                  top: SizeConfig().scaleHeight(50),
                  bottom: SizeConfig().scaleHeight(30),
                ),
                padding: EdgeInsetsDirectional.only(
                  start: SizeConfig().scaleWidth(10),
                  end: SizeConfig().scaleWidth(10),
                  top: SizeConfig().scaleHeight(20),
                  bottom: SizeConfig().scaleHeight(20),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    AppTextField(
                      onChanged: (v) => validateForm(),
                      textEditingController: _subjectEditingController,
                      hintText: AppLocalizations.of(context)!.subject,
                    ),
                    SizedBox(height: 15),
                    AppTextField(
                      onChanged: (v) => validateForm(),
                      textEditingController: _messageEditingController,
                      hintText: AppLocalizations.of(context)!.message,
                      maxLines: 8,
                    ),
                  ],
                ),
              ),
              AppElevatedButton(
                text: AppLocalizations.of(context)!.send,
                onPressed: () async => await performContactUs(),
                enabled: _buttonEnabled,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future performContactUs() async {
    if (checkData()) {
      await contactUs();
    }
  }

  void validateForm() {
    updateEnableStatus(checkData());
  }

  void updateEnableStatus(bool status) {
    setState(() {
      _buttonEnabled = status;
    });
  }

  bool checkData() {
    if (_subjectEditingController.text.isNotEmpty &&
        _messageEditingController.text.isNotEmpty) {
      return true;
    }
    return false;
  }

  Future contactUs() async {
    bool status = await UserGetxController.to.contactRequest(
        context: context,
        subject: _subjectEditingController.text,
        message: _messageEditingController.text);
    if (status) {
      Get.back();
    }
  }
}
