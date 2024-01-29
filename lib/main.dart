import 'package:ducco_shop/lib_bloc/bloc/products_bloc.dart';
import 'package:ducco_shop/modules/auth/login/login.dart';
import 'package:ducco_shop/modules/overview.dart';
import 'package:flutter/material.dart';

import 'package:ducco_shop/modules/products/module.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(MultiBlocProvider(providers: [
    BlocProvider(create: (BuildContext context) => new ProductsBloc())
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ducco Shop',
      initialRoute: '/home/overview',
      debugShowCheckedModeBanner: false,
      routes: {
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
