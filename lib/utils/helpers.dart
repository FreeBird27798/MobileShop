import 'package:connect_store/ui/widgets/app_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/get.dart';

import 'app_colors.dart';

mixin Helpers {
  void showSnackBar(
      {required BuildContext context,required String message, bool error = false}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: error ? Colors.red : Colors.green,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  Future<bool> deleteDialog({required BuildContext context}) async {
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
                  textColor: AppColors.APP_BLACK_PRIMARY_COLOR,
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextButton(
                onPressed: () => Get.back(result: true),
                child: AppText(
                  text: AppLocalizations.of(context)!.yes,
                  textColor: AppColors.DELETE_COLOR,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          );
        });
    return status;
  }
}
