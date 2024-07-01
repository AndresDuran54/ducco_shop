import 'package:ducco_shop/lib_core_domain/entities/products_domain.dart';

//+ Clase padre para los eventos
abstract class ShoppingCartEvent {
  //+ Constructor
  const ShoppingCartEvent();
}

//+ Evento para agregar un producto al carrito
class ShoppingCartAddProductEvent extends ShoppingCartEvent {
  final Product product;
  final int quantity;

  //+ Constructor
  const ShoppingCartAddProductEvent({
    required this.product,
    required this.quantity,
  });
}

//+ Evento para remover un producto del carrito
class ShoppingCartRemoveProductEvent extends ShoppingCartEvent {
  final int indexProduct;

  //+ Constructor
  const ShoppingCartRemoveProductEvent({
    required this.indexProduct,
  });
}

//+ Evento para aumentar cantidad de un producto del carrito de compras
class ShoppingCartPlusProductEvent extends ShoppingCartEvent {
  final int indexProduct;

  //+ Constructor
  const ShoppingCartPlusProductEvent({
    required this.indexProduct,
  });
}

//+ Evento para disminuir cantidad de un producto del carrito de compras
class ShoppingCartLessProductEvent extends ShoppingCartEvent {
  final int indexProduct;

  //+ Constructor
  const ShoppingCartLessProductEvent({
    required this.indexProduct,
  });
}

//+ Evento de error en la obtención de los registros de los productos
class ShoppingCartErrorEvent extends ShoppingCartEvent {
  //+ Constructor
  const ShoppingCartErrorEvent();
}

//+ Evento para resetear el carrito después de realizar un pedido
class ShoppingCartRestartEvent extends ShoppingCartEvent {
  //+ Constructor
  const ShoppingCartRestartEvent();
}
