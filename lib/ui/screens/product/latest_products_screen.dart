import 'package:connect_store/getx_controllers/home_getx_controller.dart';
import 'package:connect_store/getx_controllers/product_getx_controller.dart';
import 'package:connect_store/models/product.dart';
import 'package:connect_store/ui/screens/product/product_details_screen.dart';
import 'package:connect_store/utils/size_config.dart';
import 'package:connect_store/ui/widgets/app_text.dart';
import 'package:connect_store/ui/widgets/circular_progress.dart';
import 'package:connect_store/ui/widgets/latest_product_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/get.dart';

class LatestProductsScreen extends StatefulWidget {
  const LatestProductsScreen({Key? key}) : super(key: key);

  @override
  _LatestProductsScreenState createState() => _LatestProductsScreenState();
}

class _LatestProductsScreenState extends State<LatestProductsScreen> {
  int? _selectedId;
  final _productGetxController = Get.put(ProductGetxController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: false,
        leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: Icon(Icons.arrow_back_ios)),
        title: AppText(
          text: AppLocalizations.of(context)!.latest_products,
        ),
      ),
      body: Padding(
        padding: EdgeInsetsDirectional.only(
          start: SizeConfig().scaleWidth(25),
          end: SizeConfig().scaleWidth(25),
          top: SizeConfig().scaleHeight(10),
        ),
        child:
            GetX<HomeGetxController>(builder: (HomeGetxController controller) {
          print('FIRST ITEM Id IS:${controller.latestProducts.first.id}');
          return controller.loading
              ? CircularProgress()
              : ListView.builder(
                  itemCount: controller.latestProducts.length,
                  itemBuilder: (context, index) {
                    Product currentProduct = controller.latestProducts[index];
                    return InkWell(
                      onTap: () async {
                        setState(() {
                          _selectedId = currentProduct.id;
                        });
                        navigateToProductDetailsScreen();
                        // await CategoryGetxController(_selectedId)
                        //     .getSubCategories();
                        // print('SELECTED ID: $_selectedId');
                        // print('WE ARE NOT NUMBERS');
                      },
                      child: LatestProductItem(
                        currentProduct: currentProduct,
                        context: context,
                      ),
                    );
                  });
        }),
      ),
    );
  }

  void navigateToProductDetailsScreen() {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ProductDetailsScreen(id: _selectedId!),
        ));
    print('SELECTED ID NEW!!!!!:$_selectedId');
  }
}
