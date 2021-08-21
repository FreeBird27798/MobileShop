import 'package:carousel_slider/carousel_slider.dart';
import 'package:connect_store/getx_controllers/cart_getx_controller.dart';
import 'package:connect_store/getx_controllers/product_getx_controller.dart';
import 'package:connect_store/models/cart.dart';
import 'package:connect_store/models/product.dart';
import 'package:connect_store/storage/preferences/app_pref_controller.dart';
import 'package:connect_store/ui/screens/bottom_navigation/cart_screen.dart';
import 'package:connect_store/utils/app_colors.dart';
import 'package:connect_store/utils/size_config.dart';
import 'package:connect_store/ui/widgets/app_elevated_button.dart';
import 'package:connect_store/ui/widgets/app_text.dart';
import 'package:connect_store/ui/widgets/circular_progress.dart';
import 'package:connect_store/ui/widgets/empty_data.dart';
import 'package:connect_store/ui/widgets/favorite_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/get.dart';

class ProductDetailsScreen extends StatefulWidget {
  final int id;

  ProductDetailsScreen({required this.id});

  @override
  _ProductDetailsScreenState createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  final _productGetxController = Get.put(ProductGetxController());
  final _cartGetxController = Get.put(CartGetxController());

  @override
  void initState() {
    Future.delayed(Duration.zero, () async {
      await _productGetxController.getProductDetails(productId: widget.id);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print('ID IS ${widget.id}');
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: false,
        leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: Icon(Icons.arrow_back_ios)),
        actions: [
          IconButton(
            onPressed: () => Get.to(CartScreen(
              withScaffold: true,
            )),
            icon: Icon(Icons.shopping_cart_outlined),
          ),
        ],
      ),
      body: GetX<ProductGetxController>(
        init: ProductGetxController(),
        builder: (ProductGetxController controller) {
          // print(
          //     'SLIDER LENGTH FROM DETAILS: ${controller.productImages.length.toString()}');
          Product product = controller.product.value!;
          return controller.loading
              ? CircularProgress()
              : product != null
                  ? Stack(
                      children: [
                        Padding(
                          padding: EdgeInsetsDirectional.only(
                            start: SizeConfig().scaleWidth(25),
                            end: SizeConfig().scaleWidth(25),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CarouselSlider.builder(
                                  itemCount: controller.productImages.length,
                                  itemBuilder: (context, index, realIndex) {
                                    print('INDEX FROM DETAILS IS : $index');
                                    print(
                                        'REAL INDEX FROM DETAILS IS : $realIndex');
                                    print(
                                        'SLIDER LENGTH FROM DETAILS IS : ${controller.productImages.length}');
                                    // print(
                                    //     'SLIDER LENGTH FROM DETAILS: ${controller.productImages.length.toString()}');
                                    return Container(
                                        alignment: AlignmentDirectional.center,
                                        width: double.infinity,
                                        height: SizeConfig().scaleHeight(414),
                                        margin: EdgeInsets.symmetric(
                                            horizontal: 5.0),
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(6),
                                        ),
                                        child: Image.network(
                                          controller
                                              .productImages[index].imageUrl,
                                          fit: BoxFit.cover,
                                        ));
                                  },
                                  options: CarouselOptions(autoPlay: true)),
                              SizedBox(
                                height: SizeConfig().scaleHeight(15),
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    child: AppText(
                                        textAlign: TextAlign.start,
                                        fontSize: 25,
                                        fontWeight: FontWeight.bold,
                                        text:
                                            AppPrefController().languageCode ==
                                                    'en'
                                                ? product.nameEn
                                                : product.nameAr),
                                  ),
                                  AppText(
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold,
                                      textColor: product.offerPrice != null
                                          ? AppColors.DELETE_COLOR
                                          : AppColors.APP_GREEN_PRIMARY_COLOR,
                                      textDecoration: product.offerPrice != null
                                          ? TextDecoration.lineThrough
                                          : TextDecoration.none,
                                      text: product.price.toString() + '₪'),
                                  SizedBox(
                                    width: SizeConfig().scaleWidth(10),
                                  ),
                                  product.offerPrice != null
                                      ? AppText(
                                          fontSize: 22,
                                          fontWeight: FontWeight.bold,
                                          textColor:
                                              AppColors.APP_GREEN_PRIMARY_COLOR,
                                          text: product.offerPrice.toString() +
                                              '₪')
                                      : SizedBox.shrink(),
                                ],
                              ),
                              SizedBox(
                                height: SizeConfig().scaleHeight(15),
                              ),
                              AppText(
                                  fontSize: 20,
                                  textColor: AppColors.APP_GREY_PRIMARY_COLOR,
                                  fontWeight: FontWeight.w600,
                                  text: AppPrefController().languageCode == 'en'
                                      ? product.subCategory!.nameEn
                                      : product.subCategory!.nameAr),
                              SizedBox(
                                height: SizeConfig().scaleHeight(15),
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  AppText(
                                      maxLines: 4,
                                      textAlign: TextAlign.justify,
                                      fontSize: 18,
                                      textColor:
                                          AppColors.APP_DARK_GREY_PRIMARY_COLOR,
                                      fontWeight: FontWeight.w600,
                                      text: AppPrefController().languageCode ==
                                              'en'
                                          ? product.infoEn
                                          : product.infoAr),
                                  FavoriteIcon(
                                    currentProduct: product,
                                    onPressed: () async =>
                                        await addRemoveToFavorite(product),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        PositionedDirectional(
                          bottom: 0,
                          start: 0,
                          end: 0,
                          child: Container(
                            padding: EdgeInsetsDirectional.only(
                              start: SizeConfig().scaleWidth(25),
                              end: SizeConfig().scaleWidth(25),
                            ),
                            decoration:
                                BoxDecoration(color: Colors.white, boxShadow: [
                              BoxShadow(
                                  blurRadius: 20,
                                  offset: Offset(0, -10),
                                  color: AppColors.APP_BLACK_PRIMARY_COLOR
                                      .withOpacity(0.1))
                            ]),
                            height: SizeConfig().scaleHeight(90),
                            child: Row(
                              children: [
                                FavoriteIcon(
                                  currentProduct: product,
                                  onPressed: () async =>
                                      await addRemoveToFavorite(product),
                                ),
                                SizedBox(
                                  width: SizeConfig().scaleWidth(15),
                                ),
                                Expanded(
                                  child: AppElevatedButton(
                                    text: AppLocalizations.of(context)!
                                        .add_to_cart,
                                    onPressed: () async => await addToCart(),
                                    enabled: true,
                                    backgroundColor:
                                        AppColors.APP_BLACK_PRIMARY_COLOR,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    )
                  : EmptyData();
        },
      ),
    );
  }

  Future addRemoveToFavorite(Product product) async {
    // ProductGetxController.to.favoriteProducts.refresh();
    // setState(() {
    //   widget.currentProduct.isFavorite = !widget.currentProduct.isFavorite;
    // });
    await _productGetxController.addRemoveToFavorite(
        context: context, currentProduct: product);
  }

  Cart get cart {
    Product product = _productGetxController.product.value!;
    Cart cart = Cart();
    cart.imageUrl = product.imageUrl;
    cart.productId = product.id;
    cart.price = product.price;
    cart.nameEn = product.nameEn;
    cart.nameAr = product.nameAr;
    cart.quantity = product.quantity;
    return cart;
  }

  Future addToCart() async {
    bool added = await _cartGetxController.createCartItem(cart);
    if (added) {
      Get.back();
    }
  }
}
