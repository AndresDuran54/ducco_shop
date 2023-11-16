import 'package:flutter/material.dart';

//+ Utils
import 'package:ducco_shop/utils/fonts/fonts.dart';
import 'package:ducco_shop/utils/colors/colors.dart';

class UIButtonIcon extends StatelessWidget {
  final void Function()? onPressedFunc;
  final double height;
  final double width;
  final String text;
  final Color enabledColor;
  final Color disabledColor;
  final Color splashColor;
  final IconData iconData;
  final Color iconDataColor;
  final TextStyle? textStyle;

  const UIButtonIcon(
      {super.key,
      required this.onPressedFunc,
      required this.enabledColor,
      required this.disabledColor,
      required this.splashColor,
      required this.text,
      required this.iconData,
      this.textStyle,
      this.iconDataColor = AppColors.gray100Color,
      this.height = 40,
      this.width = 120});

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
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            this.text,
            style: this.textStyle ??
                AppFonts.buttonTextHeavy(
                    color: AppColors.gray100Color, fontFamily: 'Ubuntu'),
          ),
          const SizedBox(width: 8),
          Icon(
            this.iconData,
            color: this.iconDataColor,
          )
        ],
      ),
    );
  }
}
