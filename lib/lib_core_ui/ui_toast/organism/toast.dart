// ignore_for_file: file_names, constant_identifier_names

import 'package:ducco_shop/utils/colors/colors.dart';
import 'package:ducco_shop/utils/fonts/fonts.dart';
import 'package:flutter/material.dart';

enum ToastServiceType { SUCCESS, ERROR }

class CoreUIToast extends StatelessWidget {
  final String title;
  final String message;
  final ToastServiceType toastServiceType;
  late Color titleColor;

  CoreUIToast(
      {super.key,
      required this.title,
      required this.message,
      required this.toastServiceType}) {
    switch (this.toastServiceType) {
      case ToastServiceType.SUCCESS:
        this.titleColor = AppColors.secondary80Color;
        break;
      case ToastServiceType.ERROR:
        this.titleColor = AppColors.red100Color;
        break;
      default:
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
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
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
