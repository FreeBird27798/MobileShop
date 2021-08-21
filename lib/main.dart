import 'package:connect_store/storage/database/db_provider.dart';
import 'package:connect_store/storage/preferences/app_pref_controller.dart';
import 'package:connect_store/storage/preferences/user_pref_controller.dart';
import 'package:connect_store/ui/screens/auth/login_screen.dart';
import 'package:connect_store/ui/screens/auth/activate_account_screen.dart';
import 'package:connect_store/ui/screens/auth/password/forget_password_screen.dart';
import 'package:connect_store/ui/screens/auth/register_screen.dart';
import 'package:connect_store/ui/screens/category/category_screen.dart';
import 'package:connect_store/ui/screens/product/famous_products_screen.dart';
import 'package:connect_store/ui/screens/product/latest_products_screen.dart';
import 'package:connect_store/ui/screens/app/launch_screen.dart';
import 'package:connect_store/ui/screens/app/main_screen.dart';
import 'package:connect_store/ui/screens/on_boarding/on_boarding_screen.dart';
import 'package:connect_store/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/get.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DBProvider().initDatabase();
  await AppPrefController().initSharedPref();
  await UserPrefController().initSharedPref();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();

  // static void changeLanguage({
  //   required BuildContext context,
    // required Locale locale,
  // }) {
    // _MyAppState _myAppState = context.findAncestorStateOfType<_MyAppState>()!;
    // _myAppState.changeLanguage(locale);

  // }
}

class _MyAppState extends State<MyApp> {
  // Locale _appLocale = Locale(AppPrefController().languageCode);
  //
  // void changeLanguage(Locale locale) {
  //   setState(() {
  //     _appLocale = locale;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Open Sans',
        appBarTheme: AppBarTheme(
          elevation: 0,
          centerTitle: true,
          color: Colors.transparent,
          titleTextStyle: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w600,
              color: AppColors.APP_BLACK_PRIMARY_COLOR),
          iconTheme: IconThemeData(
            color: AppColors.APP_BLACK_PRIMARY_COLOR,
          ),
          // textTheme: TextTheme(
          //   headline6: TextStyle(
          //       color: AppColors.APP_DARK_PRIMARY_COLOR,
          //       fontFamily: 'Open Sans',
          //       fontWeight: FontWeight.bold,
          //       fontSize: 20),
          // ),
        ),
        // textButtonTheme: TextButtonThemeData(
        //   style: ButtonStyle(
        //     foregroundColor: MaterialStateProperty.resolveWith(
        //           (states) => AppColors.APP_PRIMARY_COLOR,
        //     ),
        //     textStyle: MaterialStateProperty.all(
        //       TextStyle(
        //         fontFamily: 'Open Sans',
        //       ),
        //     ),
        //   ),
        // ),
        // elevatedButtonTheme: ElevatedButtonThemeData(
        //   style: ButtonStyle(
        //     textStyle: MaterialStateProperty.all(
        //       TextStyle(
        //         fontFamily: 'Open Sans',
        //         fontWeight: FontWeight.bold,
        //       ),
        //     ),
        //   ),
        // ),
        // textTheme: TextTheme(
        //   bodyText2: TextStyle(
        //     fontFamily: 'Open Sans',
        //     color: AppColors.TEXT_COLOR,
        //   ),
        // ),
      ),
      localizationsDelegates: [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate
      ],
      supportedLocales: [
        const Locale('en'),
        const Locale('ar'),
      ],

      // locale: _appLocale,
      initialRoute: '/launch_screen',
      // initialRoute: '/main_screen',
      // initialRoute: '/register_screen',
      routes: {
        '/launch_screen': (context) => LaunchScreen(),
        '/on_boarding_screen': (context) => OnBoardingScreen(),
        '/register_screen': (context) => RegisterScreen(),
        '/login_screen': (context) => LoginScreen(),
        '/activate_account_screen': (context) => ActivateAccountScreen(
              mobile: UserPrefController().user.mobile,
            ),
        '/forget_password_screen': (context) => ForgetPasswordScreen(),
        '/main_screen': (context) => MainScreen(),
        '/category_screen': (context) => CategoryScreen(),
        '/latest_products_screen': (context) => LatestProductsScreen(),
        '/famous_products_screen': (context) => FamousProductsScreen(),
      },
      // theme: ThemeData(
      //   appBarTheme: AppBarTheme(
      //     centerTitle: true,
      //     elevation: 0,
      //     color: Colors.transparent,
      //     iconTheme: IconThemeData(
      //       color: AppColors.APP_DARK_PRIMARY_COLOR,
      //       size: 20,
      //     ),
      //   ),
      // ),
    );
  }
}
