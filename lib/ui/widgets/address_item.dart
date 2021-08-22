import 'package:connect_store/getx_controllers/address_getx_controller.dart';
import 'package:connect_store/models/address.dart';
import 'package:connect_store/ui/screens/address/edit_address_screen.dart';
import 'package:connect_store/utils/app_colors.dart';
import 'package:connect_store/utils/helpers.dart';
import 'package:connect_store/utils/size_config.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'app_text.dart';

class AddressItem extends StatefulWidget  {
  final Address address;
  final void Function() onTap;

  AddressItem({required this.address, required this.onTap});

  @override
  _AddressItemState createState() => _AddressItemState();
}

class _AddressItemState extends State<AddressItem> with Helpers{
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
        clipBehavior: Clip.antiAlias,
        child: Padding(
          padding: EdgeInsetsDirectional.only(
            end: SizeConfig().scaleWidth(16),
            top: SizeConfig().scaleHeight(8),
            bottom: SizeConfig().scaleHeight(8),
          ),
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
                    color: AppColors.APP_GREEN_PRIMARY_COLOR,
                    size: SizeConfig().scaleHeight(30),
                  ),
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppText(
                    text: widget.address.info,
                    fontWeight: FontWeight.bold,
                  ),
                  SizedBox(height: SizeConfig().scaleHeight(5)),
                  AppText(
                    text: widget.address.contactNumber,
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
              IconButton(
                onPressed: () =>
                    Get.to(EditAddressScreen(address: widget.address)),
                icon: Icon(
                  Icons.edit,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        ),
        margin: EdgeInsetsDirectional.only(
          top: SizeConfig().scaleHeight(10),
        ),
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
          // border: widget.address.isSelected
          //     ? Border.all(color: AppColors.APP_GREEN_PRIMARY_COLOR)
          //     : null,
          borderRadius: BorderRadius.all(
            Radius.circular(7),
          ),
        ),
        // height: SizeConfig().scaleHeight(100),
      ),
    );
  }



  Future<void> performDialog(BuildContext context) async {
    bool status = await deleteDialog(context: context);
    if (status) {
      await AddressGetxController.to
          .deleteAddress(context: context, addressId: widget.address.id);
    }
  }
}
