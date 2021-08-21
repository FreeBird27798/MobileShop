import 'package:connect_store/getx_controllers/product_getx_controller.dart';
import 'package:connect_store/models/product.dart';
import 'package:connect_store/utils/size_config.dart';
import 'package:connect_store/ui/widgets/empty_data.dart';
import 'package:connect_store/ui/widgets/product_item.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({Key? key}) : super(key: key);

  @override
  _FavoritesScreenState createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  int? _selectedId;
  final controller = Get.put(ProductGetxController());

  // @override
  // void initState() {
  //   Future.delayed(Duration.zero, () async {
  //     await ProductGetxController.to.getFavoriteProducts();
  //   });
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    // controller.getFavoriteProducts();
    return Container(
      child: // controller.loading
          // ? CircularProgress()
          controller.favoriteProducts.isEmpty
              ? EmptyData()
              : GetX<ProductGetxController>(
                  builder: (ProductGetxController controller) {
                  print('Id IS:${controller.favoriteProducts.first.id}');
                  return
                      // controller.loading
                      // ? CircularProgress():
                      GridView.builder(
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 15,
                            mainAxisSpacing: 15,
                            //main = > Vertical
                            childAspectRatio: SizeConfig().scaleWidth(155) /
                                SizeConfig().scaleHeight(270),
                          ),
                          itemCount: controller.favoriteProducts.length,
                          itemBuilder: (context, index) {
                            Product currentProduct =
                                controller.favoriteProducts[index];
                            print(
                                'Id IS:${controller.favoriteProducts.first.id}');
                            return ProductItem(
                              currentProduct: currentProduct,
                              hasMargin: false,
                            );
                          });
                }),
    );
  }
}
