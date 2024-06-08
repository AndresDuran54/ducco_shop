//+ FLUTTER
import 'package:ducco_shop/lib_core_domain/domain/env_domain.dart';
import 'package:ducco_shop/lib_core_domain/lib/pipes/pipes.module.dart';
import 'package:ducco_shop/lib_core_ui/ui_toast/module.dart';
import 'package:ducco_shop/lib_shares/services/toast.confirm.service.dart';
import 'package:ducco_shop/utils/colors/colors.dart';
import 'package:ducco_shop/utils/fonts/fonts.dart';
import 'package:flutter/material.dart';

//+ LIB BLOC
import 'package:ducco_shop/lib_bloc/module.dart';

//+ DEPENDENCIES
import 'package:provider/provider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

//+ LIB CORE SDKS
import 'package:ducco_shop/lib_shares/services/providers/module.dart';

//+ LIB CORE UI
import 'package:ducco_shop/lib_core_ui/ui_buttons/module.dart';
import 'package:ducco_shop/lib_core_ui/ui_cards/module.dart';

class ScreenProducts extends StatelessWidget {
  const ScreenProducts({super.key});

  @override
  Widget build(BuildContext context) {
    final navigationModel = Provider.of<NavigationModel>(context);
    final Size size = MediaQuery.of(context).size;

    return Padding(
      padding: const EdgeInsets.all(12),
      child: Stack(children: <Widget>[
        BlocBuilder<ShoppingCartBloc, ShoppingCartState>(
            builder: (BuildContext context, ShoppingCartState state) {
          if (state is ShoppingCartEmptyState) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 80),
              child: Center(
                child: Image.asset(
                    'assets/images/modules/shopping_cart/shopping_cart_empty.png'),
              ),
            );
          } else if (state is ShoppingCartPackedState) {
            return ScreenProductsList(products: state.products);
          }
          return const ScreenProductsList(products: []);
        }),
        BlocBuilder<ShoppingCartBloc, ShoppingCartState>(
            builder: (BuildContext context, ShoppingCartState state) {
          if (state is ShoppingCartEmptyState) {
            return Positioned(
                bottom: 0,
                child: ScreenProductsResume(
                    subTotalAmount: state.subTotalAmount,
                    size: size,
                    navigationModel: navigationModel,
                    productsListEmpty: true));
          } else if (state is ShoppingCartPackedState) {
            return Positioned(
                bottom: 0,
                child: ScreenProductsResume(
                    subTotalAmount: state.subTotalAmount,
                    size: size,
                    navigationModel: navigationModel,
                    productsListEmpty: false));
          }
          return Positioned(
              bottom: 0,
              child: ScreenProductsResume(
                  subTotalAmount: 0,
                  size: size,
                  navigationModel: navigationModel,
                  productsListEmpty: false));
        }),
      ]),
    );
  }
}

class ScreenProductsResume extends StatelessWidget {
  ScreenProductsResume(
      {super.key,
      required this.size,
      required this.navigationModel,
      required this.subTotalAmount,
      required this.productsListEmpty});

  final Size size;
  final NavigationModel navigationModel;
  final int subTotalAmount;
  final bool productsListEmpty;
  final ToastConfirmService toastConfirmService =
      ToastConfirmService.toastConfirmService;

  @override
  Widget build(BuildContext context) {
    //+ Bloc de customer
    final CustomerBloc customerBloc = BlocProvider.of<CustomerBloc>(context);
    //+ Bloc del carrito de compras
    final ShoppingCartBloc shoppingCartBloc =
        BlocProvider.of<ShoppingCartBloc>(context);
    return Container(
      height: 178,
      width: size.width - 24,
      decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(6)),
          color: AppColors.surface10Color.withOpacity(0.55)),
      padding: const EdgeInsets.all(10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text('Subtotal: ',
                  style: AppFonts.subTitle2Heavy(
                      color: AppColors.gray100Color, fontFamily: 'Ubuntu')),
              Text(
                  '${env.MICROS.PRODUCTS.VARS.CURRENCY_SYMBOL} ${PipesNumber.unitsToDecimal(this.subTotalAmount, 2)}',
                  style: AppFonts.labelTextHeavy(
                      color: AppColors.gray100Color, fontFamily: 'Ubuntu')),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text('Delivery: ',
                  style: AppFonts.subTitle2Heavy(
                      color: AppColors.gray100Color, fontFamily: 'Ubuntu')),
              Text(
                  '${env.MICROS.PRODUCTS.VARS.CURRENCY_SYMBOL} ${PipesNumber.unitsToDecimal(500, 2)}',
                  style: AppFonts.labelTextHeavy(
                      color: AppColors.gray100Color, fontFamily: 'Ubuntu')),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text('Total: ',
                  style: AppFonts.subTitle2Heavy(
                      color: AppColors.gray100Color, fontFamily: 'Ubuntu')),
              Text(
                  '${env.MICROS.PRODUCTS.VARS.CURRENCY_SYMBOL} ${PipesNumber.unitsToDecimal(0, 2)}',
                  style: AppFonts.labelTextHeavy(
                      color: AppColors.gray100Color, fontFamily: 'Ubuntu')),
            ],
          ),
          UIButtonIcon(
              onPressedFunc: shoppingCartBloc.state.products.isNotEmpty
                  ? () {
                      if (customerBloc.state.loggedIn) {
                        navigationModel.actualPage = 1;
                      } else {
                        toastConfirmService.showToast(
                            context,
                            '¡Ups! Usted no se encuentra registrado 🙁',
                            'Para seguir con su compra por su seguridad primero debe de realizar su registro.',
                            ToastConfirmServiceType.SUCCESS, () {
                          Navigator.pop(context);
                        }, () {
                          Navigator.pushNamed(context, '/home/overview',
                              arguments: {
                                'pageIndex': 3,
                                'shoppingCart': true
                              });
                        });
                      }
                    }
                  : null,
              enabledColor: AppColors.secondary60Color,
              disabledColor: AppColors.secondary40Color,
              splashColor: AppColors.gray100Color,
              iconData: Icons.shopping_cart,
              text: 'Confirmar')
        ],
      ),
    );
  }
}

class ScreenProductsList extends StatelessWidget {
  final List<ShoppingCardProducts> products;

  const ScreenProductsList({super.key, required this.products});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final ShoppingCartBloc shoppingCartBloc =
        BlocProvider.of<ShoppingCartBloc>(context);

    return SizedBox(
      height: size.height,
      child: GridView.builder(
          physics: const BouncingScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 1,
              mainAxisSpacing: 14,
              mainAxisExtent: 178,
              childAspectRatio: 20),
          itemCount: products.length + 1,
          itemBuilder: (BuildContext context, int i) {
            if (i < products.length) {
              return ProductCardShopCart(
                  productImageUrl: products[i].product.cardImgUrlFo,
                  productTitle: products[i].product.cardTitleFo,
                  productSubTitle: products[i].product.cardSubTitleFo,
                  productPrice: PipesNumber.unitsToDecimal(
                      products[i].product.inventoryPrice, 2),
                  productTotalPrice: PipesNumber.unitsToDecimal(
                      products[i].product.inventoryPrice * products[i].quantity,
                      2),
                  productQuantity: products[i].quantity,
                  currencySymbol: env.MICROS.PRODUCTS.VARS.CURRENCY_SYMBOL,
                  onPressedLessFunc: () {
                    shoppingCartBloc.lessProduct(i);
                  },
                  onPressedPlusFunc: () {
                    shoppingCartBloc.plusProduct(i);
                  },
                  onPressedRemoveFunc: () {
                    shoppingCartBloc.removeProduct(i);
                  });
            } else {
              return const SizedBox(
                height: 178,
              );
            }
          }),
    );
  }
}
