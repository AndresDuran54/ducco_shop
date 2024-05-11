// ignore_for_file: constant_identifier_names

import 'package:ducco_shop/lib_core_ui/ui_toast/module.dart';
import 'package:flutter/material.dart';

class ToastService {
  //+ Constructor nombrado
  ToastService._internal();

  //+ Instancia única de la clase
  static final ToastService _toastService = ToastService._internal();

  //+ Getter para la instancia única
  static ToastService get toastService => _toastService;

  /// Método para abrir el toast
  void showToast(BuildContext context, String title, String message,
      ToastServiceType toastServiceType) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return CoreUIToast(
            title: title,
            message: message,
            toastServiceType: toastServiceType,
          );
        });
  }
}
