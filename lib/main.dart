import 'package:ducco_shop/lib_bloc/module.dart';
import 'package:ducco_shop/modules/auth/info/info.dart';
import 'package:ducco_shop/modules/auth/login/login.dart';
import 'package:ducco_shop/modules/overview.dart';
import 'package:flutter/material.dart';

import 'package:ducco_shop/modules/products/module.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ducco_shop/lib_shares/services/http-client.service.dart';

void main() {
  runApp(MultiBlocProvider(providers: [
    BlocProvider<ShoppingCartBloc>(
        create: (BuildContext context) => new ShoppingCartBloc()),
    BlocProvider<CategoryProductsBloc>(
        create: (BuildContext context) => new CategoryProductsBloc()),
    BlocProvider<CustomerBloc>(
        create: (BuildContext context) => new CustomerBloc()),
  ], child: MyApp()));
}

class MyApp extends StatelessWidget {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    HttpClientService.start(context);

    return MaterialApp(
      title: 'Ducco Shop',
      initialRoute: '/auth/info',
      debugShowCheckedModeBanner: false,
      navigatorKey: navigatorKey,
      routes: {
        /* 
              FUTURE BUILDER
            */
        '/auth/info': (BuildContext context) => const FutureSessionInfoScreen(),
        /* 
              AUTH
            */
        '/auth/login': (BuildContext context) => const LoginScreen(),
        /*
              HOME
            */
        '/home/overview': (BuildContext context) => const Overview(),
        /*
              HOME
            */
        '/home/product_detail': (BuildContext context) =>
            const ProductDetailScreen(),
      },
    );
  }
}
