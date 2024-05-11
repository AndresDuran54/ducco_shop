//+ DOMAIN
import 'dart:convert';

import 'package:ducco_shop/lib_core_domain/domain/env_domain.dart';
import 'package:ducco_shop/lib_core_sdks/entities/customers.sdk.dart';

//+ SHARES
import 'package:ducco_shop/lib_shares/services/http-client.service.dart';

class CustomersSDKService {
  //+ Instancia de dio
  static final HttpClientService _httpClientService =
      HttpClientService.httpClientService;

  //+ Constructor nombrado
  CustomersSDKService._internal();

  //+ Instancia única de la clase
  static final CustomersSDKService _customersSDKService =
      CustomersSDKService._internal();

  //+ Getter para la instancia única
  static CustomersSDKService get customersSDKService => _customersSDKService;

  //+ URLS del microservicio
  final Map<String, Map<String, String>> urls = {
    //+ CUSTOMERS
    'customers': {'newItem': '${env.MICROS.CUSTOMERS.HOST}/v1/customers'},
    //+ SESSIONS
    'sessions': {'login': '${env.MICROS.CUSTOMERS.HOST}/v1/sessions/login'}
  };

  //+ Crear un nuevo cliente
  Future<SDKCustomersNewItem> customersNewItem(
      {Map<String, String>? headers, Map<String, dynamic>? body}) async {
    try {
      //+ Obtenemos los registro de los productos
      final response = await _httpClientService.post(
          '${urls['customers']!['newItem']}',
          headers: headers,
          body: body);

      //+ Construimos la response
      return SDKCustomersNewItem(
        item: response.body['data']['item'],
        session: response.body['data']['session'],
      );
    } on HttpError catch (e) {
      throw new SDKDataError.fromJson(json.decode(e.data));
    } catch (error) {
      throw new SDKDataError.fromJson(json.decode(error.toString()));
    }
  }

  //+ Loguearte
  Future<SDKSessionsLogin> sessionsLogin(
      {Map<String, String>? headers, Map<String, dynamic>? body}) async {
    try {
      //+ Obtenemos los registro de los productos
      final response = await _httpClientService
          .post('${urls['sessions']!['login']}', headers: headers, body: body);

      //+ Construimos la response
      return SDKSessionsLogin(
        item: response.body['data']['item'],
        customer: response.body['data']['customer'],
      );
    } on HttpError catch (e) {
      throw new SDKDataError.fromJson(json.decode(e.data));
    } catch (error) {
      throw new SDKDataError.fromJson(json.decode(error.toString()));
    }
  }
}
