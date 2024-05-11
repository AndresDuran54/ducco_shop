//+ FLUTTER
import 'package:flutter/material.dart';

//+ EXTERNAL
import 'package:provider/provider.dart';

//+ UTILS
import 'package:ducco_shop/utils/colors/colors.dart';

//+ LIB CORE SDKS
import 'package:ducco_shop/lib_shares/services/providers/module.dart';

//+ OVERVIEW SCREENS
import 'package:ducco_shop/modules/home/overview.dart';
import 'package:ducco_shop/modules/categories/overview.dart';
import 'package:ducco_shop/modules/shopping_cart/overview.dart';
import 'package:ducco_shop/modules/account/overview.dart';

class Overview extends StatelessWidget {
  const Overview({super.key});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return ChangeNotifierProvider(
      create: (BuildContext context) => new NavigationModel(),
      child: Scaffold(
        backgroundColor: AppColors.primary10Color,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              const Image(
                image: AssetImage('assets/images/logo_only.png'),
                width: 35,
              ),
              InputSearchOverview(size: size)
            ],
          ),
          backgroundColor: AppColors.gray15Color,
        ),
        body: const BodyOverview(),
        bottomNavigationBar: const NavigationBarOverview(),
      ),
    );
  }
}

//+ Body | Scaffold
class BodyOverview extends StatelessWidget {
  const BodyOverview({super.key});

  @override
  Widget build(BuildContext context) {
    //+ Inyectamos el navigationModel
    final navigationModel = Provider.of<NavigationModel>(context);

    return Container(
      decoration: const BoxDecoration(color: AppColors.gray80Color),
      child: PageView(
        controller: navigationModel.pageController,
        children: const <Widget>[
          HomeOverview(),
          CategoriesOverview(),
          ShoppingCartOverview(),
          AccountOverview()
        ],
      ),
    );
  }
}

//+ Bottom Navigation Bar | Scaffold
class NavigationBarOverview extends StatelessWidget {
  const NavigationBarOverview({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //+ Inyectamos el navigationModel
    final navigationModel = Provider.of<NavigationModel>(context);

    if (ModalRoute.of(context)?.settings != null &&
        ModalRoute.of(context)?.settings.arguments != null) {
      final Map<String, dynamic> arguments =
          ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;
      if (arguments['pageIndex'] != -1) {
        Future.delayed(const Duration(microseconds: 1), () {
          navigationModel.actualPage = arguments['pageIndex'];
          arguments['pageIndex'] = -1;
        });
      }
    }

    return BottomNavigationBar(
        currentIndex: navigationModel.actualPage,
        onTap: (int index) => navigationModel.actualPage = index,
        type: BottomNavigationBarType.fixed,
        selectedLabelStyle:
            const TextStyle(fontFamily: 'Roboto', fontWeight: FontWeight.w500),
        unselectedLabelStyle:
            const TextStyle(fontFamily: 'Roboto', fontWeight: FontWeight.w500),
        unselectedItemColor: AppColors.gray50Color,
        selectedItemColor: AppColors.secondary60Color,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        backgroundColor: AppColors.gray15Color,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home, color: AppColors.gray40Color),
            activeIcon: Icon(Icons.home, color: AppColors.secondary60Color),
            label: 'Home',
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.category, color: AppColors.gray40Color),
              activeIcon:
                  Icon(Icons.category, color: AppColors.secondary60Color),
              label: 'Categorías'),
          BottomNavigationBarItem(
              icon: Icon(Icons.shopping_cart, color: AppColors.gray40Color),
              activeIcon:
                  Icon(Icons.shopping_cart, color: AppColors.secondary60Color),
              label: 'Carrito'),
          BottomNavigationBarItem(
              icon: Icon(Icons.account_circle, color: AppColors.gray40Color),
              activeIcon:
                  Icon(Icons.account_circle, color: AppColors.secondary60Color),
              label: 'Mi cuenta'),
        ]);
  }
}

class InputSearchOverview extends StatelessWidget {
  const InputSearchOverview({
    Key? key,
    required this.size,
  }) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size.width * 0.8,
      height: 45,
      child: const TextField(
        cursorColor: AppColors.gray50Color,
        decoration: InputDecoration(
            suffixIcon: Icon(
              Icons.manage_search_rounded,
              color: AppColors.gray50Color,
            ),
            filled: true,
            fillColor: AppColors.gray30Color,
            hintText: 'Busca lo que necesitas',
            hintStyle: TextStyle(color: AppColors.gray50Color, height: 3),
            border: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.all(Radius.circular(20)))),
        style: TextStyle(color: AppColors.gray50Color),
      ),
    );
  }
}
