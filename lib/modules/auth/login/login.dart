import 'package:flutter/material.dart';

import '../../../utils/colors/colors.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: Container(
        color: AppColors.primary10Color,
        child: _FormLogin(size: size),
      ),
    );
  }
}

class _FormLogin extends StatefulWidget {
  const _FormLogin({
    Key? key,
    required this.size,
  }) : super(key: key);

  final Size size;

  @override
  State<_FormLogin> createState() => _FormLoginState();
}

class _FormLoginState extends State<_FormLogin> {
  //Controladores de inputs
  final usernameCtrl = TextEditingController();
  final passwordCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ListView(
      physics: const ClampingScrollPhysics(),
      children: <Widget>[
        const Image(
          image: AssetImage('assets/images/logo_ducco.png'),
          height: 300,
        ),
        Center(
          child: Container(
            width: widget.size.width * 0.8,
            height: 300,
            decoration: const BoxDecoration(
              color: AppColors.gray70Color,
              borderRadius: BorderRadius.all(Radius.circular(20)),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                _InputUsernameLogin(
                    size: widget.size, usernameCtrl: usernameCtrl),
                _InputPasswordLogin(
                    size: widget.size, passwordCtrl: passwordCtrl),
                _ButtonLogin(
                    usernameCtrl: usernameCtrl,
                    passwordCtrl: passwordCtrl,
                    onPressed: () => {
                          if (usernameCtrl.text == 'root' &&
                              passwordCtrl.text == 'root')
                            {Navigator.pushNamed(context, '/home/overview')}
                        }),
              ],
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              '¿No tienes una cuenta?',
              style: TextStyle(color: AppColors.gray80Color),
            ),
            TextButton(
                onPressed: () => {print('a')},
                style: ButtonStyle(
                  overlayColor: MaterialStateProperty.all<Color>(AppColors
                      .gray30Color), // Cambia el color de superposición a amarillo
                ),
                child: const Text(
                  'Registrate',
                  style: TextStyle(color: AppColors.secondary70Color),
                ))
          ],
        )
      ],
    );
  }
}

class _InputPasswordLogin extends StatelessWidget {
  const _InputPasswordLogin({
    Key? key,
    required this.passwordCtrl,
    required this.size,
  }) : super(key: key);

  final Size size;
  final TextEditingController passwordCtrl;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size.width * 0.7,
      child: TextField(
        controller: passwordCtrl,
        obscureText: true,
        cursorColor: AppColors.gray50Color,
        decoration: const InputDecoration(
            prefixIcon: Icon(
              Icons.password,
              color: AppColors.gray50Color,
            ),
            filled: true,
            fillColor: AppColors.gray80Color,
            hintText: 'Contraseña',
            hintStyle: TextStyle(color: AppColors.gray50Color),
            border: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.all(Radius.circular(20)))),
        style: const TextStyle(color: AppColors.gray50Color),
      ),
    );
  }
}

class _InputUsernameLogin extends StatelessWidget {
  const _InputUsernameLogin({
    Key? key,
    required this.usernameCtrl,
    required this.size,
  }) : super(key: key);

  final Size size;
  final TextEditingController usernameCtrl;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size.width * 0.7,
      child: TextField(
        controller: usernameCtrl,
        cursorColor: AppColors.gray50Color,
        decoration: const InputDecoration(
            prefixIcon: Icon(
              Icons.person,
              color: AppColors.gray50Color,
            ),
            filled: true,
            fillColor: AppColors.gray80Color,
            hintText: 'Usuarios',
            hintStyle: TextStyle(color: AppColors.gray50Color),
            border: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.all(Radius.circular(20)))),
        style: const TextStyle(color: AppColors.gray50Color),
      ),
    );
  }
}

class _ButtonLogin extends StatelessWidget {
  const _ButtonLogin({
    Key? key,
    required this.onPressed,
    required this.usernameCtrl,
    required this.passwordCtrl,
  }) : super(key: key);

  final void Function() onPressed;
  final TextEditingController usernameCtrl;
  final TextEditingController passwordCtrl;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return MaterialButton(
      onPressed:
          usernameCtrl.text != '' && passwordCtrl.text != '' ? onPressed : null,
      disabledColor: AppColors.secondary20Color,
      elevation: 8,
      disabledElevation: 8,
      minWidth: size.width * 0.7,
      color: AppColors.secondary70Color,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: const SizedBox(
        height: 50,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
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
    );
  }
}
