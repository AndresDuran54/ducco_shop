import 'package:flutter/material.dart';

import '../../../utils/colors/colors.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: Container(
        color: AppColors.primary10Color,
        child: ListView(
          children: <Widget>[
            const Image(
              image: AssetImage('assets/images/logo_ducco.png'),
              height: 300,
            ),
            Center(
              child: Container(
                width: size.width * 0.8,
                height: 300,
                decoration: const BoxDecoration(
                  color: AppColors.gray70Color,
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    _InputUsernameLogin(size: size),
                    _InputPasswordLogin(size: size),
                    const _ButtonLogin(),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class _InputPasswordLogin extends StatelessWidget {
  const _InputPasswordLogin({
    Key? key,
    required this.size,
  }) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size.width * 0.7,
      child: const TextField(
        obscureText: true,
        cursorColor: AppColors.gray50Color,
        decoration: InputDecoration(
            filled: true,
            fillColor: AppColors.gray80Color,
            hintText: 'Contraseña',
            hintStyle: TextStyle(color: AppColors.gray50Color),
            border: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.all(Radius.circular(20)))),
        style: TextStyle(color: AppColors.gray50Color),
      ),
    );
  }
}

class _InputUsernameLogin extends StatelessWidget {
  const _InputUsernameLogin({
    Key? key,
    required this.size,
  }) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size.width * 0.7,
      child: const TextField(
        cursorColor: AppColors.gray50Color,
        decoration: InputDecoration(
            filled: true,
            fillColor: AppColors.gray80Color,
            hintText: 'Usuario',
            hintStyle: TextStyle(color: AppColors.gray50Color),
            border: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.all(Radius.circular(20)))),
        style: TextStyle(color: AppColors.gray50Color),
      ),
    );
  }
}

class _ButtonLogin extends StatelessWidget {
  const _ButtonLogin({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return MaterialButton(
      elevation: 8,
      minWidth: size.width * 0.6,
      color: AppColors.secondary70Color,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: SizedBox(
        height: 50,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const <Widget>[
            Text(
              'INGRESAR',
              style: TextStyle(
                color: AppColors.gray80Color,
                fontFamily: 'Roboto',
                fontWeight: FontWeight.w500,
                fontSize: 18,
              ),
              textAlign: TextAlign.center,
            )
          ],
        ),
      ),
      onPressed: () => {print('aaaa')},
    );
  }
}
