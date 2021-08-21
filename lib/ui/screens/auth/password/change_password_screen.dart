import 'package:connect_store/api/user_api_controller.dart';
import 'package:connect_store/getx_controllers/user_getx_controller.dart';
import 'package:connect_store/utils/app_colors.dart';
import 'package:connect_store/utils/helpers.dart';
import 'package:connect_store/utils/size_config.dart';
import 'package:connect_store/ui/widgets/app_elevated_button.dart';
import 'package:connect_store/ui/widgets/app_text.dart';
import 'package:connect_store/ui/widgets/app_text_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/get.dart';

class ChangePasswordScreen extends StatefulWidget {
  final String currentPassword;

  ChangePasswordScreen({required this.currentPassword});

  @override
  _ChangePasswordScreenState createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen>
    with Helpers {
  bool _buttonEnabled = false;
  bool _isHidden = true;
  late TextEditingController _codeTextController;
  late TextEditingController _passwordTextController;
  late TextEditingController _confirmPasswordTextController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _codeTextController = TextEditingController();
    _passwordTextController = TextEditingController();
    _confirmPasswordTextController = TextEditingController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _codeTextController.dispose();
    _passwordTextController.dispose();
    _confirmPasswordTextController.dispose();
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
          onPressed: () => Get.back(),
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
                text: AppLocalizations.of(context)!.change_pass,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
              SizedBox(
                height: SizeConfig().scaleHeight(16),
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
                  child: AppTextField(
                    hintText: AppLocalizations.of(context)!.confirm_pass,
                    textEditingController: _confirmPasswordTextController,
                    image: 'ic_pass',
                    enablePadding: true,
                    obscureText: true,
                    onChanged: (value) => validateForm(),
                  )),
              SizedBox(
                height: SizeConfig().scaleHeight(24),
              ),
              AppElevatedButton(
                enabled: _buttonEnabled,
                text: AppLocalizations.of(context)!.confirm,
                onPressed: () async => await changePassword(),
                backgroundColor: AppColors.APP_GREEN_PRIMARY_COLOR,
              ),
            ],
          ),
        ),
      ),
    );
  }

  bool checkData() {
    if (isPasswordSet) {
      if (isPasswordConfirmed) {
        return true;
      }
    }
    return false;
  }

  bool get isPasswordSet {
    return _passwordTextController.text.isNotEmpty &&
        _confirmPasswordTextController.text.isNotEmpty;
  }

  bool get isPasswordConfirmed {
    return _passwordTextController.text == _confirmPasswordTextController.text;
  }

  void validateForm() {
    updateEnableStatus(checkData());
  }

  void updateEnableStatus(bool status) {
    setState(() {
      _buttonEnabled = status;
    });
  }

  Future changePassword() async {
    bool status = await UserGetxController().changePassword(
        context: context,
        currentPassword: widget.currentPassword,
        newPassword: _passwordTextController.text);
    if (status) {
      Get.back();
    }
  }


}
