//+ EXTERNAL
import 'package:flutter_bloc/flutter_bloc.dart';

//+ LIB BLOC
import 'package:ducco_shop/lib_bloc/event/category_products_event.dart';
import 'package:ducco_shop/lib_bloc/state/category_products_state.dart';

//+ LIB CORE DOMAIN
import 'package:ducco_shop/lib_core_domain/module.dart';

//+ Define el BLoC
class CategoryProductsBloc
    extends Bloc<CategoryProductsEvent, CategoryProductsState> {
  //+ Servicio para la gestión de productos
  final ProductsDomainService productService =
      ProductsDomainService.productsDomainService;

  CategoryProductsBloc()
      : super(CategoryProductsLoadingState(
          filters: [],
          orders: [],
          itemsCounter: 0,
          pagingSize: 10,
        )) {
    //+ CategoryProductsInitEvent
    on<CategoryProductsInitEvent>(
        (CategoryProductsInitEvent event, Emitter<CategoryProductsState> emit) {
      //+ Emitimos el nuevo evento
      emit(CategoryProductsPackedState(
          filters: event.filters!,
          itemsCounter: event.itemsCounter!,
          orders: event.orders!,
          pagingIndex: event.pagingIndex!,
          pagingSize: event.pagingSize!,
          products: event.products!));
    });

    //+ CategoryProductsChangePagingEvent
    on<CategoryProductsChangePagingEvent>(
        (CategoryProductsChangePagingEvent event,
            Emitter<CategoryProductsState> emit) {
      //+ Emitimos el nuevo evento
      emit(CategoryProductsPackedState(
          filters: state.filters!,
          orders: state.orders!,
          itemsCounter: state.itemsCounter!,
          pagingIndex: event.pagingIndex!,
          pagingSize: state.pagingSize!,
          products: event.products!));
    });

    //+ CategoryProductsLoadingEvent
    on<CategoryProductsLoadingEvent>((CategoryProductsLoadingEvent event,
        Emitter<CategoryProductsState> emit) {
      //+ Emitimos el nuevo evento
      emit(CategoryProductsLoadingState(
        filters: event.filters!,
        orders: event.orders!,
        itemsCounter: event.itemsCounter!,
        pagingSize: event.pagingSize!,
      ));
    });
  }

  //+ Método para inicializar la vista
  void initView(int categoryId) async {
    try {
      //+ Mandamos el evento para inicializar la vista
      add(CategoryProductsLoadingEvent(
          filters: [], orders: [], itemsCounter: 0, pagingSize: 10));

      //+ Construimos el filtro inicial
      final List<Map<String, String>> filters = [
        {'"filter"': '"categoryId"', '"val"': '"$categoryId"'}
      ];

      //+ Construimos el order inicial
      final List<Map<String, String>> orders = [];

      //+ Obtenemos los registros de productos
      ProductsGetItems productsItems =
          await this.productService.productsGetItems(headers: {
        'filters': filters.toString(),
        'orders': orders.toString(),
        'paging_index': '1',
        'paging_size': '10',
      });

      //+ Mandamos el evento para inicializar la vista
      add(CategoryProductsInitEvent(
        filters: filters,
        orders: orders,
        products: productsItems.items,
        itemsCounter: productsItems.itemsCounterTotal,
        pagingIndex: 1,
        pagingSize: 10,
      ));
    } catch (err) {
      //+ Mandamos el evento de error
      add(CategoryProductsErrorEvent());
    }
  }

  //+ Método para cambiar la paginación
  void changePagination(int pagingIndex) async {
    try {
      //+ Mandamos el evento para inicializar la vista
      add(CategoryProductsLoadingEvent(
        filters: state.filters!,
        orders: state.orders!,
        itemsCounter: state.itemsCounter!,
        pagingSize: state.pagingSize!,
      ));

      //+ Obtenemos los registros de productos
      ProductsGetItems productsItems =
          await this.productService.productsGetItems(headers: {
        'filters': state.filters.toString(),
        'orders': state.orders.toString(),
        'paging_index': pagingIndex.toString(),
        'paging_size': state.pagingSize.toString(),
      });

      //+ Mandamos el evento para inicializar la vista
      add(CategoryProductsChangePagingEvent(
          pagingIndex: pagingIndex, products: productsItems.items));
    } catch (err) {
      //+ Mandamos el evento de error
      add(CategoryProductsErrorEvent());
    }
  }
}
