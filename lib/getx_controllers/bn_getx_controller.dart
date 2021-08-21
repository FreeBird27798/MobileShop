import 'package:connect_store/models/bottom_naviation_screen.dart';
import 'package:connect_store/ui/screens/bottom_navigation/cart_screen.dart';
import 'package:connect_store/ui/screens/bottom_navigation/discover_screen.dart';
import 'package:connect_store/ui/screens/bottom_navigation/favorites_screen.dart';
import 'package:connect_store/ui/screens/bottom_navigation/home_screen.dart';
import 'package:connect_store/ui/screens/bottom_navigation/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BnGetxController extends GetxController {
  List<BottomNavigationScreen> _screens = <BottomNavigationScreen>[];
  RxInt currentIndex = 0.obs;

  static BnGetxController get to => Get.find();

  void setupScreens() {
    _screens.add(BottomNavigationScreen(widget: HomeScreen()));
    _screens.add(BottomNavigationScreen(widget: CartScreen()));
    _screens.add(BottomNavigationScreen(widget: OffersScreen()));
    _screens.add(BottomNavigationScreen(widget: FavoritesScreen()));
    _screens.add(BottomNavigationScreen(widget: ProfileScreen()));
  }

  @override
  void onInit() {
    // TODO: implement onInit
    setupScreens();
    super.onInit();
  }

  void changeSelectedIndex({required int index}) {
    currentIndex.value = index;
    currentIndex.refresh();
  }

  Widget get screen => _screens[currentIndex.value].widget;

  // String get title => _screens[currentIndex.value].title;

  int get index => currentIndex.value;
}
