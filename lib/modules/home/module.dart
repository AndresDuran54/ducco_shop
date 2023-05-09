import 'package:ducco_shop/modules/home/overview/overview.dart';
import 'package:flutter/material.dart';

class HomeModule extends StatelessWidget {
  const HomeModule({super.key});

  @override
  Widget build(BuildContext context) {
    return Navigator(
      initialRoute: 'products',
      onGenerateRoute: (RouteSettings settings) {
        WidgetBuilder builder;
        switch (settings.name) {
          case 'products':
            builder = (BuildContext context) => const OverviewScreen();
            break;
          default:
            throw Exception('Invalid route: ${settings.name}');
        }
        return MaterialPageRoute(builder: builder, settings: settings);
      },
    );
  }
}
