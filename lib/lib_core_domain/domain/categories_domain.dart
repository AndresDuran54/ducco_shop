//+ DOMAIN
import 'package:ducco_shop/lib_core_domain/entities/categories_domain.dart';
import 'package:ducco_shop/lib_core_sdks/entities/categories.sdk.dart';
import 'package:ducco_shop/lib_core_sdks/sdks/categories_sdk.dart';

class CategoriesDomainService {
  static final CategoriesSDKService _categoriesSDKService =
      CategoriesSDKService.categoriesSDKService;

  //+ Constructor nombrado
  CategoriesDomainService._internal();

  //+ Instancia única de la clase
  static final CategoriesDomainService _categoriesDomainService =
      CategoriesDomainService._internal();

  //+ Getter para la instancia única
  static CategoriesDomainService get categoriesDomainService =>
      _categoriesDomainService;

  //+ Obtenemos los productos
  Future<CategoriesGetItems> categoriesGetItems(
      {Map<String, String>? headers}) async {
    try {
      //+ Obtenemos los productos
      final SDKCategoriesGetItems response =
          await _categoriesSDKService.categoriesGetItems(headers: headers);
      //+ Parseamos los categories
      return CategoriesGetItems(
        items: List<Category>.from(
            response.items.map((x) => Category.fromJson(x))),
        // items: [],
        itemsCounter: response.itemsCounter,
        itemsCounterTotal: response.itemsCounterTotal,
      );
    } catch (error) {
      throw CategoriesGetItemsError(error.toString());
    }
  }
}
