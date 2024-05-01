//+ FLUTTER
import 'package:flutter/material.dart';

//+ UTILS
import 'package:ducco_shop/utils/colors/colors.dart';
import 'package:ducco_shop/utils/fonts/fonts.dart';

class CoreUIInputSelectToggle extends StatelessWidget {
  final List<InputSelectToggle> optionsList;
  final void Function(int index)? onPressedFunc;

  const CoreUIInputSelectToggle({
    super.key,
    required this.optionsList,
    required this.onPressedFunc,
  });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return SizedBox(
      height: size.height,
      child: Center(
        child: Container(
          height: optionsList.length * 70,
          padding: const EdgeInsets.all(16),
          child: ListView.builder(
              itemCount: optionsList.length,
              itemBuilder: (BuildContext context, int i) => GestureDetector(
                    onTap: () {
                      onPressedFunc?.call(optionsList[i].id);
                    },
                    child: Container(
                      height: 50,
                      decoration: const BoxDecoration(
                          color: AppColors.gray50Color,
                          border: Border(
                              bottom:
                                  BorderSide(color: AppColors.gray70Color))),
                      child: Center(
                        child: Text(
                          optionsList[i].label,
                          style: AppFonts.mainTextHeavy(
                              color: AppColors.gray100Color,
                              fontFamily: 'Ubuntu'),
                        ),
                      ),
                    ),
                  )),
        ),
      ),
    );
  }
}

class InputSelectToggle {
  final int id;
  final String label;

  const InputSelectToggle({
    required this.id,
    required this.label,
  });
}
