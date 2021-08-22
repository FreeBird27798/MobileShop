// import 'package:connect_store/getx_controllers/order_getx_controller.dart';
// import 'package:connect_store/ui/widgets/app_text.dart';
// import 'package:connect_store/ui/widgets/circular_progress.dart';
// import 'package:connect_store/ui/widgets/empty_data.dart';
// import 'package:connect_store/ui/widgets/latest_product_item.dart';
// import 'package:connect_store/ui/widgets/sub_category_item.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_gen/gen_l10n/app_localizations.dart';
// import 'package:get/get.dart';
//
// class ShoppingScreen extends StatefulWidget {
//   final int id;
//
//   ShoppingScreen({required this.id});
//
//   @override
//   _ShoppingScreenState createState() => _ShoppingScreenState();
// }
//
// class _ShoppingScreenState extends State<ShoppingScreen> {
//   int? _selectedItemId;
//   bool? _clicked;
//   final controller = Get.put(OrderGetxController());
//
//   // ProductGetxController _productsController = Get.put(ProductGetxController());
//
//   @override
//   void initState() {
//     Future.delayed(Duration.zero, () async {
//       await OrderGetxController.to.getOrders();
//     });
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.transparent,
//         automaticallyImplyLeading: false,
//         leading: IconButton(
//             onPressed: () => Navigator.pop(context),
//             icon: Icon(Icons.arrow_back_ios)),
//         title: AppText(
//           text: AppLocalizations.of(context)!.shop_now,
//         ),
//       ),
//       body: controller.loading.value
//           ? CircularProgress()
//           : controller.orders.isNotEmpty
//               ? Container()
//               : EmptyData(text: 'No Orders Yet!',),
//     );
//   }
//
// // Future getCategoryProducts() async {
// //   await _productsController.getProducts(id: _selectedItemId!);
// // }
// }
