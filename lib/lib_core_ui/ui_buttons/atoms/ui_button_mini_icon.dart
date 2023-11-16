import 'package:flutter/material.dart';

class UIButtonMiniIcon extends StatelessWidget {
  final void Function() onTapFunction;
  final IconData iconData;
  final Color color;
  final Color backgroundColor;
  final double backgroundOpacity;

  const UIButtonMiniIcon(
      {required this.iconData,
      required this.color,
      required this.backgroundColor,
      required this.onTapFunction,
      this.backgroundOpacity = 0.4,
      super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: this.color.withOpacity(0.7),
      splashFactory: InkRipple.splashFactory,
      onTap: onTapFunction,
      child: Container(
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(
            color: this.backgroundColor.withOpacity(this.backgroundOpacity),
            borderRadius: BorderRadius.circular(4)),
        child: Center(
            widthFactor: 1,
            heightFactor: 1,
            child: Icon(this.iconData, color: this.color.withOpacity(0.75))),
      ),
    );
  }
}
