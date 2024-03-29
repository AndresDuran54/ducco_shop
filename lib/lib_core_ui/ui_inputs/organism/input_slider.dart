//+ FLUTTER
import 'package:flutter/material.dart';

//+ LIB CORE UI
import 'package:ducco_shop/lib_core_ui/ui_buttons/module.dart';

//+ UTILS
import 'package:ducco_shop/utils/fonts/fonts.dart';
import 'package:ducco_shop/utils/colors/colors.dart';

class CoreUIInputSlider extends StatelessWidget {
  final int productQuantity;
  final void Function() onPressedPlusFunc;
  final void Function() onPressedLessFunc;
  final void Function()? onPressedRemoveFunc;
  final bool hideIconRemove;

  const CoreUIInputSlider(
      {super.key,
      required this.productQuantity,
      required this.onPressedPlusFunc,
      required this.onPressedLessFunc,
      this.onPressedRemoveFunc,
      this.hideIconRemove = false});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        UIButtonMiniIcon(
            onTapFunction: this.onPressedPlusFunc,
            backgroundColor: AppColors.primary20Color,
            color: AppColors.gray100Color,
            iconData: Icons.add,
            backgroundOpacity: 1),
        const SizedBox(width: 12),
        Text(
          '$productQuantity',
          textAlign: TextAlign.start,
          style: AppFonts.subTitleHeavy(
              color: AppColors.gray30Color, fontFamily: 'Ubuntu'),
        ),
        const SizedBox(width: 12),
        UIButtonMiniIcon(
            onTapFunction: this.onPressedLessFunc,
            backgroundColor: AppColors.primary20Color,
            color: AppColors.gray100Color,
            iconData: Icons.remove,
            backgroundOpacity: 1),
        if (!this.hideIconRemove) ...<Widget>[
          const SizedBox(width: 12),
          UIButtonMiniIcon(
              onTapFunction: this.onPressedRemoveFunc ?? () {},
              backgroundColor: AppColors.secondary40Color,
              color: AppColors.gray100Color,
              iconData: Icons.delete,
              backgroundOpacity: 1)
        ]
      ],
    );
  }
}
