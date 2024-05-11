//+ Clase padre para los eventos

//+ LIB CORE DOMAIN
import 'package:ducco_shop/lib_core_domain/module.dart';

abstract class CustomerEvent {
  //+ Constructor
  const CustomerEvent();
}

class CustomerLoginEvent extends CustomerEvent {
  //+ Registro del customer en caso haya iniciado sesión
  final Customer customer;

  //+ Constructor
  const CustomerLoginEvent({required this.customer});
}
