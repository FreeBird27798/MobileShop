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
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/get.dart';

class EditAddressScreen extends StatefulWidget {
  final Address address;

  EditAddressScreen({required this.address});

  @override
  _EditAddressScreenState createState() => _EditAddressScreenState();
}

class _EditAddressScreenState extends State<EditAddressScreen> with Helpers {
  late TextEditingController _nameEditingController;
  late TextEditingController _infoEditingController;
  late TextEditingController _mobileTextController;

  bool _enabledButton = false;

  @override
  void initState() {
    super.initState();
    _nameEditingController = TextEditingController(text: widget.address.name);
    _infoEditingController = TextEditingController(text: widget.address.info);
    _mobileTextController =
        TextEditingController(text: widget.address.contactNumber);
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
            text: AppLocalizations.of(context)!.edit,
            fontSize: 17,
            fontWeight: FontWeight.w600,
            textColor: AppColors.APP_BLACK_PRIMARY_COLOR),
        automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: Icon(Icons.arrow_back_ios),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: SizeConfig().scaleHeight(30)),
            Padding(
              child: AppText(
                text: 'Phone Number',
                textColor: Colors.grey,
              ),
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
              child: PhoneTextField(
                textEditingController: _mobileTextController,
                // enablePadding: true,
              ),
            ),
            SizedBox(height: SizeConfig().scaleHeight(20)),
            Padding(
              child: AppText(
                text: AppLocalizations.of(context)!.full_name,
                textColor: Colors.grey,
              ),
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
                  hintText: AppLocalizations.of(context)!.full_name,
                  textEditingController: _nameEditingController,
                  image: 'ic_user',
                  enablePadding: true,
                  onChanged: (value) => validateForm(),
                )),
            SizedBox(height: SizeConfig().scaleHeight(15)),
            Padding(
              child: AppText(
                text: 'Info',
                textColor: Colors.grey,
              ),
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
                  hintText: 'info : Country, City, Street',
                  textEditingController: _infoEditingController,
                  image: 'ic_user',
                  enablePadding: true,
                  onChanged: (value) => validateForm(),
                )),
            SizedBox(height: SizeConfig().scaleHeight(42)),
            AppElevatedButton(
              text: AppLocalizations.of(context)!.edit,
              enabled: _enabledButton,
              backgroundColor: AppColors.APP_GREEN_PRIMARY_COLOR,
              fontWeight: FontWeight.bold,
              onPressed: () async {
                await performEdit();
              },
            ),
            SizedBox(
              height: SizeConfig().scaleHeight(170),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> performEdit() async {
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
    if (_nameEditingController.text.isNotEmpty &&
        _infoEditingController.text.isNotEmpty &&
        _mobileTextController.text.isNotEmpty) {
      return true;
    }
    showSnackBar(
        context: context, message: 'Enter Required Fields', error: true);
    return false;
  }

  Future<void> save() async {
    Address address = Address();
    address.id = widget.address.id;
    address.name = _nameEditingController.text;
    address.contactNumber = _mobileTextController.text;
    address.info = _infoEditingController.text;
    address.cityId = UserPrefController().user.cityId;
    bool edited = await AddressGetxController.to
        .updateAddress(context: context, address: address);
    if (edited) {
      Get.back();
    } else {
      showSnackBar(context: context, error: true, message: 'ERROR');
    }
  }
}
