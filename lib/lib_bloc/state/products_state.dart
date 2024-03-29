import 'package:ducco_shop/lib_core_domain/entities/products_domain.dart';

class ShoppingCardProducts {
  final Product product;
  int quantity;

  ShoppingCardProducts({
    required this.product,
    required this.quantity,
  });
}

//+ Clase padre para los estados realizados con la gestión de productos
class ShoppingCartState {
  //+ Lista para almacenar los productos y la cantidad
  final List<ShoppingCardProducts> products;
  int subTotalAmount;

  //+ Constructor
  ShoppingCartState({required this.products, this.subTotalAmount = 0});
}

//+ Estado que el carrito de compras está vació
class ShoppingCartEmptyState extends ShoppingCartState {
  //+ Constructor
  ShoppingCartEmptyState({
    required List<ShoppingCardProducts> products,
  }) : super(products: products);
}

//+ Estado que indica que el carrito tiene productos
class ShoppingCartPackedState extends ShoppingCartState {
  //+ Constructor
  ShoppingCartPackedState(
      {required List<ShoppingCardProducts> products, required subTotalAmount})
      : super(products: products, subTotalAmount: subTotalAmount);
}
