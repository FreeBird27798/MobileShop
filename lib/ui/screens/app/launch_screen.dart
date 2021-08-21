import 'package:connect_store/getx_controllers/city_getx_controller.dart';
import 'package:connect_store/getx_controllers/user_getx_controller.dart';
import 'package:connect_store/storage/preferences/app_pref_controller.dart';
import 'package:connect_store/storage/preferences/user_pref_controller.dart';
import 'package:connect_store/ui/screens/app/main_screen.dart';
import 'package:connect_store/utils/size_config.dart';
import 'package:connect_store/ui/widgets/app_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/get.dart';

class LaunchScreen extends StatefulWidget {
  const LaunchScreen({Key? key}) : super(key: key);

  @override
  _LaunchScreenState createState() => _LaunchScreenState();
}

class _LaunchScreenState extends State<LaunchScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration(seconds: 3)).then((value) {
      String route = AppPrefController().isFirstTime
          ? '/on_boarding_screen'
          : UserPrefController().isRegistered
              ? UserPrefController().isActivated
                  ? UserPrefController().isLoggedIn
                      ? '/main_screen'
                      : '/login_screen'
                  : '/activate_account_screen'
              : '/register_screen';

      Get.put(CityGetxController());
      Get.put(UserGetxController());
      // Navigator.pushReplacementNamed(context, route);
      Get.offNamed(route);
    });
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().designWidth(3.75).designHeight(8.12).init(context);
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            SvgPicture.asset('images/launch_logo.svg'),
            SizedBox(
              height: SizeConfig().scaleHeight(32),
            ),
            AppText(
              text: AppLocalizations.of(context)!.app_name.toUpperCase(),
              fontFamily: 'Nova Slim',
              fontSize: 34,
            )
          ],
        ),
      ),
    );
  }
}
