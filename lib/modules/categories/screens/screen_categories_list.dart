//+ FLUTTER
import 'package:flutter/material.dart';

//+ DEPENDENCIES
import 'package:provider/provider.dart';

//+ LIB CORE SDKS
import 'package:ducco_shop/lib_shares/services/providers/module.dart';

//+ UTILS
import 'package:ducco_shop/utils/colors/colors.dart';

class ScreenCategoriesList extends StatelessWidget {
  const ScreenCategoriesList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final navigationModel = Provider.of<NavigationModel>(context);

    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16),
      child: ListView(
        physics: const BouncingScrollPhysics(),
        children: <Widget>[
          const SizedBox(height: 10),
          CategoriesCard(
              navigationModel: navigationModel,
              rightPositionImage: true,
              pathImage:
                  'assets/images/modules/categories/earphones_categories.png'),
          const SizedBox(height: 10),
          CategoriesCard(
              navigationModel: navigationModel,
              rightPositionImage: false,
              pathImage:
                  'assets/images/modules/categories/keyboard_categories.png'),
          const SizedBox(height: 10),
          CategoriesCard(
              navigationModel: navigationModel,
              rightPositionImage: true,
              pathImage:
                  'assets/images/modules/categories/mouse_categories.png'),
          const SizedBox(height: 10),
          CategoriesCard(
              navigationModel: navigationModel,
              rightPositionImage: false,
              pathImage:
                  'assets/images/modules/categories/keyboard_categories.png'),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}

class CategoriesCard extends StatelessWidget {
  final NavigationModel navigationModel;
  final String pathImage;
  final bool rightPositionImage;

  const CategoriesCard({
    required this.pathImage,
    required this.rightPositionImage,
    required this.navigationModel,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        navigationModel.actualPage = 2;
      },
      child: Container(
        decoration: BoxDecoration(
            color: AppColors.gray90Color,
            borderRadius: BorderRadius.circular(8)),
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
                    'Audífonos',
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
                    'Colección',
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
      ),
    );
  }
}
