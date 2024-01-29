import 'package:ducco_shop/lib_core_domain/entities/products_domain.dart';

//+ Clase padre para los eventos
abstract class ProductsEvent {
  //+ Constructor
  const ProductsEvent();
}

//+ Evento de obtención de los registros de los productos
class GetProductsEvent extends ProductsEvent {
  final List<Product> products;

  //+ Constructor
  const GetProductsEvent({
    required this.products,
  });
}

//+ Evento de error en la obtención de los registros de los productos
class GetProductsErrorEvent extends ProductsEvent {
  //+ Constructor
  const GetProductsErrorEvent();
}
