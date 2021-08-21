import 'package:connect_store/getx_controllers/product_getx_controller.dart';
import 'package:connect_store/models/offer_product.dart';
import 'package:connect_store/utils/size_config.dart';
import 'package:connect_store/ui/widgets/offer_product_item.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OffersScreen extends StatefulWidget {
  const OffersScreen({Key? key}) : super(key: key);

  @override
  _OffersScreenState createState() => _OffersScreenState();
}

class _OffersScreenState extends State<OffersScreen> {
  final controller = Get.put(ProductGetxController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration.zero, () {
      controller.getProductsOffer();
    });
  }

  @override
  Widget build(BuildContext context) {
    return GetX<ProductGetxController>(
        builder: (ProductGetxController cntroller) {
      // print('FIRST OFFER ID IS:${controller.offerProducts.first.id}');
      return
          // controller.loading
          // ? CircularProgress():
          GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 15,
                mainAxisSpacing: 15,
                //main = > Vertical
                childAspectRatio: SizeConfig().scaleWidth(155) /
                    SizeConfig().scaleHeight(155),
              ),
              itemCount: controller.offerProducts.length,
              itemBuilder: (context, index) {
                OfferProduct currentProduct = controller.offerProducts[index];
                print('FIRST OFFER ID IS:${controller.offerProducts.first.id}');
                return OfferProductItem(
                  currentProduct: currentProduct,
                  hasMargin: false,
                );
              });
    });
    // // controller.loading
    // // ? CircularProgress()
    // controller.offerProducts.isEmpty
    //     ? EmptyData(text: 'No Offers')
    //     :
  }
}
