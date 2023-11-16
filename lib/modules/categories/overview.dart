//+ FLUTTER
import 'package:flutter/material.dart';

//+ DEPENDENCIES
import 'package:provider/provider.dart';

//+ LIB CORE SDKS
import 'package:ducco_shop/lib_core_sdks/providers/module.dart';

//+ SCREENS
import 'package:ducco_shop/modules/categories/screens/screens_module.dart';

class CategoriesOverview extends StatelessWidget {
  const CategoriesOverview({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) => NavigationModel(),
      child: const CategoriesBodyOverview(),
    );
  }
}

class CategoriesBodyOverview extends StatelessWidget {
  const CategoriesBodyOverview({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    //+ Inyectamos el navigationModel
    final navigationModel = Provider.of<NavigationModel>(context);

    return PageView(
      controller: navigationModel.pageController,
      children: const <Widget>[
        ScreenCategoriesList(),
        ScreenCategoriesResult(),
      ],
    );
  }
}
