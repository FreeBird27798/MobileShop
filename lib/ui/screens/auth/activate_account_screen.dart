import 'package:connect_store/api/user_api_controller.dart';
import 'package:connect_store/getx_controllers/user_getx_controller.dart';
import 'package:connect_store/utils/app_colors.dart';
import 'package:connect_store/utils/helpers.dart';
import 'package:connect_store/utils/size_config.dart';
import 'package:connect_store/ui/widgets/app_elevated_button.dart';
import 'package:connect_store/ui/widgets/app_text.dart';
import 'package:connect_store/ui/widgets/code_text_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ActivateAccountScreen extends StatefulWidget {
  final String mobile;

  ActivateAccountScreen({required this.mobile});

  @override
  _ActivateAccountScreenState createState() =>
      _ActivateAccountScreenState();
}

class _ActivateAccountScreenState extends State<ActivateAccountScreen>
    with Helpers {
  String _code = '';

  bool _enabledButton = false;

  late TextEditingController _firstCodeTextController;
  late TextEditingController _secondCodeTextController;
  late TextEditingController _thirdCodeTextController;
  late TextEditingController _forthCodeTextController;

  late FocusNode firstFocusNode;
  late FocusNode secondFocusNode;
  late FocusNode thirdFocusNode;
  late FocusNode forthFocusNode;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _firstCodeTextController = TextEditingController();
    _secondCodeTextController = TextEditingController();
    _thirdCodeTextController = TextEditingController();
    _forthCodeTextController = TextEditingController();

    firstFocusNode = FocusNode();
    secondFocusNode = FocusNode();
    thirdFocusNode = FocusNode();
    forthFocusNode = FocusNode();
  }

  @override
  void dispose() {
    // TODO: implement dispose

    _firstCodeTextController.dispose();
    _secondCodeTextController.dispose();
    _thirdCodeTextController.dispose();
    _forthCodeTextController.dispose();

    firstFocusNode.dispose();
    secondFocusNode.dispose();
    thirdFocusNode.dispose();
    forthFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().designWidth(3.75).designHeight(8.12).init(context);
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsetsDirectional.only(
            start: SizeConfig().scaleWidth(20),
            end: SizeConfig().scaleWidth(20),
            top: SizeConfig().scaleWidth(90),
          ),
          child: Column(
            children: [
              CircleAvatar(
                radius: SizeConfig().scaleWidth(101),
                backgroundColor:
                    AppColors.APP_GREEN_PRIMARY_COLOR.withOpacity(0.1),
                child: SvgPicture.asset('images/phone_verify_image.svg'),
              ),
              SizedBox(
                height: SizeConfig().scaleHeight(44),
              ),
              AppText(
                text: AppLocalizations.of(context)!.phone_verification,
                fontSize: 22,
                textColor: Colors.black,
              ),
              SizedBox(
                height: SizeConfig().scaleHeight(16),
              ),
              AppText(
                text: AppLocalizations.of(context)!.phone_verification_message,
                fontSize: 14,
                textColor: AppColors.APP_GREY_PRIMARY_COLOR,
              ),
              SizedBox(
                height: SizeConfig().scaleHeight(33),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CodeTextField(
                      marginEnd: 10,
                      textController: _firstCodeTextController,
                      focusNode: firstFocusNode,
                      onChanged: (String value) {
                        validateForm();
                        if (value.isNotEmpty) {
                          secondFocusNode.requestFocus();
                        }
                      }),
                  CodeTextField(
                      marginEnd: 10,
                      textController: _secondCodeTextController,
                      focusNode: secondFocusNode,
                      onChanged: (String value) {
                        validateForm();
                        if (value.isNotEmpty) {
                          thirdFocusNode.requestFocus();
                        } else {
                          firstFocusNode.requestFocus();
                        }
                      }),
                  CodeTextField(
                      marginEnd: 10,
                      textController: _thirdCodeTextController,
                      focusNode: thirdFocusNode,
                      onChanged: (String value) {
                        validateForm();
                        if (value.isNotEmpty) {
                          forthFocusNode.requestFocus();
                        } else {
                          secondFocusNode.requestFocus();
                        }
                      }),
                  CodeTextField(
                      textController: _forthCodeTextController,
                      focusNode: forthFocusNode,
                      onChanged: (String value) {
                        validateForm();
                        if (value.isEmpty) thirdFocusNode.requestFocus();
                      }),
                ],
              ),
              SizedBox(
                height: SizeConfig().scaleHeight(25),
              ),
              AppElevatedButton(
                text: AppLocalizations.of(context)!.verify_phone,
                enabled: _enabledButton,
                onPressed: () async => await performActivateAccount(),
                backgroundColor: AppColors.APP_GREEN_PRIMARY_COLOR,
              ),
              SizedBox(
                height: SizeConfig().scaleHeight(16),
              ),
              TextButton(
                  onPressed: () {},
                  child: AppText(
                    text: AppLocalizations.of(context)!.edit_phone,
                    fontSize: 11,
                  )),
            ],
          ),
        ),
      ),
    );
  }

  void validateForm() {
    updateEnableStatus(checkData());
  }

  void updateEnableStatus(bool status) {
    setState(() {
      _enabledButton = status;
    });
  }

  Future performActivateAccount() async {
    if (checkData()) {
      await activateAccount();
    }
  }

  bool checkData() {
    return isValidCode();
  }

  bool isValidCode() => code.isNotEmpty && code.length == 4;

  String get code {
    return _code = _firstCodeTextController.text +
        _secondCodeTextController.text +
        _thirdCodeTextController.text +
        _forthCodeTextController.text;
  }

  Future activateAccount() async {
    bool status = await UserGetxController()
        .activateAccount(context: context, mobile: widget.mobile, code: code);
    if (status) navigateToLoginScreen();
  }

  void navigateToLoginScreen() {
    Navigator.pushNamed(context, '/login_screen');
  }
}
