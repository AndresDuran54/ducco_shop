//+ Clase padre para los eventos
import 'package:ducco_shop/lib_core_domain/module.dart';

abstract class CustomerState {
  //+ Indica si el player inicio sesión
  final bool loggedIn;

  //+ Registro del customer en caso haya iniciado sesión
  Customer? customer;

  //+ Constructor
  CustomerState({required this.loggedIn, this.customer});
}

//+ Clase padre para los eventos
class CustomerEventInit extends CustomerState {
  //+ Constructor
  CustomerEventInit({
    required bool loggedIn,
    Customer? customer,
  }) : super(loggedIn: loggedIn, customer: customer);
}
