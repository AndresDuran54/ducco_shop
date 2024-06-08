import 'package:ducco_shop/lib_core_domain/domain/customers_domain.dart';
import 'package:ducco_shop/utils/colors/colors.dart';
import 'package:flutter/material.dart';

class FutureSessionInfoScreen extends StatelessWidget {
  const FutureSessionInfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final CustomersDomainService customersDomainService =
        CustomersDomainService.customersDomainService;

    return FutureBuilder(
      future: customersDomainService.sessionsInfo(context: context),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          //+ Redirigir a la nueva ruta una vez que el Future se haya completado
          WidgetsBinding.instance.addPostFrameCallback((_) {
            Navigator.pushNamedAndRemoveUntil(context, '/home/overview',
                ModalRoute.withName('/home/overview'));
          });
          //+ Mientras se carga el Future, muestra un widget de carga
          return const Scaffold(
            backgroundColor: AppColors.gray80Color,
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        } else {
          //+ Mientras se carga el Future, muestra un widget de carga
          return const Scaffold(
            backgroundColor: AppColors.gray80Color,
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
      },
    );
  }
}
