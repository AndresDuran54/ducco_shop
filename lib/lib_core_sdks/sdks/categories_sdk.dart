//+ DOMAIN
import 'package:ducco_shop/lib_core_domain/domain/env_domain.dart';
import 'package:ducco_shop/lib_core_sdks/entities/categories.sdk.dart';

//+ SHARES
import 'package:ducco_shop/lib_shares/services/http-client.service.dart';

class CategoriesSDKService {
  //+ Instancia de dio
  static final HttpClientService _httpClientService =
      HttpClientService.httpClientService;

  //+ Constructor nombrado
  CategoriesSDKService._internal();

  //+ Instancia única de la clase
  static final CategoriesSDKService _categoriesSDKService =
      CategoriesSDKService._internal();

  //+ Getter para la instancia única
  static CategoriesSDKService get categoriesSDKService => _categoriesSDKService;

  //+ URLS del microservicio
  final Map<String, Map<String, String>> urls = {
    'categories': {'getItems': '${env.MICROS.CATEGORIES.HOST}/v1/categories'}
  };

  //+ Obtenemos las categorías
  Future<dynamic> categoriesGetItems({Map<String, String>? headers}) async {
    try {
      //+ Obtenemos los registro de los productos
      final response = await _httpClientService
          .get('${urls['categories']!['getItems']}', headers: headers);

      //+ Construimos la response
      return SDKCategoriesGetItems(
          items: response.body['data']['items'],
          itemsCounter: response.body['data']['itemsCounter'],
          itemsCounterTotal: response.body['data']['itemsCounterTotal']);
    } catch (error) {
      return SDKCategoriesGetItemsError(error.toString());
    }
  }
}
