import 'package:flutter/material.dart';

//+ Utils
import 'package:ducco_shop/utils/colors/colors.dart';

//+ Modules
import 'package:ducco_shop/widgets/products/module.dart';

class HomeOverview extends StatelessWidget {
  const HomeOverview({super.key});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return BodyHomeOverview(size: size);
  }
}

class BodyHomeOverview extends StatelessWidget {
  final Size size;

  const BodyHomeOverview({
    super.key,
    required this.size,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10),
      child: ListView(
        children: <Widget>[
          const SizedBox(
            height: 10,
          ),
          FlayersImagesHomeOverview(size: size),
          const SizedBox(
            height: 10,
          ),
          const Padding(
            padding: EdgeInsets.only(left: 10),
            child: Text(
              'Los más comprados',
              style: TextStyle(
                color: AppColors.primary10Color,
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
          HomeOverviewListProducts(size: size),
          const SizedBox(
            height: 20,
          ),
          FlayersImagesHomeOverview(size: size),
          const SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }
}

class HomeOverviewListProducts extends StatelessWidget {
  const HomeOverviewListProducts({
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
          itemBuilder: (BuildContext context, int index) => GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, '/home/product_detail');
                },
                child: ProductCard(
                  size: size,
                ),
              )),
    );
  }
}

class FlayersImagesHomeOverview extends StatelessWidget {
  const FlayersImagesHomeOverview({
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
