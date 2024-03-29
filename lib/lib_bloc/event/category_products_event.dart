import 'package:ducco_shop/lib_core_domain/entities/products_domain.dart';

//+ Clase padre para los eventos
abstract class CategoryProductsEvent {
  List<Map<String, String>>? filters;
  List<Map<String, String>>? orders;
  List<Product>? products;
  int? itemsCounter;
  int? pagingIndex;
  int? pagingSize;

  //+ Constructor
  CategoryProductsEvent(
      {this.products,
      this.filters,
      this.orders,
      this.itemsCounter,
      this.pagingIndex,
      this.pagingSize});
}

//+ Evento para indicar que se debe de inciar la obtención de productos
class CategoryProductsInitEvent extends CategoryProductsEvent {
  //+ Constructor
  CategoryProductsInitEvent({
    required List<Map<String, String>> filters,
    required List<Map<String, String>> orders,
    required List<Product> products,
    required int itemsCounter,
    required int pagingIndex,
    required int pagingSize,
  }) : super(
            products: products,
            filters: filters,
            orders: orders,
            itemsCounter: itemsCounter,
            pagingIndex: pagingIndex,
            pagingSize: pagingSize);
}

//+ Evento para indicar que se cambiaron los filtros
class CategoryProductsChangeFiltersEvent extends CategoryProductsEvent {
  //+ Constructor
  CategoryProductsChangeFiltersEvent(
      {required List<Map<String, String>> filters,
      required List<Map<String, String>> orders,
      required List<Product> products})
      : super(products: products, filters: filters, orders: orders);
}

//+ Evento para indicar que se cambio el orden
class CategoryProductsChangePagingEvent extends CategoryProductsEvent {
  //+ Constructor
  CategoryProductsChangePagingEvent(
      {required int pagingIndex, required List<Product> products})
      : super(pagingIndex: pagingIndex, products: products);
}

//+ Evento para indicar que se cambio la paginación
class CategoryProductsChangeOrdersEvent extends CategoryProductsEvent {
  //+ Constructor
  CategoryProductsChangeOrdersEvent(
      {required List<Map<String, String>> filters,
      required List<Map<String, String>> orders,
      required List<Product> products})
      : super(products: products, filters: filters, orders: orders);
}

//+ Evento para indicar que ocurrio un error
class CategoryProductsErrorEvent extends CategoryProductsEvent {
  //+ Constructor
  CategoryProductsErrorEvent() : super();
}
