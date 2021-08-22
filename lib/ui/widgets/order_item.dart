import 'package:connect_store/models/order.dart';
import 'package:connect_store/utils/app_colors.dart';
import 'package:connect_store/utils/size_config.dart';
import 'package:flutter/material.dart';

import 'app_text.dart';

class OrderItem extends StatelessWidget {
  final Order order;

  OrderItem({required this.order});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(15),
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
          Radius.circular(SizeConfig().scaleHeight(10)),
        ),
      ),
      height: SizeConfig().scaleHeight(70),
      child: Row(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppText(
                text: 'Order ID ${order.id}',
                fontWeight: FontWeight.w500,
              ),
              SizedBox(height: SizeConfig().scaleHeight(10)),
              AppText(
                text: 'Total Price: ${order.total}',
                fontWeight: FontWeight.w500,
                textColor: AppColors.APP_BLACK_PRIMARY_COLOR,
              ),
            ],
          ),
          Spacer(),
          Container(
            padding: EdgeInsets.all(SizeConfig().scaleHeight(10)),
            decoration: BoxDecoration(
                borderRadius:
                    BorderRadius.circular(SizeConfig().scaleHeight(10)),
                color: order.status == 'Waiting' ? Colors.red : Colors.green),
            child: AppText(
              text: ' ${order.status}',
            ),
          )
        ],
      ),
    );
  }
}
