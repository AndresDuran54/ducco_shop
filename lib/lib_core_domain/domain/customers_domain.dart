// ignore_for_file: use_build_context_synchronously

//+ LIB BLOC
import 'package:ducco_shop/lib_bloc/module.dart';

//+ LIB CORE DOMAIN
import 'package:ducco_shop/lib_core_domain/entities/customers_domain.dart';

//+ LIB CORE SDK
import 'package:ducco_shop/lib_core_sdks/entities/customers.sdk.dart';
import 'package:ducco_shop/lib_core_sdks/sdks/customers_sdk.dart';

//+ LIB CORE UI
import 'package:ducco_shop/lib_core_ui/ui_toast/module.dart';

//+ LIB SHARES
import 'package:ducco_shop/lib_shares/services/toast.service.dart';
import 'package:ducco_shop/lib_shares/services/flutter_secure_storage.dart';

//+ FLUTTER
import 'package:flutter/material.dart';

//+ EXTERNAL
import 'package:flutter_bloc/flutter_bloc.dart';

class CustomersDomainService {
  static final CustomersSDKService _customersSDKService =
      CustomersSDKService.customersSDKService;

  //+ Servicio del toast
  static final ToastService _toastService = ToastService.toastService;

  //+ Obtenemos la instancia del servicio de secure storage
  static final FlutterSecureStorageService flutterSecureStorageService =
      FlutterSecureStorageService.flutterSecureStorageService;

  //+ Constructor nombrado
  CustomersDomainService._internal();

  //+ Instancia única de la clase
  static final CustomersDomainService _customersDomainService =
      CustomersDomainService._internal();

  //+ Getter para la instancia única
  static CustomersDomainService get customersDomainService =>
      _customersDomainService;

  //+ Crear el nuevo cliente
  Future<dynamic> customersNewItem(
      {required BuildContext context,
      Map<String, String>? headers,
      Map<String, dynamic>? body,
      void Function()? onFinalizeFunc}) async {
    try {
      //+ Obtenemos los productos
      final SDKCustomersNewItem response = await _customersSDKService
          .customersNewItem(headers: headers, body: body);

      //+ Obtenemos la sesión
      final Session session = Session.fromJson(response.session);

      //+ Obtenemos el customer
      final Customer customer = Customer.fromJson(response.item);

      //+ Bloc de categorías
      final CustomerBloc customerBloc = BlocProvider.of<CustomerBloc>(context);

      //+ Actualizamos el estado en bloc
      customerBloc.customerLogin(customer);

      //+ Guardamos el token
      flutterSecureStorageService.saveData('session-token', session.token);

      //+ Navegamos al home
      if (onFinalizeFunc != null) {
        onFinalizeFunc();
      } else {
        Navigator.pushNamed(context, '/home/overview');

        _toastService.showToast(
            context,
            '¡Bienvenido ${body!["firstName"]}!',
            'Explora ya mismo nuestro catálogo de productos.',
            ToastServiceType.SUCCESS);
      }
      //+ Parseamos los customers
      return CustomersNewItem(item: customer, session: session);
    } on SDKDataError catch (e) {
      switch (e.data.messageId) {
        case "ERR_CUSTOMER_EMAIL_ALREADY_EXISTS":
          _toastService.showToast(
              context,
              'El email ya está registrado',
              'Si ya tiene una cuenta por favor inicie sesión.',
              ToastServiceType.ERROR);
          break;
        case "ERR_CUSTOMER_IDENTIFICATION_ALREADY_EXISTS":
          _toastService.showToast(
              context,
              'La identificación ya está registrada',
              'Si ya tiene una cuenta por favor inicie sesión.',
              ToastServiceType.ERROR);
          break;
        case "ERR_CUSTOMER_PHONE_ALREADY_EXISTS":
          _toastService.showToast(
              context,
              'El número celular ya está registrada',
              'Si ya tiene una cuenta por favor inicie sesión.',
              ToastServiceType.ERROR);
          break;
        default:
          _toastService.showToast(context, '¡Ups! Error inesperado',
              'Vuelva a intentarlo en unos segundos.', ToastServiceType.ERROR);
          break;
      }
    } catch (error) {
      _toastService.showToast(context, '¡Ups! Error inesperado',
          'Vuelva a intentarlo en unos segundos.', ToastServiceType.ERROR);
    }
  }

  //+ Crear nueva sesión
  Future<dynamic> sessionsLogin(
      {required BuildContext context,
      Map<String, String>? headers,
      Map<String, dynamic>? body}) async {
    try {
      //+ Obtenemos los productos
      final SDKSessionsLogin response = await _customersSDKService
          .sessionsLogin(headers: headers, body: body);

      //+ Parseamos los customers
      final sessionLogin = SessionLogin(
          item: Session.fromJson(response.item),
          customer: Customer.fromJson(response.customer));

      //+ Navegamos al home
      Navigator.pushNamed(context, '/home/overview');

      _toastService.showToast(
          context,
          '¡Bienvenido ${sessionLogin.customer.firstName}!',
          'Explora ya mismo nuestro catálogo de productos.',
          ToastServiceType.SUCCESS);

      //+ Bloc de categorías
      final CustomerBloc customerBloc = BlocProvider.of<CustomerBloc>(context);

      //+ Actualizamos el estado en bloc
      customerBloc.customerLogin(sessionLogin.customer);

      //+ Guardamos el token
      flutterSecureStorageService.saveData(
          'session-token', sessionLogin.item.token);

      return sessionLogin;
    } on SDKDataError catch (e) {
      switch (e.data.messageId) {
        default:
          _toastService.showToast(context, 'Credenciales incorrectas',
              'Vuelva a intentarlo nuevamente.', ToastServiceType.ERROR);
          break;
      }
    } catch (error) {
      _toastService.showToast(context, '¡Ups! Error inesperado',
          'Vuelva a intentarlo en unos segundos.', ToastServiceType.ERROR);
    }
  }

  //+ Obtener información de la sesión
  Future<dynamic> sessionsInfo({required BuildContext context}) async {
    try {
      //+ Obtenemos el token de la sesión
      final String? token =
          await flutterSecureStorageService.getData('session-token');

      //+ Verificamos si no tiene token
      if (token == null) {
        throw Error();
      }

      //+ Construimos el mapa de los headers
      final Map<String, String> headers = {'token': token};

      //+ Obtenemos los productos
      final SDKSessionsInfo response =
          await _customersSDKService.sessionsInfo(headers: headers);

      //+ Parseamos los customers
      final sessionInfo = SessionInfo(
          item: Session.fromJson(response.item),
          customer: Customer.fromJson(response.customer));

      _toastService.showToast(
          context,
          '¡Bienvenido ${sessionInfo.customer.firstName}!',
          'Explora ya mismo nuestro catálogo de productos.',
          ToastServiceType.SUCCESS);

      //+ Bloc de categorías
      final CustomerBloc customerBloc = BlocProvider.of<CustomerBloc>(context);

      //+ Actualizamos el estado en bloc
      customerBloc.customerLogin(sessionInfo.customer);

      //+ Guardamos el token
      flutterSecureStorageService.saveData(
          'session-token', sessionInfo.item.token);

      return sessionInfo;
    } catch (error) {
      return null;
    }
  }
}
