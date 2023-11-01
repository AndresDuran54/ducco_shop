import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

//+ Utils
import 'package:ducco_shop/utils/colors/colors.dart';

//+ Overview Screens
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
        backgroundColor: AppColors.gray50Color,
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
          backgroundColor: AppColors.primary10Color,
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

    return PageView(
      controller: navigationModel.pageController,
      physics: const BouncingScrollPhysics(),
      children: const <Widget>[
        HomeOverview(),
        CategoriesOverview(),
        ShoppingCartOverview(),
        AccountOverview()
      ],
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
        backgroundColor: AppColors.primary15Color,
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

//+ Navigation Model | Scaffold
class NavigationModel with ChangeNotifier {
  //+ Controlador del bottomNavigationBar
  final PageController _pageController = new PageController();
  //+ Indice de la página actual
  int _actualPage = 0;

  NavigationModel() {
    //+ Agregamos un listener para el cambio de página
    this._pageController.addListener(() {
      //+ Obtenemos el indice de la página actual
      int newPage = _pageController.page?.round() ?? 0;
      //+ Verificamos si se cambio de página
      if (this._actualPage != newPage) {
        //+ Setteamos _actualPage
        this._actualPage = newPage;
        //+ Notificamos a los oyentes
        this.notifyListeners();
      }
    });
  }

  //+ Getter _actualPage
  int get actualPage => this._actualPage;

  //+ Setter _actualPage
  set actualPage(int actualPage) {
    //+ Setteamos _actualPage
    this._actualPage = actualPage;
    //+ Cambiamos de página
    this._pageController.animateToPage(this._actualPage,
        duration: const Duration(milliseconds: 250), curve: Curves.easeOut);
    //+ Notificamos a los oyentes
    this.notifyListeners();
  }

  //+ Getter _pageController
  PageController get pageController => this._pageController;
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
