import 'package:connect_store/getx_controllers/address_getx_controller.dart';
import 'package:connect_store/models/address.dart';
import 'package:connect_store/ui/widgets/address_item.dart';
import 'package:connect_store/ui/widgets/app_text.dart';
import 'package:connect_store/ui/widgets/circular_progress.dart';
import 'package:connect_store/ui/widgets/empty_data.dart';
import 'package:connect_store/utils/app_colors.dart';
import 'package:connect_store/utils/size_config.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


import 'add_address_screen.dart';

class AddressesScreen extends StatelessWidget {
  AddressGetxController controller = Get.put(AddressGetxController());
  final bool fromOrder;

  AddressesScreen({this.fromOrder = false});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      body: GetX<AddressGetxController>(
        builder: (AddressGetxController controller) {
          return controller.loading.value
              ? CircularProgress()
              : controller.addresses.isNotEmpty
                  ? Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: SizeConfig().scaleWidth(30),
                          vertical: SizeConfig().scaleHeight(10)),
                      child: ListView.builder(
                        scrollDirection: Axis.vertical,
                        itemCount: controller.addresses.length,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return AddressItem(
                            address: controller.addresses[index],
                            onTap: () =>
                                popScreen(address: controller.addresses[index]),
                          );
                        },
                      ),
                    )
                  : EmptyData();
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.APP_GREEN_PRIMARY_COLOR,
        onPressed: () {
          Get.to(AddAddressScreen());
        },
        child: Icon(Icons.add),
      ),
    );
  }

  popScreen({required Address address}) {
    if (fromOrder) Get.back(result: address);
  }
}
