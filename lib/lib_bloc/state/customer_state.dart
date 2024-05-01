//+ Clase padre para los eventos
abstract class CustomerState {
  final bool loggedIn;

  //+ Constructor
  const CustomerState({
    required this.loggedIn,
  });
}

//+ Clase padre para los eventos
class CustomerEventInit extends CustomerState {
  //+ Constructor
  const CustomerEventInit({
    required bool loggedIn,
  }) : super(loggedIn: loggedIn);
}
