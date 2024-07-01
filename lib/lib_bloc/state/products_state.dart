import 'package:ducco_shop/lib_core_domain/entities/products_domain.dart';
import 'package:ducco_shop/lib_core_domain/module.dart';

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

  //+ Monto total de los productos
  int subTotalAmount;

  //+ Registro del customer
  Customer? customer;

  //+ Registro de la dirección del cliente
  OrderAddressCustomer? orderAddressCustomer;

  //+ Lista de los métodos de pago
  List<PaymentMethod>? paymentMethods;

  //+ Id del método de pago elegido
  int? paymentMethodId;

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
