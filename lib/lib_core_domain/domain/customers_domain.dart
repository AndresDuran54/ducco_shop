//+ DOMAIN
import 'package:ducco_shop/lib_core_domain/entities/customers_domain.dart';
import 'package:ducco_shop/lib_core_sdks/entities/customers.sdk.dart';
import 'package:ducco_shop/lib_core_sdks/sdks/customers_sdk.dart';

class CategoriesDomainService {
  static final CustomersSDKService _customersSDKService =
      CustomersSDKService.customersSDKService;

  //+ Constructor nombrado
  CategoriesDomainService._internal();

  //+ Instancia única de la clase
  static final CategoriesDomainService _customersDomainService =
      CategoriesDomainService._internal();

  //+ Getter para la instancia única
  static CategoriesDomainService get customersDomainService =>
      _customersDomainService;

  //+ Obtenemos los productos
  Future<CustomersNewItem> customersNewItem(
      {Map<String, String>? headers, Map<String, String>? body}) async {
    try {
      //+ Obtenemos los productos
      final SDKCustomersNewItem response = await _customersSDKService
          .customersNewItem(headers: headers, body: body);
      //+ Parseamos los customers
      return CustomersNewItem(item: Customer.fromJson(response.item));
    } catch (error) {
      throw CustomersNewItemError(error.toString());
    }
  }
}
