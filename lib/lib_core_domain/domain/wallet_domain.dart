//+ DOMAIN
import 'package:ducco_shop/lib_core_domain/entities/wallet_domain.dart';
import 'package:ducco_shop/lib_core_sdks/entities/wallets.sdk.dart';
import 'package:ducco_shop/lib_core_sdks/sdks/wallet_sdk.dart';
import 'package:ducco_shop/lib_core_ui/ui_toast/module.dart';

//+ LIB SHARES
import 'package:ducco_shop/lib_shares/services/toast.service.dart';

//+ FLUTTER
import 'package:flutter/material.dart';

class WalletDomainService {
  static final WalletSDKService _walletSDKService =
      WalletSDKService.walletSDKService;

  //+ Servicio del toast
  static final ToastService _toastService = ToastService.toastService;

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
      {required BuildContext context, Map<String, String>? headers}) async {
    try {
      //+ Obtenemos los productos
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
    }
  }

  //+ ORDERS

  //+ Creamos una nueva orden
  Future<dynamic> ordersNewItem(
      {required BuildContext context,
      Map<String, String>? headers,
      Map<String, dynamic>? body}) async {
    try {
      //+ Creamos el nuevo producto
      final SDKOrdersNewItem response =
          await _walletSDKService.ordersNewItem(headers: headers, body: body);

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
      {required BuildContext context,
      Map<String, String>? headers,
      Map<String, dynamic>? body}) async {
    try {
      //+ Creamos el nuevo producto
      final SDKParametersItem response =
          await _walletSDKService.parameterItem(headers: headers, body: body);

      //+ Parseamos la orden
      return ParameterItem(item: Parameter.fromJson(response.item));
    } catch (error) {
      _toastService.showToast(context, '¡Ups! Ocurrió un error inesperado 😬',
          'Por favor, vuelva a intentarlo', ToastServiceType.ERROR);
    }
  }
}
