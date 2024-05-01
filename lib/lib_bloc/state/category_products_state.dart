import 'package:ducco_shop/lib_core_domain/entities/products_domain.dart';

//+ Clase padre para los estados realizados con los productos por categoría
class CategoryProductsState {
  //+ Lista para almacenar los productos de la vista actual
  final List<Product>? products;
  //+ Cantidad total de los productos por el filtro
  final int? itemsCounter;
  //+ Filtros actuales
  final String? filters;
  //+ Filtros actuales
  final String? orders;
  //+ Indice de paginado actual
  int? pagingIndex;
  //+ Tamaño de paginado actual
  int? pagingSize;
  //+ Id de la categoría actual
  int categoryId;

  //+ Constructor
  CategoryProductsState(
      {this.products,
      this.itemsCounter,
      this.filters,
      this.orders,
      this.pagingIndex,
      this.pagingSize,
      required this.categoryId});
}

//+ Estado que indica los products ya cargaron
class CategoryProductsPackedState extends CategoryProductsState {
  //+ Constructor
  CategoryProductsPackedState({
    required List<Product> products,
    required int itemsCounter,
    required String filters,
    required String orders,
    required int pagingIndex,
    required int pagingSize,
    required int categoryId,
  }) : super(
            products: products,
            itemsCounter: itemsCounter,
            filters: filters,
            orders: orders,
            pagingIndex: pagingIndex,
            pagingSize: pagingSize,
            categoryId: categoryId);
}

//+ Estado que indica los products se están cargaron
class CategoryProductsLoadingState extends CategoryProductsState {
  //+ Constructor
  //+ Constructor
  CategoryProductsLoadingState({
    required String filters,
    required String orders,
    required int itemsCounter,
    required int pagingSize,
    required int categoryId,
  }) : super(
            itemsCounter: itemsCounter,
            filters: filters,
            orders: orders,
            pagingSize: pagingSize,
            categoryId: categoryId);
}
