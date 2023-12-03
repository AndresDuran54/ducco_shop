//+ FLUTTER
import 'package:ducco_shop/utils/colors/colors.dart';
import 'package:ducco_shop/utils/fonts/fonts.dart';
import 'package:flutter/material.dart';

//+ LIB CORE UI
import 'package:ducco_shop/lib_core_ui/ui_buttons/module.dart';

class ProductCardShopCart extends StatelessWidget {
  final String productImageUrl;
  final String productTitle;
  final String productSubTitle;
  final String productPrice;
  final String productTotalPrice;
  final String currencySymbol;

  const ProductCardShopCart(
      {super.key,
      required this.productImageUrl,
      required this.productTitle,
      required this.productSubTitle,
      required this.currencySymbol,
      required this.productPrice,
      required this.productTotalPrice});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: AppColors.gray90Color,
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.all(Radius.circular(5)),
      ),
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Positioned(
            top: 0,
            left: 0,
            width: 100,
            height: 100,
            child: Container(
              decoration: const BoxDecoration(
                  color: AppColors.gray50Color,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(6),
                      bottomRight: Radius.circular(200))),
            ),
          ),
          Positioned(
            bottom: 0,
            right: 0,
            width: 60,
            height: 60,
            child: Container(
              decoration: const BoxDecoration(
                  color: AppColors.gray50Color,
                  borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(12),
                      topLeft: Radius.circular(200))),
            ),
          ),
          ProductCardShopCartContent(
            productImageUrl: this.productImageUrl,
            productTitle: this.productTitle,
            productSubTitle: this.productSubTitle,
            productPrice: this.productPrice,
            productTotalPrice: this.productTotalPrice,
            currencySymbol: this.currencySymbol,
          )
        ],
      ),
    );
  }
}

class ProductCardShopCartContent extends StatelessWidget {
  final String productImageUrl;
  final String productTitle;
  final String productSubTitle;
  final String productPrice;
  final String productTotalPrice;
  final String currencySymbol;

  const ProductCardShopCartContent(
      {super.key,
      required this.productImageUrl,
      required this.productTitle,
      required this.productSubTitle,
      required this.currencySymbol,
      required this.productPrice,
      required this.productTotalPrice});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child:
          Row(crossAxisAlignment: CrossAxisAlignment.center, children: <Widget>[
        ClipOval(
          child: Container(
            width: 120,
            decoration: const BoxDecoration(
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.all(Radius.circular(4))),
            child: FadeInImage(
                placeholderFit: BoxFit.contain,
                placeholder:
                    const AssetImage('assets/gifs/loading_rolling.gif'),
                fit: BoxFit.cover,
                image: NetworkImage(this.productImageUrl)),
          ),
        ),
        const SizedBox(width: 8),
        Container(
          padding: const EdgeInsets.all(4),
          child: Column(children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  this.productTitle,
                  textAlign: TextAlign.start,
                  style: AppFonts.labelTextHeavy(
                      color: AppColors.secondary60Color, fontFamily: 'Ubuntu'),
                ),
                Text(
                  this.productSubTitle,
                  textAlign: TextAlign.start,
                  style: AppFonts.captionTextHeavy(
                      color: AppColors.gray40Color, fontFamily: 'Ubuntu'),
                ),
                const SizedBox(height: 12),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Precio unitario: ',
                      textAlign: TextAlign.start,
                      style: AppFonts.captionTextHeavy(
                          color: AppColors.gray20Color, fontFamily: 'Ubuntu'),
                    ),
                    Text(
                      '${this.currencySymbol} ${this.productPrice}',
                      textAlign: TextAlign.start,
                      style: AppFonts.captionTextHeavy(
                          color: AppColors.gray40Color, fontFamily: 'Ubuntu'),
                    )
                  ],
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Precio total: ',
                      textAlign: TextAlign.start,
                      style: AppFonts.captionTextHeavy(
                          color: AppColors.gray20Color, fontFamily: 'Ubuntu'),
                    ),
                    Text(
                      '${this.currencySymbol} ${this.productTotalPrice}',
                      textAlign: TextAlign.start,
                      style: AppFonts.captionTextHeavy(
                          color: AppColors.gray40Color, fontFamily: 'Ubuntu'),
                    )
                  ],
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                UIButtonMiniIcon(
                    onTapFunction: () => {},
                    backgroundColor: AppColors.primary20Color,
                    color: AppColors.gray100Color,
                    iconData: Icons.add,
                    backgroundOpacity: 1),
                const SizedBox(width: 12),
                Text(
                  '5',
                  textAlign: TextAlign.start,
                  style: AppFonts.subTitleHeavy(
                      color: AppColors.gray30Color, fontFamily: 'Ubuntu'),
                ),
                const SizedBox(width: 12),
                UIButtonMiniIcon(
                    onTapFunction: () => {},
                    backgroundColor: AppColors.primary20Color,
                    color: AppColors.gray100Color,
                    iconData: Icons.remove,
                    backgroundOpacity: 1),
                const SizedBox(width: 12),
                UIButtonMiniIcon(
                    onTapFunction: () => {},
                    backgroundColor: AppColors.red60Color,
                    color: AppColors.gray100Color,
                    iconData: Icons.delete,
                    backgroundOpacity: 1)
              ],
            )
          ]),
        )
      ]),
    );
  }
}
