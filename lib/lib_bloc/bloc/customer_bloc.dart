//+ LIB BLOC
import 'package:ducco_shop/lib_bloc/event/customer_event.dart';
import 'package:ducco_shop/lib_bloc/state/customer_state.dart';

//+ LIB CORE DOMAIN
import 'package:ducco_shop/lib_core_domain/module.dart';

//+ EXTERNAL
import 'package:flutter_bloc/flutter_bloc.dart';

//+ Define el BLoC
class CustomerBloc extends Bloc<CustomerEvent, CustomerState> {
  CustomerBloc() : super(CustomerEventInit(loggedIn: false)) {
    //+ CustomerLoginEvent
    on<CustomerLoginEvent>(
        (CustomerLoginEvent event, Emitter<CustomerState> emit) {
      emit(CustomerEventInit(loggedIn: true, customer: event.customer));
    });
  }

  //+ Método para remover un producto a el carrito de compras
  void customerLogin(Customer customer) {
    //+ Mandamos el evento
    add(CustomerLoginEvent(customer: customer));
  }
}
