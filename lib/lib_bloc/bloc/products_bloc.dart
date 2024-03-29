//+ EXTERNAL
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:ducco_shop/lib_bloc/event/products_event.dart';
import 'package:ducco_shop/lib_bloc/state/products_state.dart';

import 'package:ducco_shop/lib_core_domain/entities/products_domain.dart';

//+ Define el BLoC
class ShoppingCartBloc extends Bloc<ShoppingCartEvent, ShoppingCartState> {
  ShoppingCartBloc() : super(ShoppingCartEmptyState(products: [])) {
    //+ ShoppingCartAddProductEvent
    on<ShoppingCartAddProductEvent>(
        (ShoppingCartAddProductEvent event, Emitter<ShoppingCartState> emit) {
      final List<ShoppingCardProducts> products = state.products;
      products.add(ShoppingCardProducts(
          product: event.product, quantity: event.quantity));
      emit(new ShoppingCartPackedState(
          products: products,
          subTotalAmount: this.calculateSubTotal(products)));
    });

    //+ ShoppingCartRemoveProductEvent
    on<ShoppingCartRemoveProductEvent>((ShoppingCartRemoveProductEvent event,
        Emitter<ShoppingCartState> emit) {
      final List<ShoppingCardProducts> products = state.products;
      products.removeAt(event.indexProduct);
      if (products.isEmpty) {
        emit(new ShoppingCartEmptyState(products: []));
      } else {
        emit(new ShoppingCartPackedState(
            products: products,
            subTotalAmount: this.calculateSubTotal(products)));
      }
    });

    //+ ShoppingCartPlusProductEvent
    on<ShoppingCartPlusProductEvent>(
        (ShoppingCartPlusProductEvent event, Emitter<ShoppingCartState> emit) {
      final List<ShoppingCardProducts> products = state.products;
      products[event.indexProduct].quantity += 1;
      emit(new ShoppingCartPackedState(
          products: products,
          subTotalAmount: this.calculateSubTotal(products)));
    });

    //+ ShoppingCartLessProductEvent
    on<ShoppingCartLessProductEvent>(
        (ShoppingCartLessProductEvent event, Emitter<ShoppingCartState> emit) {
      final List<ShoppingCardProducts> products = state.products;
      if (products[event.indexProduct].quantity - 1 >= 1) {
        products[event.indexProduct].quantity -= 1;
        emit(new ShoppingCartPackedState(
            products: products,
            subTotalAmount: this.calculateSubTotal(products)));
      }
    });

    on<ShoppingCartErrorEvent>(
        (ShoppingCartErrorEvent event, Emitter<ShoppingCartState> emit) =>
            emit(ShoppingCartPackedState(products: [], subTotalAmount: 0)));
  }

  //+ Método para agregar un producto a el carrito de compras
  int addProduct(Product product, int quantity) {
    //+ Mandamos el evento
    add(ShoppingCartAddProductEvent(product: product, quantity: quantity));
    return state.products.length == 1 ? 0 : state.products.length - 1;
  }

  //+ Método para remover un producto a el carrito de compras
  void removeProduct(int indexProduct) {
    //+ Mandamos el evento
    add(ShoppingCartRemoveProductEvent(indexProduct: indexProduct));
  }

  //+ Método para agregar número de productos
  void plusProduct(int indexProduct) {
    //+ Mandamos el evento
    add(ShoppingCartPlusProductEvent(indexProduct: indexProduct));
  }

  //+ Método para disminuir número de productos
  void lessProduct(int indexProduct) {
    //+ Mandamos el evento
    add(ShoppingCartLessProductEvent(indexProduct: indexProduct));
  }

  //+ Método para calcular el subTotal de la venta
  int calculateSubTotal(List<ShoppingCardProducts> products) {
    int subTotal = 0;
    for (ShoppingCardProducts p in products) {
      subTotal += p.quantity * p.product.inventoryPrice;
    }
    return subTotal;
  }

  //+ Método para disminuir número de productos
  List<dynamic> getProductCart(Product product) {
    //+ Mandamos el evento
    int indexProduct = state.products
        .indexWhere((p) => p.product.productId == product.productId);
    ShoppingCardProducts productCard = indexProduct == -1
        ? ShoppingCardProducts(product: product, quantity: 0)
        : state.products[indexProduct];
    return [productCard, indexProduct];
  }
}
