//+ FLUTTER
import 'package:flutter/material.dart';

//+ UTILS
import 'package:ducco_shop/utils/colors/colors.dart';
import 'package:ducco_shop/utils/fonts/fonts.dart';

//+ MODULES
import 'package:ducco_shop/widgets/products/module.dart';

//+ LIB CORE DOMAIN
import 'package:ducco_shop/lib_core_domain/module.dart';

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
          FutureHomeOverviewListProducts(size: size),
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
          FutureHomeOverviewListProductsHorizontal(size: size)
        ],
      ),
    );
  }
}

class FutureHomeOverviewListProducts extends StatelessWidget {
  final Size size;

  const FutureHomeOverviewListProducts({required this.size, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<ProductsGetItems>(
        future: ProductsDomainService.productsDomainService
            .productsGetItems(headers: {
          'paging_index': '1',
          'paging_size': '4',
          'orders': '[{"order":"inventorySalesQuantity","val":"desc"}]',
        }),
        builder:
            (BuildContext context, AsyncSnapshot<ProductsGetItems> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const SizedBox(
              height: 300,
              child: Center(
                  child: CircularProgressIndicator(
                color: AppColors.primary30Color,
              )),
            );
          } else if (snapshot.connectionState == ConnectionState.done) {
            return HomeOverviewListProducts(
                size: size, products: snapshot.data!.items);
          }
          return const Text('DEFAULT');
        });
  }
}

class HomeOverviewListProducts extends StatelessWidget {
  const HomeOverviewListProducts({
    Key? key,
    required this.size,
    required this.products,
  }) : super(key: key);

  final List<Product> products;
  final Size size;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: (300 * 2) + 15,
      padding: const EdgeInsets.only(top: 0, left: 10, right: 10, bottom: 0),
      child: GridView.builder(
          itemCount: products.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 15,
              crossAxisSpacing: 10,
              mainAxisExtent: 300,
              childAspectRatio: 20),
          physics: const BouncingScrollPhysics(),
          itemBuilder: (BuildContext context, int index) => GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, '/home/product_detail',
                      arguments: {'product': products[index]});
                },
                child: ProductCard(
                  size: size,
                  product: products[index],
                ),
              )),
    );
  }
}

class FutureHomeOverviewListProductsHorizontal extends StatelessWidget {
  final Size size;

  const FutureHomeOverviewListProductsHorizontal({required this.size, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<ProductsGetItems>(
        future: ProductsDomainService.productsDomainService
            .productsGetItems(headers: {
          'orders': '[{"order":"inventorySalesQuantity","val":"desc"}]',
        }),
        builder:
            (BuildContext context, AsyncSnapshot<ProductsGetItems> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const SizedBox(
              height: 300,
              child: Center(
                  child: CircularProgressIndicator(
                color: AppColors.primary30Color,
              )),
            );
          } else if (snapshot.connectionState == ConnectionState.done) {
            return HomeOverviewListProductsHorizontal(
                size: size, products: snapshot.data!.items);
          }
          return const Text('DEFAULT');
        });
  }
}

class HomeOverviewListProductsHorizontal extends StatelessWidget {
  const HomeOverviewListProductsHorizontal({
    Key? key,
    required this.size,
    required this.products,
  }) : super(key: key);

  final List<Product> products;
  final Size size;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      padding: const EdgeInsets.only(top: 0, left: 10, right: 10, bottom: 0),
      child: GridView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: products.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 1,
              mainAxisSpacing: 15,
              crossAxisSpacing: 10,
              mainAxisExtent: 180,
              childAspectRatio: 20),
          physics: const BouncingScrollPhysics(),
          itemBuilder: (BuildContext context, int index) => GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, '/home/product_detail',
                      arguments: {'product': products[index]});
                },
                child: ProductCard(
                  size: size,
                  product: products[index],
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
