import 'package:ducco_shop/utils/colors/colors.dart';
import 'package:flutter/material.dart';

class OverviewScreen extends StatelessWidget {
  const OverviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: _AppBarOverview(size: size),
        backgroundColor: AppColors.primary10Color,
      ),
      body: Container(
        padding: const EdgeInsets.all(15),
        color: AppColors.gray50Color,
        child: GridView.builder(
            itemCount: 21,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 15,
                crossAxisSpacing: 10,
                mainAxisExtent: 300,
                childAspectRatio: 20),
            physics: const BouncingScrollPhysics(),
            itemBuilder: (BuildContext context, int index) => _ProductOverview(
                  size: size,
                )),
      ),
    );
  }
}

class _ProductOverview extends StatelessWidget {
  const _ProductOverview({Key? key, required this.size}) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: AppColors.primary20Color,
          borderRadius: BorderRadius.circular(10)),
      padding: const EdgeInsets.all(10),
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Positioned(
            top: 100,
            left: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              height: 180,
              decoration: BoxDecoration(
                  color: AppColors.primary10Color,
                  borderRadius: BorderRadius.circular(10)),
              child: Column(
                children: <Widget>[
                  const SizedBox(
                    height: 40,
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
                          height: 2),
                      textAlign: TextAlign.start,
                    ),
                  ),
                  MaterialButton(
                    color: AppColors.secondary50Color,
                    onPressed: (() => {}),
                    child: const Text(
                      'AGREGAR AL \n CARRITO',
                      style: TextStyle(
                        color: AppColors.gray80Color,
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.w500,
                        fontSize: 12,
                        height: 1,
                      ),
                      maxLines: 2,
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
              width: size.width * 0.32,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: AppColors.gray40Color,
                  width: 2,
                ),
              ),
              child: ClipOval(
                child: FadeInImage(
                    placeholder: const AssetImage('assets/gifs/loading.gif'),
                    width: size.width * 0.32,
                    height: 130,
                    fit: BoxFit.cover,
                    image: const NetworkImage(
                        'https://promart.vteximg.com.br/arquivos/ids/6571809-1000-1000/image-e141cd34a31b46738915da3046190205.jpg?v=638012766471300000')),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class _AppBarOverview extends StatelessWidget {
  const _AppBarOverview({Key? key, required this.size}) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        const Image(
          image: AssetImage('assets/images/logo_only.png'),
          width: 35,
        ),
        _InputSearchOverview(size: size)
      ],
    );
  }
}

class _InputSearchOverview extends StatelessWidget {
  const _InputSearchOverview({
    Key? key,
    required this.size,
  }) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size.width * 0.8,
      height: 45,
      child: const TextField(
        cursorColor: AppColors.gray50Color,
        decoration: InputDecoration(
            suffixIcon: Icon(
              Icons.manage_search_rounded,
              color: AppColors.gray50Color,
            ),
            filled: true,
            fillColor: AppColors.gray30Color,
            hintText: 'Busca lo que necesitas',
            hintStyle: TextStyle(color: AppColors.gray50Color, height: 4.3),
            border: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.all(Radius.circular(20)))),
        style: TextStyle(color: AppColors.gray50Color),
      ),
    );
  }
}
