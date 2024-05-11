// ignore_for_file: file_names, constant_identifier_names

import 'package:ducco_shop/lib_core_ui/ui_buttons/module.dart';
import 'package:ducco_shop/utils/colors/colors.dart';
import 'package:ducco_shop/utils/fonts/fonts.dart';
import 'package:flutter/material.dart';

enum ToastConfirmServiceType { SUCCESS, ERROR }

class CoreUIConfirmToast extends StatelessWidget {
  final String title;
  final String message;
  final ToastConfirmServiceType toastServiceType;
  late Color titleColor;
  final void Function()? onConfirmPressedFunc;
  final void Function()? onCancelPressedFunc;

  CoreUIConfirmToast({
    super.key,
    required this.title,
    required this.message,
    required this.toastServiceType,
    required this.onConfirmPressedFunc,
    required this.onCancelPressedFunc,
  }) {
    switch (this.toastServiceType) {
      case ToastConfirmServiceType.SUCCESS:
        this.titleColor = AppColors.secondary80Color;
        break;
      case ToastConfirmServiceType.ERROR:
        this.titleColor = AppColors.red100Color;
        break;
      default:
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Column(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(12),
            decoration: const BoxDecoration(
                color: AppColors.gray100Color,
                borderRadius: BorderRadius.all(Radius.circular(8))),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  title,
                  textAlign: TextAlign.start,
                  style: AppFonts.subTitle2Heavy(
                      color: this.titleColor, fontFamily: 'Ubuntu'),
                ),
                const SizedBox(
                  height: 8,
                ),
                Text(
                  message,
                  textAlign: TextAlign.start,
                  style: AppFonts.labelTextLight(
                      color: AppColors.black20Color, fontFamily: 'Ubuntu'),
                ),
                const SizedBox(
                  height: 8,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    UIButton(
                        height: 35,
                        onPressedFunc: this.onCancelPressedFunc,
                        enabledColor: AppColors.gray45Color,
                        disabledColor: AppColors.secondary50Color,
                        splashColor: AppColors.gray100Color,
                        text: 'Cancelar'),
                    const SizedBox(
                      width: 8,
                    ),
                    UIButton(
                        height: 35,
                        onPressedFunc: this.onConfirmPressedFunc,
                        enabledColor: AppColors.secondary90Color,
                        disabledColor: AppColors.secondary50Color,
                        splashColor: AppColors.gray100Color,
                        text: 'Confirmar')
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
