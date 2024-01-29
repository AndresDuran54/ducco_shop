//+ FLUTTER
import 'package:flutter/material.dart';

//+ UTILS
import 'package:ducco_shop/utils/colors/colors.dart';
import 'package:ducco_shop/utils/fonts/fonts.dart';

//+ LIB CORE UI
import 'package:ducco_shop/lib_core_ui/ui_accordion/module.dart';
import 'package:ducco_shop/lib_core_ui/ui_inputs/module.dart';

class ScreenCategoriesResult extends StatelessWidget {
  const ScreenCategoriesResult({super.key});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.all(8),
      child: ListView(
        children: <Widget>[
          const SizedBox(
            height: 15,
          ),
          const ScreenCategoriesResultHeader(),
          const SizedBox(
            height: 15,
          ),
          // ScreenCategoriesResultBody(size: size),
          const SizedBox(
            height: 15,
          ),
          ScreenCategoriesResultPaginator(size: size)
        ],
      ),
    );
  }
}

class ScreenCategoriesResultPaginator extends StatefulWidget {
  const ScreenCategoriesResultPaginator({
    super.key,
    required this.size,
  });

  final Size size;

  @override
  State<ScreenCategoriesResultPaginator> createState() =>
      _ScreenCategoriesResultPaginatorState();
}

class _ScreenCategoriesResultPaginatorState
    extends State<ScreenCategoriesResultPaginator> {
  final ScrollController _controller = ScrollController();
  int currentIndex = 1;
  int itemCount = 7;
  late double itemWidth;

  @override
  void initState() {
    super.initState();

    this.itemWidth =
        (widget.size.width / 2) / (this.itemCount > 3 ? 3 : this.itemCount);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: widget.size.width / 1.2,
      decoration: BoxDecoration(
          color: AppColors.gray30Color, borderRadius: BorderRadius.circular(8)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: () => {
              this.setState(() {
                this.currentIndex =
                    this.currentIndex - 1 < 1 ? 1 : this.currentIndex - 1;
                if (this.currentIndex > 2) {
                  this._controller.animateTo(
                      this._controller.offset - this.itemWidth,
                      duration: const Duration(milliseconds: 500),
                      curve: Curves.easeInOut);
                }
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
                itemCount: itemCount,
                physics: const BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                itemBuilder: (BuildContext context, int i) => GestureDetector(
                      onTap: () => {
                        this.setState(() {
                          this.currentIndex = i + 1;
                        })
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
                this.currentIndex = this.currentIndex + 1 > this.itemCount
                    ? this.itemCount
                    : this.currentIndex + 1;
                if (this.currentIndex > 3) {
                  this._controller.animateTo(
                      this._controller.offset + this.itemWidth,
                      duration: const Duration(milliseconds: 500),
                      curve: Curves.easeInOut);
                }
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

// class ScreenCategoriesResultBody extends StatelessWidget {
//   final int itemCount = 5;

//   const ScreenCategoriesResultBody({
//     super.key,
//     required this.size,
//   });

//   final Size size;

//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       height:
//           ((itemCount / 2).ceil()) * 300 + ((itemCount / 2).ceil() - 1) * 15,
//       child: GridView.builder(
//           physics: const NeverScrollableScrollPhysics(),
//           itemCount: itemCount,
//           gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//               crossAxisCount: 2,
//               mainAxisSpacing: 15,
//               crossAxisSpacing: 15,
//               mainAxisExtent: 300),
//           itemBuilder: (BuildContext context, int index) =>
//               ProductCard(size: size)),
//     );
//   }
// }

class ScreenCategoriesResultHeader extends StatelessWidget {
  const ScreenCategoriesResultHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
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
                  'Celulares y Teléfonos',
                  style: AppFonts.labelTextLight(
                      color: AppColors.gray85Color, fontFamily: 'Ubuntu'),
                ),
                Text(
                  'Resultados (5588)',
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
                                  child: UIAccordion(
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
