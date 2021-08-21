import 'dart:async';
import 'package:connect_store/getx_controllers/city_getx_controller.dart';
import 'package:connect_store/getx_controllers/user_getx_controller.dart';
import 'package:connect_store/models/city.dart';
import 'package:connect_store/models/user.dart';
import 'package:connect_store/storage/preferences/app_pref_controller.dart';
import 'package:connect_store/ui/screens/auth/activate_account_screen.dart';
import 'package:connect_store/utils/app_colors.dart';
import 'package:connect_store/utils/helpers.dart';
import 'package:connect_store/utils/size_config.dart';
import 'package:connect_store/ui/widgets/app_elevated_button.dart';
import 'package:connect_store/ui/widgets/app_text.dart';
import 'package:connect_store/ui/widgets/app_text_field.dart';
import 'package:connect_store/ui/widgets/phone_text_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/get.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> with Helpers {
  bool _enabledButton = false;

  String? _genderType;
  int? _cityId;
  City? _city;

  // int? _genderGroupValue;

  late TextEditingController _fullNameTextController;
  late TextEditingController _mobileTextController;
  late TextEditingController _cityTextController;
  late TextEditingController _passwordTextController;
  late TextEditingController _confirmPasswordTextController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _fullNameTextController = TextEditingController();
    _mobileTextController = TextEditingController();
    _cityTextController = TextEditingController();
    _passwordTextController = TextEditingController();
    _confirmPasswordTextController = TextEditingController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _fullNameTextController.dispose();
    _mobileTextController.dispose();
    _cityTextController.dispose();
    _passwordTextController.dispose();
    _confirmPasswordTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().designWidth(3.75).designHeight(8.12).init(context);
    // print('VALUE IS :$_value');
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsetsDirectional.only(
            start: SizeConfig().scaleWidth(25),
            end: SizeConfig().scaleWidth(25),
            // top: SizeConfig().scaleHeight(80),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  AppText(
                    text: AppLocalizations.of(context)!.sign_up_first,
                    textColor: Colors.black,
                    fontWeight: FontWeight.w500,
                    fontSize: 40,
                    fontFamily: 'Roboto',
                  ),
                  AppText(
                    text: AppLocalizations.of(context)!.sign_up_second,
                    textColor: AppColors.APP_GREEN_PRIMARY_COLOR,
                    fontWeight: FontWeight.w500,
                    fontSize: 40,
                    fontFamily: 'Roboto',
                  ),
                ],
              ),
              SizedBox(
                height: SizeConfig().scaleHeight(10),
              ),
              AppText(
                text: AppLocalizations.of(context)!.sign_up_title,
                fontSize: 24,
                fontFamily: 'Roboto',
                textColor: AppColors.APP_GREY_PRIMARY_COLOR,
              ),
              SizedBox(
                height: SizeConfig().scaleHeight(70),
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
                    hintText: AppLocalizations.of(context)!.full_name,
                    textEditingController: _fullNameTextController,
                    image: 'ic_user',
                    enablePadding: true,
                    onChanged: (value) => validateForm(),
                  )),
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
                child: PhoneTextField(
                  textEditingController: _mobileTextController,
                  // enablePadding: true,
                ),
              ),
              SizedBox(
                height: SizeConfig().scaleHeight(14),
              ),
              GetX<CityGetxController>(
                  builder: (CityGetxController controller) {
                // List<City> cities = controller.cities.value.toList();
                // print(controller.cities);
                return Container(
                  height: SizeConfig().scaleHeight(60),
                  padding: EdgeInsetsDirectional.only(
                    start: SizeConfig().scaleWidth(15),
                    end: SizeConfig().scaleWidth(15),
                  ),
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
                  child: DropdownButton<City>(
                    value: _city,
                    onChanged: (City? city) {
                      // selectCityId(cityId as int);
                      // print('VALUE IS : $cityName');
                      setState(() {
                        _city = city;
                        _cityId = _city!.id;
                      });

                      print('CITY ID : $_cityId');
                    },
                    items: [
                      for (var itemCity in controller.cities)
                        DropdownMenuItem<City>(
                          value: itemCity,
                          child: AppText(
                            text: AppPrefController().languageCode == 'en'
                                ? itemCity.nameEn
                                : itemCity.nameAr,
                            textColor: AppColors.APP_GREEN_PRIMARY_COLOR,
                          ),
                        ),
                    ],
                    onTap: () {},
                    hint: Text(AppLocalizations.of(context)!.select_a_city),
                  ),
                );
              }),
              SizedBox(
                height: SizeConfig().scaleHeight(14),
              ),
              AppText(
                text: AppLocalizations.of(context)!.gender,
                textColor: AppColors.APP_DARK_GREY_PRIMARY_COLOR,
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
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Expanded(
                      child: RadioListTile<String>(
                          activeColor: AppColors.APP_GREEN_PRIMARY_COLOR,
                          title: Text(AppLocalizations.of(context)!.male),
                          value: 'M',
                          groupValue: _genderType,
                          onChanged: (String? genderType) {
                            setState(() {
                              if (genderType != null)
                                setState(() {
                                  _genderType = genderType;
                                  print('Gender TYPE IS : $_genderType');
                                });
                            });
                          }),
                    ),
                    Expanded(
                        child: RadioListTile<String>(
                            activeColor: AppColors.APP_GREEN_PRIMARY_COLOR,
                            title: Text(AppLocalizations.of(context)!.female),
                            value: 'F',
                            groupValue: _genderType,
                            onChanged: (String? genderType) {
                              if (genderType != null)
                                setState(() {
                                  _genderType = genderType;
                                  print('Gender TYPE IS : $_genderType');
                                });
                            })),
                  ],
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
                    hintText: AppLocalizations.of(context)!.confirm_pass,
                    textEditingController: _confirmPasswordTextController,
                    image: 'ic_pass',
                    enablePadding: true,
                    obscureText: true,
                    onChanged: (value) => validateForm(),
                  )),
              SizedBox(
                height: SizeConfig().scaleHeight(40),
              ),
              AppElevatedButton(
                text: AppLocalizations.of(context)!.sign_up,
                fontSize: 17,
                fontWeight: FontWeight.w600,
                enabled: _enabledButton,
                onPressed: () async => performRegister(),
                backgroundColor: AppColors.GREY_BUTTON_COLOR,
              ),
              SizedBox(
                height: SizeConfig().scaleHeight(90),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AppText(
                    text: AppLocalizations.of(context)!.have_an_account,
                    textColor: AppColors.APP_GREY_PRIMARY_COLOR,
                  ),
                  TextButton(
                    onPressed: () =>
                        Navigator.pushNamed(context, '/login_screen'),
                    child: AppText(
                      text: AppLocalizations.of(context)!.log_in,
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

  bool get isPasswordSet =>
      _passwordTextController.text.isNotEmpty &&
      _confirmPasswordTextController.text.isNotEmpty;

  bool get isPasswordConfirmed =>
      _passwordTextController.text == _confirmPasswordTextController.text;

  bool get isMobileSet => _mobileTextController.text.isNotEmpty;

  bool get isValidMobile => _mobileTextController.text.length == 9;

  void validateForm() {
    updateEnableStatus(checkData());
  }

  void updateEnableStatus(bool status) {
    setState(() {
      _enabledButton = status;
    });
  }

  bool checkData() {
    return _fullNameTextController.text.isNotEmpty &&
        isMobileSet &&
        isValidMobile &&
        _cityId != null &&
        _genderType != null &&
        isPasswordSet &&
        isPasswordConfirmed;
  }

  void performRegister() async {
    if (_enabledButton) {
      await register();
    }
  }

  Future<void> register() async {
    bool registered = await UserGetxController().register(
        context: context, user: user, password: _passwordTextController.text);
    if (registered) {
      navigateToActivateAccountScreen();
    }
  }

  void navigateToActivateAccountScreen() {
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) =>
                ActivateAccountScreen(mobile: _mobileTextController.text)));
  }

  User get user {
    User user = User();
    user.name = _fullNameTextController.text;
    user.mobile = _mobileTextController.text;
    user.gender = _genderType.toString();
    user.cityId = _city!.id;
    return user;
  }
}
