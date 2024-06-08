//+ DOMAIN
import 'dart:convert';

import 'package:ducco_shop/lib_core_domain/domain/env_domain.dart';
import 'package:ducco_shop/lib_core_sdks/entities/wallets.sdk.dart';

//+ SHARES
import 'package:ducco_shop/lib_shares/services/http-client.service.dart';

class WalletSDKService {
  //+ Instancia de dio
  static final HttpClientService _httpClientService =
      HttpClientService.httpClientService;

  //+ Constructor nombrado
  WalletSDKService._internal();

  //+ Instancia única de la clase
  static final WalletSDKService _walletSDKService =
      WalletSDKService._internal();

  //+ Getter para la instancia única
  static WalletSDKService get walletSDKService => _walletSDKService;

  //+ URLS del microservicio
  final Map<String, Map<String, String>> urls = {
    //+ PAYMENT METHODS
    'payment-methods': {
      'getItems': '${env.MICROS.WALLET.HOST}/v1/payment-methods'
    },
    //+ ORDERS
    'orders': {'newItem': '${env.MICROS.WALLET.HOST}/v1/orders'},
    //+ PARAMETERS
    'parameters': {'getItem': '${env.MICROS.WALLET.HOST}/v1/parameters'},
  };

  //+ PAYMENT METHODS

  //+ Obtener los métodos de pago
  Future<dynamic> paymentMethodsItems({Map<String, String>? headers}) async {
    try {
      //+ Obtenemos los registro de los productos
      final response = await _httpClientService
          .get('${urls['payment-methods']!['getItems']}', headers: headers);

      //+ Construimos la response
      return SDKPaymentMethodsGetItems(
        items: response.body['data']['items'],
      );
    } on HttpError catch (e) {
      throw new SDKDataError.fromJson(json.decode(e.data));
    } catch (error) {
      throw new SDKDataError.fromJson(json.decode(error.toString()));
    }
  }

  //+ ORDERS

  //+ Realizar nuevo pedido
  Future<dynamic> ordersNewItem(
      {Map<String, String>? headers, Map<String, dynamic>? body}) async {
    try {
      //+ Obtenemos los registro de los productos
      final response = await _httpClientService
          .post('${urls['orders']!['newItem']}', headers: headers, body: body);

      //+ Construimos la response
      return SDKOrdersNewItem(
        item: response.body['data']['item'],
      );
    } on HttpError catch (e) {
      throw new SDKDataError.fromJson(json.decode(e.data));
    } catch (error) {
      throw new SDKDataError.fromJson(json.decode(error.toString()));
    }
  }

  //+ PARAMETERS

  //+ Obtener el registro de un parámetro
  Future<dynamic> parameterItem(
      {Map<String, String>? headers, Map<String, dynamic>? body}) async {
    try {
      //+ Obtenemos los registro de los productos
      final response = await _httpClientService.post(
          '${urls['parameters']!['getItem']}',
          headers: headers,
          body: body);

      //+ Construimos la response
      return SDKParametersItem(
        item: response.body['data']['item'],
      );
    } on HttpError catch (e) {
      throw new SDKDataError.fromJson(json.decode(e.data));
    } catch (error) {
      throw new SDKDataError.fromJson(json.decode(error.toString()));
    }
  }
}
