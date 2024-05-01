//+ EXTERNAL
import 'package:ducco_shop/lib_bloc/event/customer_event.dart';
import 'package:ducco_shop/lib_bloc/state/customer_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

//+ Define el BLoC
class CustomerBloc extends Bloc<CustomerEvent, CustomerState> {
  CustomerBloc() : super(const CustomerEventInit(loggedIn: false)) {}
}
