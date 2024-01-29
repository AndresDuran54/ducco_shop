//+ FLUTTER
import 'package:ducco_shop/utils/colors/colors.dart';
import 'package:ducco_shop/utils/fonts/fonts.dart';
import 'package:flutter/material.dart';

//+ DEPENDENCIES
import 'package:provider/provider.dart';

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
        const ScreenProductsList(),
        Positioned(
            bottom: 0,
            child: ScreenProductsResume(
                size: size, navigationModel: navigationModel))
      ]),
    );
  }
}

// ScreenProductsResume(size: size, navigationModel: navigationModel),

class ScreenProductsResume extends StatelessWidget {
  const ScreenProductsResume({
    super.key,
    required this.size,
    required this.navigationModel,
  });

  final Size size;
  final NavigationModel navigationModel;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 178,
      width: size.width - 24,
      decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(6)),
          color: AppColors.surface10Color.withOpacity(0.5)),
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
              Text('S/. 100.00',
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
              Text('S/. 10.00',
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
              Text('S/. 110.00',
                  style: AppFonts.labelTextHeavy(
                      color: AppColors.gray100Color, fontFamily: 'Ubuntu')),
            ],
          ),
          UIButtonIcon(
              onPressedFunc: () {
                navigationModel.actualPage = 1;
              },
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
  const ScreenProductsList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return SizedBox(
      height: size.height,
      child: GridView.builder(
          physics: const BouncingScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 1,
              mainAxisSpacing: 14,
              mainAxisExtent: 178,
              childAspectRatio: 20),
          itemCount: 13,
          itemBuilder: (BuildContext context, int index) {
            if (index < 12) {
              return const ProductCardShopCart(
                productImageUrl:
                    'https://promart.vteximg.com.br/arquivos/ids/6571809-1000-1000/image-e141cd34a31b46738915da3046190205.jpg?v=638012766471300000',
                productTitle: 'Teclado mecánico \n Logitech',
                productSubTitle: 'Tecnología antighosting',
                productPrice: '5.00',
                productTotalPrice: '50.00',
                currencySymbol: 'S/.',
              );
            } else {
              return const SizedBox(
                height: 178,
              );
            }
          }),
    );
  }
}
