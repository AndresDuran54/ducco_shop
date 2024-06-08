//+ FLUTTER
import 'package:flutter/material.dart';

//+ DEPENDENCIES
import 'package:provider/provider.dart';

//+ LIB SHARES
import 'package:ducco_shop/lib_shares/services/providers/module.dart';

//+ UTILS
import 'package:ducco_shop/utils/colors/colors.dart';

//+ LIB CORE DOMAIN
import 'package:ducco_shop/lib_core_domain/module.dart';

class ScreenCategoriesOverview extends StatelessWidget {
  const ScreenCategoriesOverview({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<CategoriesGetItems>(
        future: CategoriesDomainService.categoriesDomainService
            .categoriesGetItems(headers: {
          'orders': '[{"order":"cardOrderFO","val":"asc"}]',
          'filters': '[{"filter":"cardShowFO","val":"1"}]',
        }),
        builder:
            (BuildContext context, AsyncSnapshot<CategoriesGetItems> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const SizedBox(
              height: 300,
              child: Center(
                  child: CircularProgressIndicator(
                color: AppColors.primary30Color,
              )),
            );
          } else if (snapshot.connectionState == ConnectionState.done) {
            return ScreenCategoriesList(categories: snapshot.data!.items);
          }
          return const Text('DEFAULT');
        });
  }
}

class ScreenCategoriesList extends StatelessWidget {
  final List<Category> categories;

  const ScreenCategoriesList({super.key, required this.categories});

  @override
  Widget build(BuildContext context) {
    final navigationModel = Provider.of<NavigationModel>(context);

    return Padding(
      padding: const EdgeInsets.all(16),
      child: ListView.separated(
          separatorBuilder: (BuildContext context, int index) =>
              const SizedBox(height: 10),
          itemCount: categories.length,
          physics: const BouncingScrollPhysics(),
          itemBuilder: (BuildContext context, int i) => ScreenCategoriesCard(
              navigationModel: navigationModel,
              rightPositionImage: i % 2 > 0 ? true : false,
              category: categories[i])),
    );
  }
}

class ScreenCategoriesCard extends StatelessWidget {
  final NavigationModel navigationModel;
  final Category category;
  final bool rightPositionImage;

  const ScreenCategoriesCard({
    required this.category,
    required this.rightPositionImage,
    required this.navigationModel,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var widgets = [
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            this.category.cardTitleFo,
            style: const TextStyle(
              color: AppColors.secondary50Color,
              fontFamily: 'Roboto',
              fontWeight: FontWeight.w600,
              fontSize: 22,
            ),
            textAlign: TextAlign.start,
          ),
          const SizedBox(
            height: 8,
          ),
          Text(
            this.category.cardSubTitleFo,
            style: const TextStyle(
              color: AppColors.gray10Color,
              fontFamily: 'Roboto',
              fontWeight: FontWeight.w500,
              fontSize: 16,
            ),
            textAlign: TextAlign.start,
          ),
        ],
      ),
      FadeInImage(
          width: 190,
          placeholderFit: BoxFit.cover,
          placeholder: const AssetImage('assets/gifs/loading.gif'),
          fit: BoxFit.cover,
          image: NetworkImage(this.category.cardImgUrlFo))
    ];

    return GestureDetector(
      onTap: () {
        navigationModel.paramsPage = {'category': this.category};
        navigationModel.actualPage = 2;
      },
      child: Container(
        decoration: BoxDecoration(
            color: AppColors.gray90Color,
            borderRadius: BorderRadius.circular(8)),
        height: 180,
        child: Stack(
          children: [
            if (!this.rightPositionImage) ...<Widget>[
              Positioned(
                top: 0,
                left: 0,
                width: 100,
                height: 100,
                child: Container(
                  decoration: const BoxDecoration(
                      color: AppColors.secondary40Color,
                      borderRadius:
                          BorderRadius.only(bottomRight: Radius.circular(95))),
                ),
              ),
            ],
            if (this.rightPositionImage) ...<Widget>[
              Positioned(
                bottom: 0,
                right: 0,
                width: 100,
                height: 100,
                child: Container(
                  decoration: const BoxDecoration(
                      color: AppColors.gray25Color,
                      borderRadius: BorderRadius.only(
                          bottomRight: Radius.circular(12),
                          topLeft: Radius.circular(95))),
                ),
              ),
            ],
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: this.rightPositionImage
                    ? widgets
                    : widgets.reversed.toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
