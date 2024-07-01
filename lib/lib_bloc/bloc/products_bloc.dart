//+ EXTERNAL
import 'package:ducco_shop/lib_core_domain/module.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:ducco_shop/lib_bloc/event/products_event.dart';
import 'package:ducco_shop/lib_bloc/state/products_state.dart';

//+ Define el BLoC
class ShoppingCartBloc extends Bloc<ShoppingCartEvent, ShoppingCartState> {
  //+ Servicio para la gestión de ordenes
  final WalletDomainService walletDomainService =
      WalletDomainService.walletDomainService;

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

    //+ ShoppingCartRestartEvent
    on<ShoppingCartRestartEvent>(
        (ShoppingCartRestartEvent event, Emitter<ShoppingCartState> emit) {
      emit(new ShoppingCartEmptyState(products: []));
    });

    on<ShoppingCartErrorEvent>(
        (ShoppingCartErrorEvent event, Emitter<ShoppingCartState> emit) =>
            emit(ShoppingCartPackedState(products: [], subTotalAmount: 0)));
  }

  //+ Reiniciamos el carrito de compras
  void restartShoppingCart() {
    add(const ShoppingCartRestartEvent());
  }

  //+ Método para agregar un producto a el carrito de compras
  Future<int> addProduct(
      Product product, int quantity, BuildContext context) async {
    if (state.products.isEmpty) {
      ParameterItem? parameterResult = await this
          .walletDomainService
          .parametersItem({
        "paramId":
            env.MICROS.WALLET.VARS.PARAMETERS.ORDERS_DEFAULT_DELIVERY_PRICE
      }, context);

      if (parameterResult != null) {
        // print(parameterResult.item.value);
      }
    }
    //+ Mandamos el evento
    add(ShoppingCartAddProductEvent(product: product, quantity: quantity));
    return state.products.length == 1 ? 0 : state.products.length - 1;
  }

  //+ Método para asignar los datos del cliente
  void setCustomer(Customer customer) {
    state.customer = customer;
  }

  //+ Método para asignar los datos de la dirección del cliente
  void setOrderAddressCustomer(OrderAddressCustomer orderAddressCustomer) {
    state.orderAddressCustomer = orderAddressCustomer;
  }

  //+ Método para asignar los métodos de pago
  void setPaymentMethods(List<PaymentMethod> paymentMethods) {
    state.paymentMethods = paymentMethods;
  }

  //+ Método para asignar el método de pago elegido por el cliente
  void setPaymentMethodId(int paymentMethodId) {
    state.paymentMethodId = paymentMethodId;
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

  //+ Método para obtener el registro de un producto en el carrito de compras
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
