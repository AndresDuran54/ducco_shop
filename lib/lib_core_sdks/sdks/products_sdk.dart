//+ DOMAIN
import 'package:ducco_shop/lib_core_domain/domain/env_domain.dart';
import 'package:ducco_shop/lib_core_sdks/entities/products.sdk.dart';

//+ SHARES
import 'package:ducco_shop/lib_shares/services/http-client.service.dart';

class ProductsSDKService {
  //+ Instancia de dio
  static final HttpClientService _httpClientService =
      HttpClientService.httpClientService;

  //+ Constructor nombrado
  ProductsSDKService._internal();

  //+ Instancia única de la clase
  static final ProductsSDKService _productsSDKService =
      ProductsSDKService._internal();

  //+ Getter para la instancia única
  static ProductsSDKService get productsSDKService => _productsSDKService;

  //+ URLS del microservicio
  final Map<String, Map<String, String>> urls = {
    'products': {'getItems': '${env.MICROS.PRODUCTS.HOST}/v1/products'}
  };

  //+ Obtenemos los productos
  Future<dynamic> productsGetItems({Map<String, String>? headers}) async {
    try {
      //+ Obtenemos los registro de los productos
      final response = await _httpClientService
          .get('${urls['products']!['getItems']}', headers: headers);

      //+ Construimos la response
      return SDKProductsGetItems(
          items: response.body['data']['items'],
          itemsCounter: response.body['data']['itemsCounter'],
          itemsCounterTotal: response.body['data']['itemsCounterTotal']);
    } catch (error) {
      return SDKProductsGetItemsError(error.toString());
    }
  }
}
