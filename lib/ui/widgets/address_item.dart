import 'package:connect_store/getx_controllers/address_getx_controller.dart';
import 'package:connect_store/mixins/helpers.dart';
import 'package:connect_store/models/address.dart';
import 'package:connect_store/ui/screens/address/edit_address_screen.dart';
import 'package:connect_store/utils/app_colors.dart';
import 'package:connect_store/utils/size_config.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'app_text.dart';

class AddressItem extends StatelessWidget with Helpers {
  final Address address;
  final void Function() onTap;

  AddressItem({required this.address, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        clipBehavior: Clip.antiAlias,
        margin: EdgeInsetsDirectional.only(top: SizeConfig().scaleHeight(10)),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: Colors.black.withAlpha(25),
              offset: Offset(0, 0),
              blurRadius: 6,
              spreadRadius: 3,
            )
          ],
          borderRadius: BorderRadius.all(
            Radius.circular(7),
          ),
        ),
        height: SizeConfig().scaleHeight(100),
        child: Row(
          children: [
            Padding(
              padding: EdgeInsetsDirectional.only(
                start: SizeConfig().scaleWidth(8),
                end: SizeConfig().scaleWidth(8),
                top: SizeConfig().scaleHeight(8),
                bottom: SizeConfig().scaleHeight(8),
              ),
              child: CircleAvatar(
                backgroundColor: Colors.grey.shade100,
                radius: 30,
                child: Icon(
                  Icons.location_on,
                  color: Colors.red.shade900,
                  size: SizeConfig().scaleHeight(30),
                ),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppText(
                  text: address.info,
                  fontWeight: FontWeight.w500,
                ),
                SizedBox(height: SizeConfig().scaleHeight(5)),
                AppText(
                  text: address.contactNumber,
                  fontWeight: FontWeight.w500,
                ),
              ],
            ),
            Spacer(),
            IconButton(
              icon: Icon(
                Icons.delete,
                color: AppColors.DELETE_COLOR,
              ),
              onPressed: () async => await performDialog(context),
            ),
            Container(
              alignment: AlignmentDirectional.center,
              child: IconButton(
                onPressed: () => Get.to(EditAddressScreen(address: address)),
                icon: Icon(
                  Icons.edit,
                  color: Colors.grey,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<bool> deleteAddressDialog({required BuildContext context}) async {
    bool status = await showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: AppText(
              text: AppLocalizations.of(context)!.dialog_title,
              textAlign: TextAlign.start,
            ),
            content: AppText(
              text: AppLocalizations.of(context)!.dialog_message,
              textAlign: TextAlign.start,
            ),
            actions: [
              TextButton(
                onPressed: () => Get.back(result: false),
                child: AppText(
                  text: AppLocalizations.of(context)!.no,
                ),
              ),
              TextButton(
                onPressed: () => Get.back(result: true),
                child: AppText(
                  text: AppLocalizations.of(context)!.yes,
                ),
              ),
            ],
          );
        });
    return status;
  }

  Future<void> performDialog(BuildContext context) async {
    bool status = await deleteAddressDialog(context: context);
    if (status) {
      await AddressGetxController.to
          .deleteAddress(context: context, addressId: address.id);
    }
  }
}
