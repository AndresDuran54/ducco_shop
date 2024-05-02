//+ DOMAIN
import 'package:ducco_shop/lib_core_domain/entities/customers_domain.dart';
import 'package:ducco_shop/lib_core_sdks/entities/customers.sdk.dart';
import 'package:ducco_shop/lib_core_sdks/sdks/customers_sdk.dart';

class CustomersDomainService {
  static final CustomersSDKService _customersSDKService =
      CustomersSDKService.customersSDKService;

  //+ Constructor nombrado
  CustomersDomainService._internal();

  //+ Instancia única de la clase
  static final CustomersDomainService _customersDomainService =
      CustomersDomainService._internal();

  //+ Getter para la instancia única
  static CustomersDomainService get customersDomainService =>
      _customersDomainService;

  //+ Obtenemos los productos
  Future<dynamic> customersNewItem(
      {Map<String, String>? headers, Map<String, dynamic>? body}) async {
    try {
      //+ Obtenemos los productos
      final SDKCustomersNewItem response = await _customersSDKService
          .customersNewItem(headers: headers, body: body);

      //+ Parseamos los customers
      return CustomersNewItem(item: Customer.fromJson(response.item));
    } catch (error) {
      print((error as SDKCustomersNewItemError).messageId);
      switch ((error as SDKCustomersNewItemError).messageId) {
        case "ERR_CUSTOMER_EMAIL_ALREADY_EXISTS":
          print("ERR_CUSTOMER_EMAIL_ALREADY_EXISTS");
          break;
        default:
      }
    }
  }
}
