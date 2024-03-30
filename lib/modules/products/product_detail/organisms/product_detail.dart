//+ FLUTTER
import 'package:ducco_shop/lib_core_domain/domain/env_domain.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

//+ LIB CORE DOMAIN
import 'package:ducco_shop/lib_core_domain/lib/pipes/pipes.module.dart';
import 'package:ducco_shop/lib_core_domain/module.dart';

//+ WIDGETS
import 'package:ducco_shop/widgets/products/module.dart';

//+ COLORS
import 'package:ducco_shop/utils/fonts/fonts.dart';
import 'package:ducco_shop/utils/colors/colors.dart';

//+ LIB CORE UI
import 'package:ducco_shop/lib_core_ui/ui_buttons/module.dart';
import 'package:ducco_shop/lib_core_ui/ui_inputs/module.dart';

//+ LIB BLOC
import 'package:ducco_shop/lib_bloc/module.dart';

class ProductDetailScreen extends StatelessWidget {
  const ProductDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final Map<String, dynamic> arguments =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;
    final ShoppingCartBloc shoppingCartBloc =
        BlocProvider.of<ShoppingCartBloc>(context);
    final List<dynamic> getProductResult =
        shoppingCartBloc.getProductCart(arguments["product"]);
    ShoppingCardProducts shoppingCardProducts = getProductResult[0];
    int indexProduct = getProductResult[1];

    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.gray80Color,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          child: Column(
            children: [
              //+ APP BAR
              const ProductDetailScreenAppBar(),
              Expanded(
                child: ListView(
                  physics: const BouncingScrollPhysics(),
                  children: <Widget>[
                    const SizedBox(
                      height: 24,
                    ),
                    Column(
                      children: <Widget>[
                        Text(shoppingCardProducts.product.detailTitleFo,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                                fontFamily: 'Roboto',
                                fontWeight: FontWeight.w500,
                                fontSize: 20,
                                color: AppColors.secondary50Color)),
                        Text(shoppingCardProducts.product.detailSubTitleFo,
                            style: const TextStyle(
                                fontFamily: 'Roboto',
                                fontWeight: FontWeight.w400,
                                fontSize: 16,
                                color: AppColors.gray40Color)),
                      ],
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    ProductDetailScreenFlayersImages(
                        size: size,
                        imagesUrls:
                            shoppingCardProducts.product.detailImagesUrlsFo),
                    const SizedBox(
                      height: 16,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                              '${env.MICROS.PRODUCTS.VARS.CURRENCY_SYMBOL} ${PipesDecimal.unitsToDecimal(shoppingCardProducts.product.inventoryPrice, 2)}',
                              style: AppFonts.titleHeavy(
                                  color: AppColors.secondary50Color,
                                  fontFamily: 'Ubuntu')),
                          BlocBuilder<ShoppingCartBloc, ShoppingCartState>(
                              builder: (BuildContext context,
                                  ShoppingCartState state) {
                            if (indexProduct != -1) {
                              final List<dynamic> getProductResult =
                                  shoppingCartBloc
                                      .getProductCart(arguments["product"]);
                              ShoppingCardProducts shoppingCardProducts =
                                  getProductResult[0];
                              int indexProduct = getProductResult[1];
                              return CoreUIInputSlider(
                                productQuantity: shoppingCardProducts.quantity,
                                onPressedLessFunc: () {
                                  shoppingCartBloc.lessProduct(indexProduct);
                                },
                                onPressedPlusFunc: () {
                                  shoppingCartBloc.plusProduct(indexProduct);
                                },
                                hideIconRemove: true,
                              );
                            } else {
                              return Container();
                            }
                          })
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('Descripción',
                              style: TextStyle(
                                  fontFamily: 'Roboto',
                                  fontWeight: FontWeight.w700,
                                  fontSize: 16,
                                  color: AppColors.primary30Color)),
                          Text(shoppingCardProducts.product.detailDescriptionFo,
                              style: const TextStyle(
                                  fontFamily: 'Roboto',
                                  fontSize: 16,
                                  color: AppColors.gray50Color)),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text('Te podrían interesar',
                            textAlign: TextAlign.start,
                            style: AppFonts.labelTextHeavy(
                                color: AppColors.gray25Color,
                                fontFamily: 'Ubuntu')),
                        const SizedBox(
                          height: 12,
                        ),
                        FutureHomeOverviewListProductsHorizontal(
                          size: size,
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                  ],
                ),
              ),
              MaterialButton(
                color: AppColors.secondary60Color,
                onPressed: (() {
                  if (indexProduct == -1) {
                    indexProduct = shoppingCartBloc.addProduct(
                        shoppingCardProducts.product, 1);
                  } else {
                    shoppingCartBloc.removeProduct(indexProduct);
                    indexProduct = -1;
                  }
                }),
                child: BlocBuilder<ShoppingCartBloc, ShoppingCartState>(
                  builder: (BuildContext context, ShoppingCartState state) {
                    return Text(
                      indexProduct == -1
                          ? 'AGREGAR AL CARRITO'
                          : 'QUITAR AL CARRITO',
                      style: const TextStyle(
                        color: AppColors.gray90Color,
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                      ),
                      textAlign: TextAlign.center,
                    );
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class ProductDetailScreenAppBar extends StatelessWidget {
  const ProductDetailScreenAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        UIButtonMiniIcon(
          iconData: Icons.arrow_back_sharp,
          color: AppColors.primary20Color,
          backgroundColor: AppColors.gray60Color,
          onTapFunction: () => {Navigator.pop(context)},
        ),
        const Image(
            image: AssetImage('assets/images/logo_ducco_name.png'), height: 30),
        UIButtonMiniIcon(
          iconData: Icons.favorite,
          color: AppColors.secondary60Color,
          backgroundColor: AppColors.gray60Color,
          onTapFunction: () => {},
        )
      ],
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

class ProductDetailScreenFlayersImages extends StatefulWidget {
  const ProductDetailScreenFlayersImages({
    Key? key,
    required this.size,
    required this.imagesUrls,
  }) : super(key: key);

  final Size size;
  final List<String> imagesUrls;

  @override
  State<ProductDetailScreenFlayersImages> createState() =>
      _ProductDetailScreenFlayersImagesState();
}

class _ProductDetailScreenFlayersImagesState
    extends State<ProductDetailScreenFlayersImages> {
  final ScrollController _controller = ScrollController();
  int currentIndex = 0;
  double currentPostion = 0;

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      var index = double.parse(
          (_controller.position.pixels / (widget.size.width - 24))
              .toStringAsPrecision(2));

      setState(() {
        currentIndex = index.toInt();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 300,
          child: ListView.builder(
            controller: _controller,
            scrollDirection: Axis.horizontal,
            itemCount: widget.imagesUrls.length,
            physics: const PageScrollPhysics(),
            itemBuilder: (BuildContext context, int index) {
              return ClipRRect(
                child: FadeInImage(
                    width: widget.size.width - 24,
                    placeholder: const AssetImage('assets/gifs/loading.gif'),
                    fit: BoxFit.cover,
                    image: NetworkImage(widget.imagesUrls[index])),
              );
            },
          ),
        ),
        SizedBox(
          width: widget.imagesUrls.length * 20 +
              10 * (widget.imagesUrls.length - 1),
          height: 20,
          child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: widget.imagesUrls.length,
              separatorBuilder: (BuildContext context, int index) {
                return const SizedBox(
                  width: 10,
                );
              },
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      currentIndex = index;
                    });
                    _controller.animateTo(index * (widget.size.width - 24),
                        duration: const Duration(milliseconds: 100),
                        curve: Curves.easeInOut);
                  },
                  child: Container(
                    height: 20,
                    width: 20,
                    decoration: BoxDecoration(
                        color: index == currentIndex
                            ? AppColors.black50Color
                            : AppColors.black70Color,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10))),
                  ),
                );
              }),
        )
      ],
    );
  }
}
