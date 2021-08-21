import 'package:connect_store/utils/size_config.dart';
import 'package:flutter/material.dart';

import 'app_text.dart';

class ProfileWidget extends StatelessWidget {
  final String userName;
  final IconData icon;
  final void Function() onPressed;

  ProfileWidget(
      {required this.userName, required this.icon, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsetsDirectional.all(5),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Row(
        children: [
          Expanded(
            child: Image.asset(
              'images/profile_pic.jpg',
              height: SizeConfig().scaleHeight(80),
            ),
          ),
          Expanded(
            child: AppText(
              text: userName,
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
            flex: 2,
          ),
          IconButton(
            onPressed: onPressed,
            icon: Icon(icon),
          ),
        ],
      ),
    );
  }
}
