import 'package:flutter/material.dart';

//+ Screens
import 'package:ducco_shop/modules/shopping_cart/screens/screen_module.dart';

class ShoppingCartOverview extends StatelessWidget {
  const ShoppingCartOverview({super.key});

  @override
  Widget build(BuildContext context) {
    return PageView(
      children: const <Widget>[
        FormAddressResume(),
        FormIdentitiesResume(),
        ProductsResumeScreen(),
      ],
    );
  }
}
