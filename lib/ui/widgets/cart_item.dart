import 'package:connect_store/models/cart.dart';
import 'package:connect_store/ui/widgets/app_elevated_button.dart';
import 'package:connect_store/utils/app_colors.dart';
import 'package:connect_store/utils/size_config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import 'app_text.dart';

class CartItem extends StatefulWidget {
  final Cart cart;
  final void Function() onDeleteTap;
  final void Function() onTap;

  CartItem(
      {required this.cart, required this.onTap, required this.onDeleteTap});

  @override
  _CartItemState createState() => _CartItemState();
}

class _CartItemState extends State<CartItem> {
  bool _value = false;
  int _quantity = 1;

  @override
  Widget build(BuildContext context) {
    return Slidable(
      actionPane: SlidableDrawerActionPane(),
      actionExtentRatio: 0.25,
      child: InkWell(
        onTap: widget.onTap,
        child: Stack(
          children: [
            Container(
              margin: EdgeInsets.all(15),
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(18),
                border: _value
                    ? Border.all(color: AppColors.APP_GREEN_PRIMARY_COLOR)
                    : null,
                color: Colors.white,
                boxShadow: <BoxShadow>[
                  BoxShadow(
                    color: Colors.grey,
                    offset: Offset(0, 3),
                    blurRadius: 5,
                    spreadRadius: 0,
                  )
                ],
              ),
              child: Row(
                children: [
                  Image.network(
                    widget.cart.imageUrl,
                    height: SizeConfig().scaleHeight(150),
                    width: SizeConfig().scaleWidth(100),
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          AppText(
                            text: 'Price For 1 Pcs : ${widget.cart.price}',
                            fontWeight: FontWeight.w500,
                          ),
                        ],
                      ),
                      SizedBox(height: 8),
                      AppText(
                        text: 'Quantity: ${widget.cart.quantity} Pcs',
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                      ),
                      SizedBox(height: 8),
                      AppText(
                        text:
                            'Total Price: : ${widget.cart.price * widget.cart.quantity}',
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                      ),
                    ],
                  )
                ],
              ),
            ),
            PositionedDirectional(
              bottom: 15,
              end: 15,
              start: 0,
              child: CheckboxListTile(
                contentPadding: EdgeInsetsDirectional.zero,
                value: _value,
                activeColor: AppColors.APP_GREEN_PRIMARY_COLOR,
                onChanged: (bool? value) {
                  if (value != null)
                    setState(() {
                      _value = value;
                    });
                },
              ),
            ),
          ],
        ),
      ),
      actions: <Widget>[
        IconSlideAction(
          closeOnTap: false,
          color: Colors.transparent,
          iconWidget: Container(
            width: SizeConfig().scaleWidth(44),
            height: SizeConfig().scaleHeight(44),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6),
                color: AppColors.DELETE_COLOR),
            child: Icon(
              Icons.delete_outline,
              color: Colors.white,
            ),
          ),
          onTap: () => widget.onDeleteTap,
        ),
      ],
      secondaryActions: <Widget>[
        IconSlideAction(
          closeOnTap: false,
          color: Colors.transparent,
          iconWidget: Container(
            padding: EdgeInsetsDirectional.only(
              start: SizeConfig().scaleWidth(5),
              end: SizeConfig().scaleWidth(5),
            ),
            decoration: BoxDecoration(
              color: AppColors.APP_GREEN_PRIMARY_COLOR,
              borderRadius: BorderRadius.circular(50),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Expanded(
                  child: IconButton(
                    onPressed: () => _value ? decreaseQuantity() : null,
                    icon: Icon(
                      Icons.remove,
                      color: Colors.white,
                    ),
                    padding: EdgeInsetsDirectional.zero,
                  ),
                ),
                Expanded(
                  child: AppText(
                    text: _quantity.toString(),
                    textColor: Colors.white,
                  ),
                ),
                Expanded(
                    child: IconButton(
                  onPressed: () => _value ? increaseQuantity() : null,
                  icon: Icon(
                    Icons.add,
                    color: Colors.white,
                  ),
                  padding: EdgeInsetsDirectional.zero,
                )),
              ],
            ),
          ),
          onTap: () {},
        ),
      ],
    );
  }

  increaseQuantity() {
    setState(() {
      _quantity += 1;
      widget.cart.quantity = _quantity;
    });
  }

  decreaseQuantity() {
    setState(() {
      if (_quantity != 1) {
        _quantity = _quantity - 1;
        widget.cart.quantity = _quantity;
      }
    });
  }
}
