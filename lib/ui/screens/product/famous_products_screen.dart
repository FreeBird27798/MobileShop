import 'package:connect_store/getx_controllers/home_getx_controller.dart';
import 'package:connect_store/models/product.dart';
import 'package:connect_store/ui/screens/product/product_details_screen.dart';
import 'package:connect_store/utils/size_config.dart';
import 'package:connect_store/ui/widgets/app_text.dart';
import 'package:connect_store/ui/widgets/circular_progress.dart';
import 'package:connect_store/ui/widgets/product_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/get.dart';

class FamousProductsScreen extends StatefulWidget {
  const FamousProductsScreen({Key? key}) : super(key: key);

  @override
  _FamousProductsScreenState createState() => _FamousProductsScreenState();
}

class _FamousProductsScreenState extends State<FamousProductsScreen> {
  int? _selectedId;

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
          text: AppLocalizations.of(context)!.popular_item,
        ),
      ),
      body: Padding(
        padding: EdgeInsetsDirectional.only(
          start: SizeConfig().scaleWidth(25),
          end: SizeConfig().scaleWidth(25),
          top: SizeConfig().scaleHeight(10),
        ),
        child: GetX<HomeGetxController>(
            builder: (HomeGetxController controller) {
          print('Id IS:${controller.famousProducts.first.id}');
          return controller.loading
              ? CircularProgress()
              : GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 15,
                    mainAxisSpacing: 15,
                    //main = > Vertical
                    childAspectRatio: SizeConfig().scaleWidth(155) /
                        SizeConfig().scaleHeight(270),
                  ),
                  itemCount: controller.famousProducts.length,
                  itemBuilder: (context, index) {
                    Product currentProduct = controller.famousProducts[index];
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
                      child: ProductItem(
                        currentProduct: currentProduct,
                        onPressed: () => setIsFavorite(currentProduct),
                        hasMargin: false,
                      ),
                    );
                  });
        }),
      ),
    );
  }

  void setIsFavorite(Product currentProduct) {
    setState(() {
      currentProduct.isFavorite = !currentProduct.isFavorite;
    });
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
