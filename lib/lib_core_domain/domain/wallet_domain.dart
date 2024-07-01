//+ DOMAIN
// ignore_for_file: use_build_context_synchronously

import 'package:ducco_shop/lib_bloc/module.dart';
import 'package:ducco_shop/lib_core_domain/entities/wallet_domain.dart';
import 'package:ducco_shop/lib_core_sdks/entities/wallets.sdk.dart';
import 'package:ducco_shop/lib_core_sdks/sdks/wallet_sdk.dart';
import 'package:ducco_shop/lib_core_ui/ui_toast/module.dart';
import 'package:ducco_shop/lib_shares/services/flutter_secure_storage.dart';

//+ LIB SHARES
import 'package:ducco_shop/lib_shares/services/toast.service.dart';

//+ FLUTTER
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WalletDomainService {
  static final WalletSDKService _walletSDKService =
      WalletSDKService.walletSDKService;

  //+ Servicio del toast
  static final ToastService _toastService = ToastService.toastService;

  //+ Obtenemos la instancia del servicio de secure storage
  static final FlutterSecureStorageService flutterSecureStorageService =
      FlutterSecureStorageService.flutterSecureStorageService;

  //+ Constructor nombrado
  WalletDomainService._internal();

  //+ Instancia única de la clase
  static final WalletDomainService _walletDomainService =
      WalletDomainService._internal();

  //+ Getter para la instancia única
  static WalletDomainService get walletDomainService => _walletDomainService;

  //+ PAYMENT METHODS

  //+ Obtenemos los métodos de pago
  Future<dynamic> paymentMethodsGetItems(
      {required BuildContext context}) async {
    try {
      //+ Obtenemos el token de la sesión
      final String token =
          await flutterSecureStorageService.getData('session-token') ?? '';

      //+ Construimos el mapa de los headers
      final Map<String, String> headers = {'token': token};

      //+ Obtenemos los métodos de pago
      final SDKPaymentMethodsGetItems response =
          await _walletSDKService.paymentMethodsItems(headers: headers);

      //+ Parseamos los wallet
      return PaymentMethodsItems(
        items: List<PaymentMethod>.from(
            response.items.map((x) => PaymentMethod.fromJson(x))),
      );
    } catch (error) {
      _toastService.showToast(context, '¡Ups! Ocurrió un error inesperado 😬',
          'Por favor, vuelva a intentarlo', ToastServiceType.ERROR);
      return PaymentMethodsItems(items: []);
    }
  }

  //+ ORDERS

  //+ Creamos una nueva orden
  Future<dynamic> ordersNewItem(
      {required BuildContext context, Map<String, dynamic>? body}) async {
    try {
      //+ Obtenemos el token de la sesión
      final String token =
          await flutterSecureStorageService.getData('session-token') ?? '';

      //+ Construimos el mapa de los headers
      final Map<String, String> headers = {'token': token};

      //+ Bloc de customer
      final ShoppingCartBloc shoppingCartBloc =
          BlocProvider.of<ShoppingCartBloc>(context);

      //+ Creamos el nuevo producto
      final SDKOrdersNewItem response =
          await _walletSDKService.ordersNewItem(headers: headers, body: body);

      //+ Reiniciamos el carrito de compras
      shoppingCartBloc.restartShoppingCart();

      //+ Ruteamos el home
      Navigator.pushNamed(context, '/home/overview');

      _toastService.showToast(
          context,
          '¡Felicidades!',
          'Tu pedido ya está en curso, nos pondremos en contacto contigo.',
          ToastServiceType.SUCCESS);

      //+ Parseamos la orden
      return OrderNewItem(item: Order.fromJson(response.item));
    } catch (error) {
      _toastService.showToast(context, '¡Ups! Ocurrió un error inesperado 😬',
          'Por favor, vuelva a intentarlo', ToastServiceType.ERROR);
    }
  }

  //+ PARAMETERS

  //+ Creamos una nueva orden
  Future<dynamic> parametersItem(
      Map<String, dynamic> params, BuildContext context) async {
    try {
      //+ Obtenemos el token de la sesión
      final String token =
          await flutterSecureStorageService.getData('session-token') ?? '';

      //+ Construimos el mapa de los headers
      final Map<String, String> headers = {'token': token};

      //+ Creamos el nuevo producto
      final SDKParametersItem response =
          await _walletSDKService.parameterItem(params, headers: headers);

      //+ Parseamos la orden
      return ParameterItem(item: Parameter.fromJson(response.item));
    } catch (error) {
      _toastService.showToast(context, '¡Ups! Ocurrió un error inesperado 😬',
          'Por favor, vuelva a intentarlo', ToastServiceType.ERROR);
      return null;
    }
  }
}
