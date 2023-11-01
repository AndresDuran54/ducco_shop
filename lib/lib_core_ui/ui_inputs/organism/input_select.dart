import 'package:ducco_shop/utils/colors/colors.dart';
import 'package:ducco_shop/utils/fonts/fonts.dart';
import 'package:flutter/material.dart';

class CoreUIInputSelect extends StatelessWidget {
  final List<DropdownMenuItem<String>> optionsList;
  final String value;

  const CoreUIInputSelect(
      {super.key, required this.optionsList, required this.value});

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      iconEnabledColor: AppColors.gray70Color,
      decoration: const InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
              width: 1,
              color: AppColors
                  .gray80Color), // Estilo de la línea cuando no está seleccionado
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            width: 2,
            color: AppColors.gray80Color,
          ), // Estilo de la línea cuando no está seleccionado
        ),
      ),
      isExpanded: true,
      onChanged: (String? value) => {},
      items: this.optionsList,
      style: AppFonts.labelTextLight(
          color: AppColors.gray70Color, fontFamily: 'Roboto'),
      icon: const Icon(Icons.keyboard_arrow_down),
      value: this.value,
    );
  }
}
