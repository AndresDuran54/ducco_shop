// ignore_for_file: constant_identifier_names

//+ LIB CORE UI
import 'package:ducco_shop/lib_core_ui/ui_toast/module.dart';

//+ FLUTTER
import 'package:flutter/material.dart';

class ToastConfirmService {
  //+ Constructor nombrado
  ToastConfirmService._internal();

  //+ Instancia única de la clase
  static final ToastConfirmService _toastConfirmService =
      ToastConfirmService._internal();

  //+ Getter para la instancia única
  static ToastConfirmService get toastConfirmService => _toastConfirmService;

  /// Método para abrir el toast
  void showToast(
      BuildContext context,
      String title,
      String message,
      ToastConfirmServiceType toastServiceType,
      void Function()? onCancelPressedFunc,
      void Function()? onConfirmPressedFunc) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return CoreUIConfirmToast(
            title: title,
            message: message,
            toastServiceType: toastServiceType,
            onCancelPressedFunc: onCancelPressedFunc,
            onConfirmPressedFunc: onConfirmPressedFunc,
          );
        });
  }
}
