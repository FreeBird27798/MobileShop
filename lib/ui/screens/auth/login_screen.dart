import 'package:connect_store/getx_controllers/user_getx_controller.dart';
import 'package:connect_store/mixins/helpers.dart';
import 'package:connect_store/utils/app_colors.dart';
import 'package:connect_store/utils/size_config.dart';
import 'package:connect_store/ui/widgets/app_elevated_button.dart';
import 'package:connect_store/ui/widgets/app_text.dart';
import 'package:connect_store/ui/widgets/app_text_field.dart';
import 'package:connect_store/ui/widgets/phone_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> with Helpers {
  bool _buttonEnabled = false;

  late TextEditingController _mobileTextController;
  late TextEditingController _passwordTextController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _mobileTextController = TextEditingController();
    _passwordTextController = TextEditingController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _mobileTextController.dispose();
    _passwordTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsetsDirectional.only(
            start: SizeConfig().scaleWidth(25),
            end: SizeConfig().scaleWidth(25),
            top: SizeConfig().scaleHeight(130),
          ),
          child: Column(
            // crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  AppText(
                    text: AppLocalizations.of(context)!.welcome,
                    textColor: Colors.black,
                    fontWeight: FontWeight.w500,
                    fontSize: 30,
                    fontFamily: 'Roboto',
                  ),
                  AppText(
                    text: AppLocalizations.of(context)!.back,
                    textColor: AppColors.APP_GREEN_PRIMARY_COLOR,
                    fontWeight: FontWeight.w500,
                    fontSize: 30,
                    fontFamily: 'Roboto',
                  ),
                ],
              ),
              SizedBox(
                height: SizeConfig().scaleHeight(40),
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
                  // enablePadding: true,
                ),
              ),
              SizedBox(
                height: SizeConfig().scaleHeight(14),
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
                  child: AppTextField(
                    hintText: AppLocalizations.of(context)!.pass,
                    textEditingController: _passwordTextController,
                    image: 'ic_pass',
                    enablePadding: true,
                    obscureText: true,
                    onChanged: (value) => validateForm(),
                  )),
              Container(
                alignment: AlignmentDirectional.centerEnd,
                child: TextButton(
                    onPressed: () => navigateToForgetPasswordScreen(),
                    child: AppText(
                      text: AppLocalizations.of(context)!.forget_password,
                      textAlign: TextAlign.end,
                      fontSize: 12,
                      fontFamily: 'Roboto',
                    )),
              ),
              AppElevatedButton(
                text: AppLocalizations.of(context)!.log_in,
                fontSize: 17,
                fontWeight: FontWeight.w600,
                enabled: _buttonEnabled,
                onPressed: () => performLogin(),
                backgroundColor: AppColors.GREY_BUTTON_COLOR,
              ),
              SizedBox(
                height: SizeConfig().scaleHeight(206),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AppText(
                    text: AppLocalizations.of(context)!.do_not_have_account,
                    textColor: AppColors.APP_GREY_PRIMARY_COLOR,
                  ),
                  TextButton(
                    onPressed: () => navigateToRegisterScreen(),
                    child: AppText(
                      text: AppLocalizations.of(context)!.sign_up,
                      textColor: AppColors.APP_GREEN_PRIMARY_COLOR,
                    ),
                    style: TextButton.styleFrom(padding: EdgeInsets.zero),
                  ),
                ],
              ),
              SizedBox(
                height: SizeConfig().scaleHeight(18),
              ),
            ],
          ),
        ),
      ),
    );
  }

  bool isValidPhone() {
    return _mobileTextController.text.isNotEmpty &&
        _mobileTextController.text.length == 9;
  }

  bool checkData() {
    if (isValidPhone() && _passwordTextController.text.isNotEmpty) {
      return true;
    } else {
      showSnackBar(
          message: 'Phone Must Be 9 digits', error: true, context: context);
      return false;
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

  Future<void> performLogin() async {
    if (checkData()) {
      await login();
    }
  }

  Future<void> login() async {
    bool loggedIn = await UserGetxController.to.login(
        context: context,
        mobile: _mobileTextController.text,
        password: _passwordTextController.text,
        fcmToken: '');
    // print('IS LOGGED IN: $loggedIn');
    if (loggedIn) {
      navigateToMainScreen();
    }
  }

  void navigateToMainScreen() {
    Navigator.of(context).pushNamedAndRemoveUntil(
        '/main_screen', (Route<dynamic> route) => false);
  }

  void navigateToForgetPasswordScreen() {
    Navigator.pushNamed(context, '/forget_password_screen');
  }

  void navigateToRegisterScreen() {
    Navigator.pushNamed(context, '/register_screen');
  }
}
