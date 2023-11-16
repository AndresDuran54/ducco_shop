import 'package:ducco_shop/utils/fonts/fonts.dart';
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
      padding: const EdgeInsets.all(10),
      child: ListView(
        children: <Widget>[
          const SizedBox(
            height: 10,
          ),
          FlayersImagesHomeOverview(size: size),
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Text(
              'Los más comprados',
              style: AppFonts.subTitleHeavy(
                  color: AppColors.gray45Color, fontFamily: 'Ubuntu'),
              textAlign: TextAlign.start,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          HomeOverviewListProducts(size: size),
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Text(
              'Te podría interesar',
              style: AppFonts.subTitleHeavy(
                  color: AppColors.gray45Color, fontFamily: 'Ubuntu'),
              textAlign: TextAlign.start,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          HomeOverviewListProductsHorizontal(size: size)
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
      height: (300 * 2) + 15,
      padding: const EdgeInsets.only(top: 0, left: 10, right: 10, bottom: 0),
      child: GridView.builder(
          itemCount: 4,
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

class HomeOverviewListProductsHorizontal extends StatelessWidget {
  const HomeOverviewListProductsHorizontal({
    Key? key,
    required this.size,
  }) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      padding: const EdgeInsets.only(top: 0, left: 10, right: 10, bottom: 0),
      child: GridView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: 6,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 1,
              mainAxisSpacing: 15,
              crossAxisSpacing: 10,
              mainAxisExtent: 180,
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
        itemCount: 2,
        physics: const BouncingScrollPhysics(),
        itemBuilder: (BuildContext context, int index) {
          return ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: FadeInImage(
                width: size.width - 20,
                placeholderFit: BoxFit.cover,
                placeholder: const AssetImage('assets/gifs/loading.gif'),
                fit: BoxFit.cover,
                image: const NetworkImage(
                    'https://images.falabella.com/v3/assets/bltf4ed0b9a176c126e/blt3dbfe57ed6dc306a/654bf62429d7ab0409fdfbc0/Vitrina-02-W45-mb-electroton-61123-av.jpg?disable=upscale&format=webp&quality=70&width=720')),
          );
        },
      ),
    );
  }
}
