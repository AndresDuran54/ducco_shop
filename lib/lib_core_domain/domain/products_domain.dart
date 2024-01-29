//+ DOMAIN
import 'package:ducco_shop/lib_core_domain/entities/products_domain.dart';
import 'package:ducco_shop/lib_core_sdks/entities/products.sdk.dart';
import 'package:ducco_shop/lib_core_sdks/sdks/products_sdk.dart';

class ProductsDomainService {
  static final ProductsSDKService _productsSDKService =
      ProductsSDKService.productsSDKService;

  //+ Constructor nombrado
  ProductsDomainService._internal();

  //+ Instancia única de la clase
  static final ProductsDomainService _productsDomainService =
      ProductsDomainService._internal();

  //+ Getter para la instancia única
  static ProductsDomainService get productsDomainService =>
      _productsDomainService;

  //+ Obtenemos los productos
  Future<ProductsGetItems> productsGetItems(
      {Map<String, String>? headers}) async {
    try {
      //+ Obtenemos los productos
      final SDKProductsGetItems response =
          await _productsSDKService.productsGetItems(headers: headers);
      //+ Parseamos los products
      return ProductsGetItems(
        items:
            List<Product>.from(response.items.map((x) => Product.fromJson(x))),
        // items: [],
        itemsCounter: response.itemsCounter,
        itemsCounterTotal: response.itemsCounterTotal,
      );
    } catch (error) {
      throw ProductsGetItemsError(error.toString());
    }
  }
}
