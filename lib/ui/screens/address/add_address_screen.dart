import 'package:connect_store/getx_controllers/address_getx_controller.dart';
import 'package:connect_store/mixins/helpers.dart';
import 'package:connect_store/models/address.dart';
import 'package:connect_store/storage/preferences/user_pref_controller.dart';
import 'package:connect_store/ui/widgets/app_elevated_button.dart';
import 'package:connect_store/ui/widgets/app_text.dart';
import 'package:connect_store/ui/widgets/app_text_field.dart';
import 'package:connect_store/ui/widgets/phone_text_field.dart';
import 'package:connect_store/utils/app_colors.dart';
import 'package:connect_store/utils/size_config.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';



class AddAddressScreen extends StatefulWidget {
  @override
  _AddAddressScreenState createState() => _AddAddressScreenState();
}

class _AddAddressScreenState extends State<AddAddressScreen> with Helpers{
  late TextEditingController _nameEditingController;
  late TextEditingController _infoEditingController;
  late TextEditingController _mobileTextController;

  bool _enabledButton = false;


  @override
  void initState() {
    super.initState();
    _nameEditingController = TextEditingController();
    _infoEditingController = TextEditingController();
    _mobileTextController = TextEditingController();
  }

  @override
  void dispose() {
    _nameEditingController.dispose();
    _infoEditingController.dispose();
    _mobileTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: AppText(
            text: AppLocalizations.of(context)!.address,
            fontSize: 17,
            fontWeight: FontWeight.w600,
            textColor: AppColors.APP_BLACK_PRIMARY_COLOR),
        automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: Icon(Icons.arrow_back_ios),
        ),
      ),
      body: ListView(
        padding: EdgeInsets.all(32),
        children: [
          SizedBox(height: SizeConfig().scaleHeight(30)),
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
          SizedBox(height:SizeConfig().scaleHeight(20)),
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
                textEditingController: _nameEditingController,
                image: 'ic_user',
                enablePadding: true,
                onChanged: (value) => validateForm(),
              )),
          SizedBox(height: SizeConfig().scaleHeight(15)),
          Padding(
            child: AppText(text: AppLocalizations.of(context)!.info,textColor: Colors.grey,),
            padding: EdgeInsets.all(10),
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
                hintText:'info : Country, City, Street',
                textEditingController: _infoEditingController,
                image: 'ic_user',
                enablePadding: true,
                onChanged: (value) => validateForm(),
              )),
          SizedBox(height: SizeConfig().scaleHeight(42)),
          AppElevatedButton(
            text: AppLocalizations.of(context)!.add,
            enabled: _enabledButton,
            backgroundColor: AppColors.APP_GREEN_PRIMARY_COLOR,
            fontWeight: FontWeight.bold,
            onPressed: () async {
              await performAdd();
            },
          ),
          SizedBox(
            height: SizeConfig().scaleHeight(170),
          ),
        ],
      ),
    );
  }

  Future<void> performAdd() async {
    if (_enabledButton) {
      await save();
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
  bool checkData() {
    if (
    _nameEditingController.text.isNotEmpty &&
        _infoEditingController.text.isNotEmpty &&
        _mobileTextController.text.isNotEmpty) {
      return true;
    }
    showSnackBar(context:context, message: AppLocalizations.of(context)!.enter_data, error: true);
    return false;
  }

  Future<void> save() async {
    Address address = Address();
    address.name = _nameEditingController.text;
    address.contactNumber = _mobileTextController.text;
    address.info = _infoEditingController.text;
    address.cityId = UserPrefController().user.cityId;
    bool status = await AddressGetxController.to.createAddress(
        context: context,
        address: address
    );
    if (status) {
      Get.back();
    } else {
     showSnackBar(context:context, message: 'error', error: true);
    }
  }
}