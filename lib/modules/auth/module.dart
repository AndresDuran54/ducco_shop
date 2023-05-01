import 'package:ducco_shop/modules/auth/login/login.dart';
import 'package:flutter/material.dart';

class AuthModule extends StatelessWidget {
  const AuthModule({super.key});

  @override
  Widget build(BuildContext context) {
    return Navigator(
      initialRoute: 'login',
      onGenerateRoute: (RouteSettings settings) {
        WidgetBuilder builder;
        switch (settings.name) {
          case 'login':
            builder = (BuildContext context) => const LoginScreen();
            break;
          default:
            throw Exception('Invalid route: ${settings.name}');
        }
        return MaterialPageRoute(builder: builder, settings: settings);
      },
    );
  }
}
