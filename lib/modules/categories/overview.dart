import 'package:ducco_shop/utils/colors/colors.dart';
import 'package:flutter/material.dart';

class CategoriesOverview extends StatelessWidget {
  const CategoriesOverview({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16),
      child: ListView(
        physics: const BouncingScrollPhysics(),
        children: const <Widget>[
          SizedBox(height: 10),
          CategoriesCard(
              rightPositionImage: true,
              pathImage:
                  'assets/images/modules/categories/earphones_categories.png'),
          SizedBox(height: 10),
          CategoriesCard(
              rightPositionImage: false,
              pathImage:
                  'assets/images/modules/categories/keyboard_categories.png'),
          SizedBox(height: 10),
          CategoriesCard(
              rightPositionImage: true,
              pathImage:
                  'assets/images/modules/categories/mouse_categories.png'),
          SizedBox(height: 10),
          CategoriesCard(
              rightPositionImage: true,
              pathImage:
                  'assets/images/modules/categories/keyboard_categories.png'),
          SizedBox(height: 10),
        ],
      ),
    );
  }
}

class CategoriesCard extends StatelessWidget {
  final String pathImage;
  final bool rightPositionImage;

  const CategoriesCard({
    required this.pathImage,
    required this.rightPositionImage,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: AppColors.gray30Color, borderRadius: BorderRadius.circular(8)),
      padding: const EdgeInsets.only(left: 10, right: 10),
      height: 180,
      child: Stack(
        alignment: Alignment.centerLeft,
        children: <Widget>[
          Positioned(
            right: this.rightPositionImage ? 0 : null,
            child: const Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  '50% OFF',
                  style: TextStyle(
                    color: AppColors.secondary50Color,
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.w600,
                    fontSize: 24,
                  ),
                  textAlign: TextAlign.start,
                ),
                SizedBox(
                  height: 8,
                ),
                Text(
                  'Blue Collections',
                  style: TextStyle(
                    color: AppColors.gray50Color,
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                  ),
                  textAlign: TextAlign.start,
                ),
                SizedBox(
                  height: 8,
                ),
                Text(
                  'Exclusive For',
                  style: TextStyle(
                    color: AppColors.gray90Color,
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                  ),
                  textAlign: TextAlign.start,
                ),
                SizedBox(
                  height: 8,
                ),
                Text(
                  'PartyWear',
                  style: TextStyle(
                    color: AppColors.primary20Color,
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                  ),
                  textAlign: TextAlign.start,
                ),
              ],
            ),
          ),
          Positioned(
            right: this.rightPositionImage ? null : 0,
            child: Image(
                height: 180, width: 170, image: AssetImage(this.pathImage)),
          )
        ],
      ),
    );
  }
}
