import 'package:ducco_shop/lib_core_domain/entities/products_domain.dart';

//+ Clase padre para los estados realizados con la gestión de productos
class ProductsState {
  final bool loading;
  final bool error;
  final bool success;
  final List<Product> products;

  //+ Constructor
  const ProductsState({
    required this.loading,
    required this.error,
    required this.success,
    required this.products,
  });

  //+ Método para copiar el estado actual
  ProductsState copyWith({
    bool? loading,
    bool? error,
    List<Product>? products,
  }) =>
      ProductsState(
          loading: loading ?? this.loading,
          error: error ?? this.error,
          success: error ?? this.success,
          products: products ?? this.products);
}

//+ Estado que indica que la aplicación actualmente está cargando datos
class ProductsLoadingState extends ProductsState {
  //+ Constructor
  ProductsLoadingState({
    required bool loading,
    required bool error,
    required bool success,
    required List<Product> products,
  }) : super(
            loading: loading,
            error: error,
            success: success,
            products: products);
}

//+ Estado que indica que la aplicación ya cargo los datos
class ProductsLoadedState extends ProductsState {
  //+ Constructor
  ProductsLoadedState({
    required bool loading,
    required bool error,
    required bool success,
    required List<Product> products,
  }) : super(
          loading: loading,
          error: error,
          success: success,
          products: products,
        );
}

// //+ Estado que indica que la aplicación obtuvo un error al cargar datos
// class ProductsErrorState extends ProductsState {
//   //+ Constructor
//   ProductsErrorState({
//     required bool loading,
//     required bool error,
//     required List<Product> products,
//   }) : super(loading: loading, error: error, products: products);
// }
