import 'package:flutter/material.dart';

//+ Utils
import 'package:ducco_shop/utils/fonts/fonts.dart';
import 'package:ducco_shop/utils/colors/colors.dart';

class UIButton extends StatelessWidget {
  final void Function()? onPressedFunc;
  final double height;
  final double width;
  final String text;
  final Color enabledColor;
  final Color disabledColor;
  final Color splashColor;
  final TextStyle? textStyle;

  const UIButton(
      {super.key,
      required this.onPressedFunc,
      required this.enabledColor,
      required this.disabledColor,
      required this.splashColor,
      required this.text,
      this.height = 40,
      this.width = 120,
      this.textStyle});

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      height: this.height,
      minWidth: this.width,
      onPressed: onPressedFunc,
      animationDuration: const Duration(milliseconds: 1000),
      color: this.enabledColor,
      disabledColor: this.disabledColor,
      splashColor: this.splashColor,
      child: Text(
        this.text,
        style: this.textStyle ??
            AppFonts.buttonTextHeavy(
                color: AppColors.gray100Color, fontFamily: 'Roboto'),
      ),
    );
  }
}
