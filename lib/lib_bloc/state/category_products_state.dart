import 'package:ducco_shop/lib_core_domain/entities/products_domain.dart';

//+ Clase padre para los estados realizados con los productos por categoría
class CategoryProductsState {
  //+ Lista para almacenar los productos de la vista actual
  final List<Product>? products;
  //+ Cantidad total de los productos por el filtro
  final int? itemsCounter;
  //+ Filtros actuales
  final List<Map<String, String>>? filters;
  //+ Filtros actuales
  final List<Map<String, String>>? orders;
  //+ Indice de páginado actual
  int? pagingIndex;
  //+ Tamaño de páginado actual
  int? pagingSize;

  //+ Constructor
  CategoryProductsState(
      {required this.products,
      required this.itemsCounter,
      required this.filters,
      required this.orders,
      required this.pagingIndex,
      required this.pagingSize});
}

//+ Estado que los products están cargando
class CategoryProductsLoadingState extends CategoryProductsState {
  //+ Constructor
  CategoryProductsLoadingState({
    required int pagingIndex,
    required int pagingSize,
    required int itemsCounter,
  }) : super(
            products: [],
            itemsCounter: itemsCounter,
            filters: [],
            orders: [],
            pagingIndex: pagingIndex,
            pagingSize: pagingSize);
}

//+ Estado que indica los products ya cargaron
class CategoryProductsPackedState extends CategoryProductsState {
  //+ Constructor
  CategoryProductsPackedState({
    required List<Product> products,
    required int itemsCounter,
    required List<Map<String, String>> filters,
    required List<Map<String, String>> orders,
    required int pagingIndex,
    required int pagingSize,
  }) : super(
            products: products,
            itemsCounter: itemsCounter,
            filters: filters,
            orders: orders,
            pagingIndex: pagingIndex,
            pagingSize: pagingSize);
}
