//+ EXTERNAL
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:ducco_shop/lib_bloc/event/products_event.dart';
import 'package:ducco_shop/lib_bloc/state/products_state.dart';

import 'package:ducco_shop/lib_core_domain/domain/products_domain.dart';
import 'package:ducco_shop/lib_core_domain/entities/products_domain.dart';

//+ Define el BLoC
class ProductsBloc extends Bloc<ProductsEvent, ProductsState> {
  //+ Servicio para la gestión de productos
  final ProductsDomainService productService =
      ProductsDomainService.productsDomainService;

  ProductsBloc()
      : super(ProductsLoadingState(
            loading: true, error: false, success: false, products: [])) {
    //+ Cargamos los productos
    this.getProducts();

    on<GetProductsEvent>(
        (GetProductsEvent event, Emitter<ProductsState> emit) => emit(
            ProductsLoadedState(
                error: false,
                loading: false,
                success: true,
                products: event.products)));

    on<GetProductsErrorEvent>(
        (GetProductsErrorEvent event, Emitter<ProductsState> emit) => emit(
            ProductsLoadedState(
                error: true, loading: false, success: false, products: [])));
  }

  //+ Método para cargar los products
  Future<void> getProducts() async {
    try {
      //+ Obtenemos los registros de los productos
      final ProductsGetItems productsResult =
          await this.productService.productsGetItems();
      //+ Agregamos el evento
      add(GetProductsEvent(products: productsResult.items));
    } catch (error) {
      //+ Agregamos el evento
      add(const GetProductsErrorEvent());
    }
  }
}
