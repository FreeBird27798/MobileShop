import 'package:connect_store/getx_controllers/order_getx_controller.dart';
import 'package:connect_store/ui/widgets/app_text.dart';
import 'package:connect_store/ui/widgets/circular_progress.dart';
import 'package:connect_store/ui/widgets/empty_data.dart';
import 'package:connect_store/ui/widgets/order_item.dart';
import 'package:connect_store/utils/app_colors.dart';
import 'package:connect_store/utils/size_config.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class OrdersScreen extends StatefulWidget {
  const OrdersScreen({Key? key}) : super(key: key);

  @override
  _OrdersScreenState createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  final controller = Get.put(OrderGetxController());

  @override
  void initState() {
    Future.delayed(Duration.zero, () async {
      await OrderGetxController.to.getOrders();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: AppText(
            text: AppLocalizations.of(context)!.orders,
            fontSize: 17,
            fontWeight: FontWeight.w600,
            textColor: AppColors.APP_BLACK_PRIMARY_COLOR),
        automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: Icon(Icons.arrow_back_ios),
        ),
      ),
      body:
          // controller.loading.value
          //     ? CircularProgress()
          //     :
          controller.orders.isNotEmpty
              ? Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: SizeConfig().scaleWidth(30),
                      vertical: SizeConfig().scaleHeight(10)),
                  child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    itemCount: controller.orders.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return OrderItem(
                        order: controller.orders[index],
                      );
                    },
                  ),
                )
              : EmptyData(
                  text: 'No Orders Yet!',
                ),
    );
  }
}
