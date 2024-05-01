//+ DOMAIN
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
    'customers': {'newItem': '${env.MICROS.CUSTOMERS.HOST}/v1/customers'}
  };

  //+ Crear un nuevo cliente
  Future<dynamic> customersNewItem(
      {Map<String, String>? headers, Map<String, String>? body}) async {
    try {
      //+ Obtenemos los registro de los productos
      final response = await _httpClientService.post(
          '${urls['customers']!['newItem']}',
          headers: headers,
          body: body);

      //+ Construimos la response
      return SDKCustomersNewItem(
        item: response.body['data']['item'],
      );
    } catch (error) {
      return SDKCustomersNewItemError(error.toString());
    }
  }
}
