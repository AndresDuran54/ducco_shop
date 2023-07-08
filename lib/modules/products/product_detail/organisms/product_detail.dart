import 'package:flutter/material.dart';

//+ COLORS
import 'package:ducco_shop/utils/colors/colors.dart';

//+ MICROS UI
import 'package:ducco_shop/lib_core_ui/ui_buttons/module.dart';

class ProductDetailScreen extends StatelessWidget {
  const ProductDetailScreen ({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.gray80Color,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: ListView(
          children: <Widget>[
            //+ BUTTONS
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                UiButtonMiniIcon(
                  iconData: Icons.arrow_back_sharp,
                  color: AppColors.primary20Color,
                  backgroundColor: AppColors.gray60Color,
                ),
                UiButtonMiniIcon(
                  iconData: Icons.favorite,
                  color: AppColors.secondary60Color,
                  backgroundColor: AppColors.gray60Color,
                )
              ],
            ),
            const SizedBox(
              height: 24,
            ),
            //+ TITLE
            const Column(
              children: <Widget>[
                Text('Pro Keyboard K/DA GX Blue', style: TextStyle(
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.w500,
                    fontSize: 20,
                    color: AppColors.secondary50Color
                )),
                Text('Logitech', style: TextStyle(
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.w300,
                    fontSize: 16,
                    color: AppColors.gray40Color
                )),
              ],
            ),
            //+ IMAGEN DEL PRODUCTO
            const ClipOval(
              child: FadeInImage(
                  height: 280,
                  placeholderFit: BoxFit.cover,
                  placeholder: AssetImage('assets/gifs/loading.gif'),
                  fit: BoxFit.cover,
                  image: NetworkImage(
                      'https://imgur.com/2yM2vNt.png'
                  )),
            ),
            //+ PRECIO Y TOTAL
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  const Text('S/ 150.00', style: TextStyle(
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.w500,
                      fontSize: 28,
                      color: AppColors.primary50Color
                  )),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    decoration: BoxDecoration(
                      color: AppColors.gray70Color,
                      borderRadius: BorderRadius.circular(4)
                    ),
                    child: const Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Icon(Icons.remove, size: 32, color: AppColors.gray50Color),
                        SizedBox(
                          width: 12,
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 8),
                          child: Text('3', style: TextStyle(
                              fontFamily: 'Roboto',
                              fontWeight: FontWeight.w500,
                              fontSize: 24,
                              color: AppColors.primary20Color
                          )),
                        ),
                        SizedBox(
                          width: 12,
                        ),
                        Icon(Icons.add, size: 32, color: AppColors.gray50Color)
                      ],
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            //+ DESCRIPCIÓN DEL PRODUCTO
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Descripción', style: TextStyle(
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.w700,
                      fontSize: 16,
                      color: AppColors.primary30Color
                  )),
                  Text('Lorem Ipsum is simply dummy text of the printing and typesetting industry. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.', style: TextStyle(
                      fontFamily: 'Roboto',
                      fontSize: 16,
                      color: AppColors.gray50Color
                  )),
                ],
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            //+ BOTON DE COMPRAR
            MaterialButton(
              color: AppColors.secondary50Color,
              onPressed: (() => {}),
              child: const Text(
                'AGREGAR AL CARRITO',
                style: TextStyle(
                  color: AppColors.gray90Color,
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                  height: 2,
                ),
                textAlign: TextAlign.center,
              ),
            )
          ],
        ),
      ),
    );
  }
}
