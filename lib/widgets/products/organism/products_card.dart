//+ FLUTTER
import 'package:ducco_shop/lib_core_domain/domain/env_domain.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

//+ UTILS
import 'package:ducco_shop/utils/colors/colors.dart';
import 'package:ducco_shop/utils/fonts/fonts.dart';

//+ LIB CORE UI
import 'package:ducco_shop/lib_core_ui/ui_buttons/module.dart';

//+ LIB DOMAIN
import 'package:ducco_shop/lib_core_domain/module.dart';
import 'package:ducco_shop/lib_core_domain/lib/pipes/pipes.module.dart';

//+ LIB BLOC
import 'package:ducco_shop/lib_bloc/module.dart';

class ProductCard extends StatelessWidget {
  ProductCard({Key? key, required this.size, required this.product})
      : super(key: key);

  final Size size;
  final Product product;
  int productIndex = -1;

  @override
  Widget build(BuildContext context) {
    final ShoppingCartBloc shoppingCartBloc =
        BlocProvider.of<ShoppingCartBloc>(context);

    return Container(
      decoration: BoxDecoration(
          color: AppColors.gray70Color,
          borderRadius: BorderRadius.circular(10)),
      padding: const EdgeInsets.all(10),
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Positioned(
            top: 100,
            left: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              height: 180,
              decoration: BoxDecoration(
                  color: AppColors.gray50Color,
                  borderRadius: BorderRadius.circular(10)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  const SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    width: size.width - 20,
                    child: Text(
                      product.cardTitleFo,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: AppColors.gray90Color,
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                      ),
                      textAlign: TextAlign.start,
                    ),
                  ),
                  SizedBox(
                    width: size.width - 20,
                    child: Text(
                      product.cardSubTitleFo,
                      style: const TextStyle(
                          color: AppColors.gray90Color,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w200,
                          fontSize: 12,
                          height: 1.5),
                      textAlign: TextAlign.start,
                    ),
                  ),
                  SizedBox(
                    width: size.width - 20,
                    child: Text(
                      '${env.MICROS.PRODUCTS.VARS.CURRENCY_SYMBOL} ${PipesDecimal.unitsToDecimal(product.inventoryPrice, 2)}',
                      style: AppFonts.mainTextHeavy(
                          color: AppColors.black100Color, fontFamily: 'Ubuntu'),
                      textAlign: TextAlign.start,
                    ),
                  ),
                  BlocBuilder<ShoppingCartBloc, ShoppingCartState>(
                      builder: (BuildContext context, ShoppingCartState state) {
                    productIndex = shoppingCartBloc.getProductCart(product)[1];
                    return UIButtonIcon(
                        height: 30,
                        onPressedFunc: productIndex == -1
                            ? () {
                                shoppingCartBloc.addProduct(product, 1);
                              }
                            : null,
                        enabledColor: AppColors.secondary60Color,
                        disabledColor: AppColors.secondary40Color,
                        splashColor: AppColors.gray100Color,
                        iconData: Icons.shopping_cart,
                        textStyle: AppFonts.mainTextHeavy(
                            color: AppColors.black100Color,
                            fontFamily: 'Ubuntu'),
                        text: 'AGREGAR');
                  })
                ],
              ),
            ),
          ),
          Positioned(
            top: 0,
            child: Container(
              width: size.width * 0.30,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: AppColors.gray40Color,
                  width: 2,
                ),
              ),
              child: ClipOval(
                child: FadeInImage(
                    placeholderFit: BoxFit.cover,
                    placeholder: const AssetImage('assets/gifs/loading.gif'),
                    fit: BoxFit.cover,
                    image: NetworkImage(product.cardImgUrlFo)),
              ),
            ),
          )
        ],
      ),
    );
  }
}
