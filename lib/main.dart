import 'package:flutter/material.dart';

import 'modules/auth/module.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ducco Shop',
      initialRoute: '/',
      debugShowCheckedModeBanner: false,
      routes: {'/': (BuildContext context) => const AuthModule()},
    );
  }
}
