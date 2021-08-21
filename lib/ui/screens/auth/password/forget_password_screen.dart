import 'package:connect_store/api/user_api_controller.dart';
import 'package:connect_store/ui/screens/auth/password/reset_password_screen.dart';
import 'package:connect_store/utils/app_colors.dart';
import 'package:connect_store/utils/helpers.dart';
import 'package:connect_store/utils/size_config.dart';
import 'package:connect_store/ui/widgets/app_elevated_button.dart';
import 'package:connect_store/ui/widgets/app_text.dart';
import 'package:connect_store/ui/widgets/phone_text_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ForgetPasswordScreen extends StatefulWidget {
  @override
  _ForgetPasswordScreenState createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen>
    with Helpers {
  bool _buttonEnabled = false;
  bool _isHidden = true;
  late TextEditingController _mobileTextController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _mobileTextController = TextEditingController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _mobileTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().designWidth(3.75).designHeight(8.12).init(context);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(Icons.arrow_back_ios),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsetsDirectional.only(
            top: SizeConfig().scaleHeight(100),
            start: SizeConfig().scaleWidth(20),
            end: SizeConfig().scaleWidth(20),
          ),
          child: Column(
            children: [
              AppText(
                text: AppLocalizations.of(context)!.forget_password,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
              SizedBox(
                height: SizeConfig().scaleHeight(16),
              ),
              AppText(
                text: AppLocalizations.of(context)!.reset_pass_message,
                fontSize: 14,
                textColor: AppColors.APP_GREY_PRIMARY_COLOR,
              ),
              SizedBox(
                height: SizeConfig().scaleHeight(24),
              ),
              DecoratedBox(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 20,
                        spreadRadius: 0,
                        offset: Offset(0, 10),
                        color: Colors.black.withOpacity(0.03),
                      ),
                    ]),
                child: PhoneTextField(
                  textEditingController: _mobileTextController,
                  onChanged: (value) => validateForm(),
                  // enablePadding: true,
                ),
              ),
              SizedBox(
                height: SizeConfig().scaleHeight(24),
              ),
              AppElevatedButton(
                enabled: _buttonEnabled,
                text: AppLocalizations.of(context)!.confirm,
                onPressed: () async => await forgetPassword(),
                backgroundColor: AppColors.APP_GREEN_PRIMARY_COLOR,
              ),
            ],
          ),
        ),
      ),
    );
  }

  bool checkData() {
    return _mobileTextController.text.isNotEmpty;
  }

  void validateForm() {
    updateEnableStatus(checkData());
  }

  void updateEnableStatus(bool status) {
    setState(() {
      _buttonEnabled = status;
    });
  }

  Future forgetPassword() async {
    bool status = await UserApiController()
        .forgetPassword(context: context, mobile: _mobileTextController.text);
    if (status) navigateToResetPassword();
  }

  void navigateToResetPassword() {
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) =>
                ResetPasswordScreen(mobile: _mobileTextController.text)));
  }
}
