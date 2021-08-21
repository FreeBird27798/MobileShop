import 'package:connect_store/utils/app_colors.dart';
import 'package:flutter/material.dart';

class CircularProgress extends StatelessWidget {
  const CircularProgress({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(
        backgroundColor: Colors.grey,
        valueColor: AlwaysStoppedAnimation(AppColors.APP_GREEN_PRIMARY_COLOR),
      ),
    );
  }
}
