//+ DEPENDENCIES
import 'package:flutter_bloc/flutter_bloc.dart';

//+ FLUTTER
import 'dart:async';
import 'package:flutter/material.dart';

//+ UTILS
import 'package:ducco_shop/utils/colors/colors.dart';
import 'package:ducco_shop/utils/fonts/fonts.dart';

//+ LIB CORE UI
import 'package:ducco_shop/lib_core_ui/ui_accordion/module.dart';
import 'package:ducco_shop/lib_core_ui/ui_inputs/module.dart';

//+ LIB SHARES
import 'package:ducco_shop/lib_shares/services/providers/module.dart';

//+ LIB CORE DOMAIN
import 'package:ducco_shop/lib_core_domain/module.dart';

//+ MODULES
import 'package:ducco_shop/widgets/products/module.dart';

//+ DEPENDENCIES
import 'package:ducco_shop/lib_bloc/module.dart';

//+ LIB BLOC
import 'package:provider/provider.dart';

class ScreenCategoriesResult extends StatelessWidget {
  const ScreenCategoriesResult({super.key});

  @override
  Widget build(BuildContext context) {
    //+ Dimensiones de pantalla
    final Size size = MediaQuery.of(context).size;
    //+ Bloc de categorías
    final CategoryProductsBloc categoryProductsBloc =
        BlocProvider.of<CategoryProductsBloc>(context);
    //+ Controlador de navegación
    final navigationModel = Provider.of<NavigationModel>(context);
    //+ Obtenemos el registro de la categoría
    final Category category = navigationModel.paramsPage['category'];

    //+ Inicializamos la vista
    categoryProductsBloc.initView(category.categoryId);

    return Padding(
      padding: const EdgeInsets.all(8),
      child: Column(
        children: <Widget>[
          BlocBuilder<CategoryProductsBloc, CategoryProductsState>(
            builder: (BuildContext context, CategoryProductsState state) {
              if (state is CategoryProductsLoadingState) {
                return ScreenCategoriesResultHeader(
                  itemsCounter: state.itemsCounter!,
                  category: category,
                );
              } else if (state is CategoryProductsPackedState) {
                return ScreenCategoriesResultHeader(
                  itemsCounter: state.itemsCounter!,
                  category: category,
                );
              }
              return ScreenCategoriesResultHeader(
                itemsCounter: state.itemsCounter!,
                category: category,
              );
            },
          ),
          const SizedBox(
            height: 8,
          ),
          Expanded(
            child: BlocBuilder<CategoryProductsBloc, CategoryProductsState>(
              builder: (BuildContext context, CategoryProductsState state) {
                if (state is CategoryProductsLoadingState) {
                  return ScreenCategoriesLoadingBody(
                    size: size,
                  );
                } else if (state is CategoryProductsPackedState) {
                  return ScreenCategoriesResultBody(
                      size: size, products: state.products!);
                }
                return Container();
              },
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          ScreenCategoriesResultPaginator(
            size: size,
            categoryProductsBloc: categoryProductsBloc,
            itemsCounter: categoryProductsBloc.state.itemsCounter!,
          )
        ],
      ),
    );
  }
}

class ScreenCategoriesResultBody extends StatelessWidget {
  final List<Product> products;
  final Size size;

  const ScreenCategoriesResultBody({
    super.key,
    required this.products,
    required this.size,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 400,
      child: GridView.builder(
          physics: const BouncingScrollPhysics(),
          itemCount: products.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 15,
              crossAxisSpacing: 15,
              mainAxisExtent: 300),
          itemBuilder: (BuildContext context, int i) => ProductCard(
                size: size,
                product: products[i],
              )),
    );
  }
}

class ScreenCategoriesLoadingBody extends StatelessWidget {
  final Size size;

  const ScreenCategoriesLoadingBody({
    super.key,
    required this.size,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 400,
      child: GridView.builder(
          physics: const BouncingScrollPhysics(),
          itemCount: 6,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 15,
              crossAxisSpacing: 15,
              mainAxisExtent: 300),
          itemBuilder: (BuildContext context, int i) =>
              const AnimatedLoadingCard()),
    );
  }
}

class ScreenCategoriesResultPaginator extends StatefulWidget {
  final Size size;
  final CategoryProductsBloc categoryProductsBloc;
  final int itemsCounter;

  const ScreenCategoriesResultPaginator({
    super.key,
    required this.size,
    required this.categoryProductsBloc,
    required this.itemsCounter,
  });

  @override
  State<ScreenCategoriesResultPaginator> createState() =>
      _ScreenCategoriesResultPaginatorState();
}

class _ScreenCategoriesResultPaginatorState
    extends State<ScreenCategoriesResultPaginator> {
  //+ Controlador para el paginador
  final ScrollController _controller = ScrollController();
  //+ Indice actual del paginador
  int currentIndex = 1;
  //+ Ancho de cada indice en el paginador
  late double itemWidth;
  //+ Cantidad de pagidores
  late int pagingsCount;
  //+ Subscrición a los estados de Bloc
  late StreamSubscription<CategoryProductsState> streamSubscription;

  @override
  void initState() {
    super.initState();

    //+ Calculamos el ancho de cada indice en el paginador
    this.itemWidth = (widget.size.width / 2) /
        (widget.itemsCounter > 3 ? 3 : widget.itemsCounter);

    //+ Calculamos el número de paginadores
    this.pagingsCount = (widget.itemsCounter / 10).round();

    //+ Nos suscribimos a los cambios de estado del bloc
    this.streamSubscription = widget.categoryProductsBloc.stream
        .listen((CategoryProductsState state) {
      setState(() {
        if (state is CategoryProductsPackedState) {
          //+ Calculamos el ancho de cada indice en el paginador
          this.itemWidth = (widget.size.width / 2) /
              (state.itemsCounter! > 3 ? 3 : state.itemsCounter!);

          //+ Calculamos el número de paginadores
          this.pagingsCount = (state.itemsCounter! / 10).ceil();
        }
      });
    });
  }

  @override
  void dispose() {
    //+ Nos desuscribimos a los cambios de estado del bloc
    this.streamSubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      decoration: BoxDecoration(
          color: AppColors.gray30Color, borderRadius: BorderRadius.circular(8)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: () => {
              this.setState(() {
                //+ Calculamos el indice actual
                this.currentIndex =
                    this.currentIndex - 1 < 1 ? 1 : this.currentIndex - 1;

                //+ Hacemos la animación del paginador
                if (this.currentIndex > 2) {
                  this._controller.animateTo(
                      this._controller.offset - this.itemWidth,
                      duration: const Duration(milliseconds: 500),
                      curve: Curves.easeInOut);
                }

                //+ Notificamos el cambio de paginado
                widget.categoryProductsBloc.changePagination(this.currentIndex);
              })
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Text('Anterior',
                  style: AppFonts.labelTextHeavy(
                      color: AppColors.gray100Color, fontFamily: 'Ubuntu')),
            ),
          ),
          Container(
            width: widget.size.width / 2,
            decoration: const BoxDecoration(color: AppColors.gray25Color),
            child: ListView.builder(
                controller: _controller,
                itemCount: this.pagingsCount,
                physics: const BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                itemBuilder: (BuildContext context, int i) => GestureDetector(
                      onTap: () {
                        this.setState(() {
                          //+ Establecemos el indice actual
                          this.currentIndex = i + 1;
                        });

                        //+ Notificamos el cambio del indice
                        widget.categoryProductsBloc
                            .changePagination(this.currentIndex);
                      },
                      child: Container(
                        width: this.itemWidth,
                        decoration: BoxDecoration(
                            color: currentIndex == (i + 1)
                                ? AppColors.gray20Color
                                : AppColors.gray35Color),
                        child: Center(
                          child: Text('${i + 1}',
                              style: AppFonts.titleHeavy(
                                  color: AppColors.gray100Color,
                                  fontFamily: 'Ubuntu')),
                        ),
                      ),
                    )),
          ),
          GestureDetector(
            onTap: () => {
              this.setState(() {
                //+ Calculamos el indice actual
                this.currentIndex = this.currentIndex + 1 > this.pagingsCount
                    ? this.pagingsCount
                    : this.currentIndex + 1;

                //+ Hacemos la animación del paginador
                if (this.currentIndex > 3) {
                  this._controller.animateTo(
                      this._controller.offset + this.itemWidth,
                      duration: const Duration(milliseconds: 500),
                      curve: Curves.easeInOut);
                }

                //+ Notificamos el cambio del indice
                widget.categoryProductsBloc.changePagination(this.currentIndex);
              })
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Text('Siguiente',
                  style: AppFonts.labelTextHeavy(
                      color: AppColors.gray100Color, fontFamily: 'Ubuntu')),
            ),
          )
        ],
      ),
    );
  }
}

class ScreenCategoriesResultHeader extends StatelessWidget {
  final int itemsCounter;
  final Category category;

  const ScreenCategoriesResultHeader(
      {super.key, required this.itemsCounter, required this.category});

  @override
  Widget build(BuildContext context) {
    final navigationModel = Provider.of<NavigationModel>(context);

    return Container(
      decoration: BoxDecoration(
          color: AppColors.black30Color,
          border: Border.all(width: 1, color: AppColors.gray10Color)),
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(4),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  navigationModel.paramsPage['category'].nameFo,
                  style: AppFonts.labelTextLight(
                      color: AppColors.gray85Color, fontFamily: 'Ubuntu'),
                ),
                Text(
                  'Resultados (${this.itemsCounter})',
                  style: AppFonts.mainTextHeavy(
                      color: AppColors.gray85Color, fontFamily: 'Ubuntu'),
                )
              ],
            ),
          ),
          Container(
            decoration: const BoxDecoration(
              border: Border(
                  top: BorderSide(width: 1, color: AppColors.gray10Color)),
            ),
            padding: const EdgeInsets.all(6),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  GestureDetector(
                    onTap: () => {
                      showDialog(
                          context: context,
                          builder: (BuildContext context) =>
                              SingleChildScrollView(
                                  child: UIAccordionFilters(
                                filters: this.category.cardFiltersFo,
                                onPressedFunc: () => {Navigator.pop(context)},
                              )))
                    },
                    child: Row(
                      children: <Widget>[
                        const Icon(Icons.filter_list),
                        Text(
                          'Filtrar',
                          style: AppFonts.labelTextHeavy(
                              color: AppColors.gray100Color,
                              fontFamily: 'Ubuntu'),
                        )
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () => {
                      showDialog(
                          context: context,
                          builder: (BuildContext context) =>
                              SingleChildScrollView(
                                  child: CoreUIInputSelectToggle(
                                optionsList: const [
                                  InputSelectToggle(
                                      id: '1', label: 'Precio, mayor a menor'),
                                  InputSelectToggle(
                                      id: '1', label: 'Precio, menos a mayor'),
                                  InputSelectToggle(
                                      id: '1', label: 'Relevancia'),
                                  InputSelectToggle(
                                      id: '1', label: 'Más reciente'),
                                  InputSelectToggle(
                                      id: '1', label: 'Nombre, creciente'),
                                  InputSelectToggle(
                                      id: '1', label: 'Nombre, decreciente'),
                                  InputSelectToggle(
                                      id: '1', label: 'Descuento'),
                                ],
                                onPressedFunc: () => {Navigator.pop(context)},
                              )))
                    },
                    child: Row(
                      children: <Widget>[
                        const Icon(Icons.sort),
                        Text(
                          'Ordenar',
                          style: AppFonts.labelTextHeavy(
                              color: AppColors.gray100Color,
                              fontFamily: 'Ubuntu'),
                        )
                      ],
                    ),
                  )
                ]),
          )
        ],
      ),
    );
  }
}

class AnimatedLoadingCard extends StatefulWidget {
  const AnimatedLoadingCard({
    super.key,
  });

  @override
  State<AnimatedLoadingCard> createState() => _AnimatedLoadingCardState();
}

class _AnimatedLoadingCardState extends State<AnimatedLoadingCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Color?> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800), // Duración de la animación
    );
    _animation = ColorTween(
      begin: AppColors.gray45Color,
      end: AppColors.black30Color,
    ).animate(_controller);
    _controller.repeat(reverse: true); // Repetir la animación de ida y vuelta
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (BuildContext context, _) {
        return Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.bottomLeft,
                end: Alignment.centerRight,
                colors: [
                  _animation.value!
                      .withOpacity(0.5), // Color del fondo con opacidad
                  _animation.value!.withOpacity(0.75),
                  _animation.value!, // Color del fondo
                ],
              ),
              borderRadius: const BorderRadius.all(Radius.circular(4))),
        );
      },
    );
  }

  @override
  void dispose() {
    _controller.dispose(); // Liberar recursos al finalizar
    super.dispose();
  }
}
