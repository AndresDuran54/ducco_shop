import 'package:flutter/material.dart';

class UiButtonMiniIcon extends StatelessWidget {

  final IconData iconData;
  final Color color;
  final Color backgroundColor;

  const UiButtonMiniIcon({
    required this.iconData,
    required this.color,
    required this.backgroundColor,
    super.key
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: this.color.withOpacity(0.2), // Color de la animación de tinta
      splashFactory: InkRipple.splashFactory, // Fábrica de animación de tinta
      onTap: () {
        // Acción a realizar cuando se toque el contenedor
        print('Contenedor clickeado!');
      },
      child: Container(
        padding: EdgeInsets.all(4),
        decoration: BoxDecoration(
          color: this.backgroundColor.withOpacity(0.4),
          borderRadius: BorderRadius.circular(4)
        ),
        child: Center(child: Icon(this.iconData, color: this.color.withOpacity(0.75))),
      ),
    );
  }
}
