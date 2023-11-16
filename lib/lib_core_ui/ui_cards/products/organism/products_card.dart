import 'package:ducco_shop/utils/colors/colors.dart';
import 'package:flutter/material.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({Key? key, required this.size}) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: (size.width - 32) / 2,
      decoration: BoxDecoration(
          color: AppColors.gray70Color, borderRadius: BorderRadius.circular(8)),
      padding: const EdgeInsets.all(8),
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Positioned(
            top: 100,
            child: Container(
              width: ((size.width - 32) / 2) - 16,
              padding: const EdgeInsets.symmetric(horizontal: 10),
              height: 180,
              decoration: BoxDecoration(
                  color: AppColors.gray40Color,
                  borderRadius: BorderRadius.circular(10)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  const SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    width: size.width - 20,
                    child: const Text(
                      'Logitech',
                      style: TextStyle(
                        color: AppColors.gray90Color,
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                      ),
                      textAlign: TextAlign.start,
                    ),
                  ),
                  SizedBox(
                    width: size.width - 20,
                    child: const Text(
                      'Teclado mecánico alambrico con luces RGB',
                      style: TextStyle(
                          color: AppColors.gray90Color,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w200,
                          fontSize: 12,
                          height: 1.5),
                      textAlign: TextAlign.start,
                    ),
                  ),
                  SizedBox(
                    width: size.width - 20,
                    child: const Text(
                      'S/60.00',
                      style: TextStyle(
                          color: AppColors.gray80Color,
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.w300,
                          fontSize: 15,
                          height: 1.2),
                      textAlign: TextAlign.start,
                    ),
                  ),
                  MaterialButton(
                    color: AppColors.secondary50Color,
                    onPressed: (() => {}),
                    child: const Text(
                      'Ver producto',
                      style: TextStyle(
                        color: AppColors.gray80Color,
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.w500,
                        fontSize: 12,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  )
                ],
              ),
            ),
          ),
          Positioned(
            top: 0,
            child: Container(
              width: size.width * 0.30,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: AppColors.primary10Color,
                  width: 2,
                ),
              ),
              child: const ClipOval(
                child: FadeInImage(
                    placeholderFit: BoxFit.cover,
                    placeholder: AssetImage('assets/gifs/loading_rolling.gif'),
                    fit: BoxFit.cover,
                    image: NetworkImage(
                        'https://promart.vteximg.com.br/arquivos/ids/6571809-1000-1000/image-e141cd34a31b46738915da3046190205.jpg?v=638012766471300000')),
              ),
            ),
          )
        ],
      ),
    );
  }
}
