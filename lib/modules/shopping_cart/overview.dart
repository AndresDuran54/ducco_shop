//+ FLUTTER
import 'package:flutter/material.dart';

//+ DEPENDENCIES
import 'package:provider/provider.dart';

//+ LIB CORE SDKS
import 'package:ducco_shop/lib_shares/services/providers/module.dart';

//+ SCREENS
import 'package:ducco_shop/modules/shopping_cart/screens/screen_module.dart';

class ShoppingCartOverview extends StatelessWidget {
  const ShoppingCartOverview({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) => new NavigationModel(),
      child: const ShoppingCartBodyOverview(),
    );
  }
}

class ShoppingCartBodyOverview extends StatelessWidget {
  const ShoppingCartBodyOverview({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    //+ Inyectamos el navigationModel
    final navigationModel = Provider.of<NavigationModel>(context);

    return PageView(
      controller: navigationModel.pageController,
      children: const <Widget>[ScreenProducts(), ScreenForm(), ScreenPayment()],
    );
  }
}
