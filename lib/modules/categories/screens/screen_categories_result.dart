import 'package:ducco_shop/utils/colors/colors.dart';
import 'package:ducco_shop/utils/fonts/fonts.dart';
import 'package:ducco_shop/widgets/products/module.dart';
import 'package:flutter/material.dart';

class ScreenCategoriesResult extends StatelessWidget {
  const ScreenCategoriesResult({super.key});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Padding(
      padding: const EdgeInsets.all(8),
      child: ListView(
        children: <Widget>[
          const ScreenCategoriesResultFilters(),
          const SizedBox(
            height: 15,
          ),
          SizedBox(
            height: (300 * 2) + 15,
            child: GridView.builder(
                physics: const BouncingScrollPhysics(),
                itemCount: 16,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 15,
                    crossAxisSpacing: 10,
                    mainAxisExtent: 300,
                    childAspectRatio: 20),
                itemBuilder: (BuildContext context, int index) =>
                    ProductCard(size: size)),
          )
        ],
      ),
    );
  }
}

class ScreenCategoriesResultFilters extends StatelessWidget {
  const ScreenCategoriesResultFilters({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: AppColors.black40Color,
          border: Border.all(width: 1, color: AppColors.gray10Color)),
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(4),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  'Celulares y Teléfonos',
                  style: AppFonts.labelTextLight(
                      color: AppColors.gray25Color, fontFamily: 'Ubuntu'),
                ),
                Text(
                  'Resultados (5588)',
                  style: AppFonts.mainTextHeavy(
                      color: AppColors.gray25Color, fontFamily: 'Ubuntu'),
                )
              ],
            ),
          ),
          Container(
            decoration: const BoxDecoration(
              border: Border(
                  top: BorderSide(width: 1, color: AppColors.gray10Color)),
            ),
            padding: const EdgeInsets.all(6),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      const Icon(Icons.filter_list),
                      Text(
                        'Filtrar',
                        style: AppFonts.labelTextHeavy(
                            color: AppColors.gray100Color,
                            fontFamily: 'Ubuntu'),
                      )
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      const Icon(Icons.sort),
                      Text(
                        'Ordenar',
                        style: AppFonts.labelTextHeavy(
                            color: AppColors.gray100Color,
                            fontFamily: 'Ubuntu'),
                      )
                    ],
                  )
                ]),
          )
        ],
      ),
    );
  }
}
