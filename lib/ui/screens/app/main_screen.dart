import 'package:connect_store/getx_controllers/bn_getx_controller.dart';
import 'package:connect_store/getx_controllers/home_getx_controller.dart';
import 'package:connect_store/getx_controllers/product_getx_controller.dart';
import 'package:connect_store/ui/screens/category/category_screen.dart';
import 'package:connect_store/utils/app_colors.dart';
import 'package:connect_store/utils/size_config.dart';
import 'package:connect_store/ui/widgets/app_text.dart';
import 'package:connect_store/ui/widgets/bottom_navigation_bar_icon.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  late String _title;

  ProductGetxController _productGetxController =
      Get.put(ProductGetxController());

  @override
  void initState() {
    Get.put(HomeGetxController());
    Future.delayed(Duration.zero, () async {
      await _productGetxController.getFavoriteProducts();
      await _productGetxController.getProductsOffer();
      setTitle(0);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().designWidth(3.75).designHeight(8.12).init(context);
    setTitle(0);
    return GetX(
      init: BnGetxController(),
      builder: (BnGetxController controller) {
        return Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: AppColors.MAIN_BACKGROUND_COLOR,
          appBar: AppBar(
            elevation: 0,
            backgroundColor: AppColors.MAIN_BACKGROUND_COLOR,
            centerTitle: true,
            title: AppText(
              text: _title,
              fontSize: 17,
              fontWeight: FontWeight.w600,
            ),
            leading: Visibility(
              visible: controller.index != 4,
              child: IconButton(
                  tooltip: AppLocalizations.of(context)!.category,
                  onPressed: () => navigateToCategoryScreen(),
                  icon: Icon(Icons.grid_view_rounded)),
            ),
            actions: [
              Visibility(
                visible: controller.index != 4,
                child: IconButton(
                  onPressed: () {},
                  // onPressed: () =>
                  //     Navigator.pushNamed(context, '/settings_screen'),
                  icon: Icon(Icons.notifications_none),
                ),
              ),
              // Visibility(
              //   visible: controller.index == 2,
              //   child: IconButton(
              //     onPressed: () {
              //       Navigator.pushNamed(context, '/cart_screen');
              //       // print('ADD NEW CATEGORY');
              //     },
              //     icon: Icon(Icons.shopping_cart_outlined),
              //   ),
              // ),
            ],
          ),
          body: Padding(
            padding: EdgeInsetsDirectional.only(
              top: SizeConfig().scaleHeight(25),
              // bottom: SizeConfig().scaleHeight(25),
              start: SizeConfig().scaleWidth(25),
              end: SizeConfig().scaleWidth(25),
            ),
            child: controller.screen,
          ),
          bottomNavigationBar: Container(
            clipBehavior: Clip.antiAlias,
            decoration: BoxDecoration(
              color: AppColors.APP_GREEN_PRIMARY_COLOR.withOpacity(0.3),
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(20),
                topLeft: Radius.circular(20),
              ),
            ),
            child: BottomNavigationBar(
              onTap: (int currentIndex) {
                setTitle(currentIndex);
                print(currentIndex);
                controller.changeSelectedIndex(index: currentIndex);
              },
              backgroundColor: Colors.white,
              currentIndex: controller.index,
              type: BottomNavigationBarType.fixed,
              selectedItemColor: Colors.white,
              showSelectedLabels: false,
              showUnselectedLabels: false,
              selectedLabelStyle: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: SizeConfig().scaleWidth(10),
              ),
              unselectedItemColor: AppColors.APP_GREY_PRIMARY_COLOR,
              unselectedLabelStyle: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: SizeConfig().scaleWidth(10),
              ),
              items: [
                BottomNavigationBarItem(
                  icon: BottomNavigationBarIcon(
                      controller.index, 0, Icons.home_outlined),
                  label: AppLocalizations.of(context)!.home,
                ),
                BottomNavigationBarItem(
                  icon: BottomNavigationBarIcon(
                      controller.index, 1, Icons.shopping_cart_outlined),
                  label: AppLocalizations.of(context)!.cart,
                ),
                BottomNavigationBarItem(
                  icon: BottomNavigationBarIcon(
                      controller.index, 2, Icons.explore_outlined),
                  label: AppLocalizations.of(context)!.discover,
                ),
                BottomNavigationBarItem(
                  icon: BottomNavigationBarIcon(
                      controller.index, 3, Icons.star_border_outlined),
                  label: AppLocalizations.of(context)!.favorites,
                ),
                BottomNavigationBarItem(
                  icon: BottomNavigationBarIcon(
                      controller.index, 4, Icons.person_outline),
                  label: AppLocalizations.of(context)!.profile,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  String setTitle(int selectedItemIndex) {
    setState(() {
      switch (selectedItemIndex) {
        case 0:
          _title = AppLocalizations.of(context)!.home;
          break;
        case 1:
          _title = AppLocalizations.of(context)!.cart;
          break;
        case 2:
          _title = AppLocalizations.of(context)!.discover;
          break;
        case 3:
          _title = AppLocalizations.of(context)!.favorites;
          break;
        case 4:
          _title = AppLocalizations.of(context)!.profile;
          break;
        default:
          _title = AppLocalizations.of(context)!.home;
      }
    });
    return _title;
  }

  void navigateToCategoryScreen() {
    // Navigator.pushNamed(context, '/category_screen');
    Get.to(CategoryScreen());
  }
}
