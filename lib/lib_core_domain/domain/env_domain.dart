// ignore_for_file: non_constant_identifier_names

import 'package:ducco_shop/lib_core_domain/domain/env_categories_domain.dart';
import 'package:ducco_shop/lib_core_domain/domain/env_customers_domain.dart';
import 'package:ducco_shop/lib_core_domain/domain/env_products_domain.dart';

class IEnvDomainMicros {
  final IEnvDomainMicrosProducts PRODUCTS;
  final IEnvDomainMicrosCategories CATEGORIES;
  final IEnvDomainMicrosCustomers CUSTOMERS;

  const IEnvDomainMicros(
      {required this.PRODUCTS,
      required this.CATEGORIES,
      required this.CUSTOMERS});
}

class IEnvDomain {
  final IEnvDomainMicros MICROS;

  const IEnvDomain({required this.MICROS});
}

IEnvDomain env = const IEnvDomain(
    MICROS: IEnvDomainMicros(
        PRODUCTS: IEnvDomainMicrosProducts(
            HOST: "http://10.0.2.2:8080",
            VARS: IEnvDomainMicrosProductsVars(CURRENCY_SYMBOL: 'S/.')),
        CATEGORIES: IEnvDomainMicrosCategories(
            HOST: 'http://10.0.2.2:8090',
            VARS: IEnvDomainMicrosCategoriesVars()),
        CUSTOMERS: IEnvDomainMicrosCustomers(
            HOST: 'http://10.0.2.2:8100',
            VARS: IEnvDomainMicrosCustomersVars())));
