import 'package:connect_store/getx_controllers/city_getx_controller.dart';
import 'package:connect_store/getx_controllers/user_getx_controller.dart';
import 'package:connect_store/mixins/helpers.dart';
import 'package:connect_store/models/city.dart';
import 'package:connect_store/models/user.dart';
import 'package:connect_store/storage/preferences/app_pref_controller.dart';
import 'package:connect_store/storage/preferences/user_pref_controller.dart';
import 'package:connect_store/ui/screens/auth/password/change_password_screen.dart';
import 'package:connect_store/ui/widgets/app_elevated_button.dart';
import 'package:connect_store/ui/widgets/app_text.dart';
import 'package:connect_store/ui/widgets/app_text_field.dart';
import 'package:connect_store/ui/widgets/phone_text_field.dart';
import 'package:connect_store/ui/widgets/profile_widget.dart';
import 'package:connect_store/utils/app_colors.dart';
import 'package:connect_store/utils/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/get.dart';

class ProfileDetails extends StatefulWidget {
  @override
  _ProfileDetailsState createState() => _ProfileDetailsState();
}

class _ProfileDetailsState extends State<ProfileDetails> with Helpers {
  bool _enabledButton = false;
  bool _disabledFields = true;

  String? _genderType;
  int? _cityId;
  City? _city;

  late TextEditingController _fullNameTextController;
  late TextEditingController _mobileTextController;
  User _user = UserGetxController().user;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _fullNameTextController = TextEditingController(text: _user.name);
    _mobileTextController = TextEditingController(text: _user.mobile);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _fullNameTextController.dispose();
    _mobileTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsetsDirectional.only(
            start: SizeConfig().scaleWidth(25),
            end: SizeConfig().scaleWidth(25),
          ),
          child: Column(
            children: [
              AppText(
                text: AppLocalizations.of(context)!.edit_profile_message,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
              SizedBox(
                height: SizeConfig().scaleHeight(14),
              ),
              ProfileWidget(
                userName: _user.name,
                onPressed: () => enableFields(),
                icon: Icons.edit,
              ),
              Divider(
                color: AppColors.APP_GREY_WHITE_2_COLOR,
                height: SizeConfig().scaleHeight(64),
                thickness: 1,
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
                    readOnly: _disabledFields,
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
                  readOnly: true,
                ),
              ),
              SizedBox(
                height: SizeConfig().scaleHeight(16),
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
                    disabledHint: AppText(text: 'YOUR CITY'),
                    onChanged: _disabledFields
                        ? null
                        : (City? city) {
                            // selectCityId(cityId as int);
                            // print('VALUE IS : $cityName');
                            setState(() {
                              _city = city;
                              _cityId = _city!.id;
                              validateForm();
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
                height: SizeConfig().scaleHeight(16),
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Expanded(
                    child: RadioListTile<String>(
                        activeColor: AppColors.APP_GREEN_PRIMARY_COLOR,
                        title: Text(AppLocalizations.of(context)!.male),
                        value: 'M',
                        groupValue: _genderType,
                        onChanged: _disabledFields
                            ? null
                            : (String? genderType) {
                                setState(() {
                                  if (genderType != null)
                                    setState(() {
                                      _genderType = genderType;
                                      validateForm();
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
                          onChanged: _disabledFields
                              ? null
                              : (String? genderType) {
                                  if (genderType != null)
                                    setState(() {
                                      _genderType = genderType;
                                      validateForm();
                                      print('Gender TYPE IS : $_genderType');
                                    });
                                })),
                ],
              ),
              SizedBox(
                height: SizeConfig().scaleHeight(16),
              ),
              AppElevatedButton(
                text: AppLocalizations.of(context)!.change_pass,
                hasBorder: true,
                textColor: AppColors.APP_GREY_PRIMARY_COLOR,
                borderColor: AppColors.APP_GREY_PRIMARY_COLOR,
                enabled: true,
                backgroundColor: AppColors.APP_GREY_WHITE_COLOR,
                onPressed: () => navigateToChangePasswordScreen(),
              ),
              SizedBox(
                height: SizeConfig().scaleHeight(16),
              ),
              AppElevatedButton(
                text: AppLocalizations.of(context)!.save_changes,
                enabled: _enabledButton,
                onPressed: () async => performUpdateProfile(),
              ),
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

  bool checkData() {
    return _fullNameTextController.text.isNotEmpty &&
        _cityId != null &&
        _genderType != null;
  }

  void performUpdateProfile() async {
    if (_enabledButton) {
      await updateProfile();
    }
  }

  Future<void> updateProfile() async {
    await UserGetxController()
        .updateProfile(context: context, updatedUser: user);
  }

  User get user {
    User user = User();
    user.name = _fullNameTextController.text;
    user.mobile = _mobileTextController.text;
    user.gender = _genderType.toString();
    user.cityId = _city!.id;
    return user;
  }

  void enableFields() {
    setState(() {
      _disabledFields = false;
    });
  }

  void navigateToChangePasswordScreen() {
    Get.to(
        ChangePasswordScreen(currentPassword: UserPrefController().password));
  }
}
