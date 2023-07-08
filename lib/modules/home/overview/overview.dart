import 'package:ducco_shop/utils/colors/colors.dart';
import 'package:flutter/material.dart';

import 'package:ducco_shop/widgets/products/module.dart';

class OverviewScreen extends StatelessWidget {
  const OverviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
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
            _InputSearchOverview(size: size)
          ],
        ),
        backgroundColor: AppColors.primary10Color,
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 10, right: 10),
        child: ListView(
          children: <Widget>[
            const SizedBox(
              height: 10,
            ),
            _FlayersImages(size: size),
            const SizedBox(
              height: 10,
            ),
            const Padding(
              padding: EdgeInsets.only(left: 10),
              child: Text(
                'Los más comprados',
                style: TextStyle(
                  color: AppColors.primary30Color,
                  fontFamily: 'Signika',
                  fontWeight: FontWeight.w700,
                  fontSize: 20,
                  height: 1,
                ),
                textAlign: TextAlign.start,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            ListProducts(size: size),
            const SizedBox(
              height: 20,
            ),
            _FlayersImages(size: size),
            const SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
      bottomNavigationBar: const _NavigationBarOverview(),
    );
  }
}

class _FlayersImages extends StatelessWidget {
  const _FlayersImages({
    Key? key,
    required this.size,
  }) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: (size.height - 20) * 0.25,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 4,
        physics: const BouncingScrollPhysics(),
        itemBuilder: (BuildContext context, int index) {
          return ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: FadeInImage(
                width: size.width - 20,
                placeholderFit: BoxFit.cover,
                placeholder: const AssetImage('assets/gifs/loading.gif'),
                fit: BoxFit.cover,
                image: const NetworkImage('https://i.imgur.com/k0smmXd.png')),
          );
        },
      ),
    );
  }
}

class ListProducts extends StatelessWidget {
  const ListProducts({
    Key? key,
    required this.size,
  }) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: (300 * 3) + 15 * 2,
      padding: const EdgeInsets.only(top: 0, left: 10, right: 10, bottom: 0),
      child: GridView.builder(
          itemCount: 6,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 15,
              crossAxisSpacing: 10,
              mainAxisExtent: 300,
              childAspectRatio: 20),
          physics: const BouncingScrollPhysics(),
          itemBuilder: (BuildContext context, int index) => ProductCard(
                size: size,
              )),
    );
  }
}

class _NavigationBarOverview extends StatelessWidget {
  const _NavigationBarOverview({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
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

class _InputSearchOverview extends StatelessWidget {
  const _InputSearchOverview({
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
            hintStyle: TextStyle(color: AppColors.gray50Color, height: 4.3),
            border: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.all(Radius.circular(20)))),
        style: TextStyle(color: AppColors.gray50Color),
      ),
    );
  }
}
