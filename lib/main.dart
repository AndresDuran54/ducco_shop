import 'package:ducco_shop/modules/auth/login/login.dart';
import 'package:ducco_shop/modules/home/overview/overview.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ducco Shop',
      initialRoute: '/auth/login',
      debugShowCheckedModeBanner: false,
      routes: {
        /* 
          AUTH
        */
        '/auth/login': (BuildContext context) => const LoginScreen(),
        /*
          HOME
        */
        '/home/overview': (BuildContext context) => const OverviewScreen(),
      },
    );
  }
}
