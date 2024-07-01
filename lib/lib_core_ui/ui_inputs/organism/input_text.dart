import 'package:flutter/material.dart';

//+ UTILS
import 'package:ducco_shop/utils/colors/colors.dart';
import 'package:ducco_shop/utils/fonts/fonts.dart';
import 'package:flutter/services.dart';

class CoreUIInputText extends StatefulWidget {
  final String labelText;
  final bool obscureText;
  final bool readOnly;
  final List<String? Function({required String value})> validators;
  final TextInputType textInputType;
  final TextEditingController textEditingController;
  static final TextEditingController defaultTextEditingController =
      TextEditingController();

  CoreUIInputText(
      {super.key,
      this.obscureText = false,
      this.readOnly = false,
      required this.labelText,
      TextEditingController? textEditingController,
      this.validators = const [],
      this.textInputType = TextInputType.text})
      : textEditingController =
            textEditingController ?? defaultTextEditingController;

  @override
  State<CoreUIInputText> createState() => _CoreUIInputTextState();
}

class _CoreUIInputTextState extends State<CoreUIInputText> {
  final GlobalKey<FormState> formKey = new GlobalKey<FormState>();
  Color currentColor = AppColors.gray40Color;
  String? errorText;

  String? onCheckValidators(String? value) {
    if (value == null) return value;
    for (String? Function({required String value}) validatorFunc
        in this.widget.validators) {
      this.errorText = validatorFunc(value: value);
      if (this.errorText != null) {
        this.setState(() {
          this.currentColor = AppColors.red100Color;
        });
      } else {
        this.setState(() {
          this.currentColor = AppColors.gray40Color;
        });
      }
      if (this.errorText != null) return this.errorText;
    }
    return null;
  }

  onChanges(String? value) {
    if (value == null) return;
    for (String? Function({required String value}) validatorFunc
        in this.widget.validators) {
      this.setState(() {
        this.errorText = validatorFunc(value: value);
        if (this.errorText != null) {
          this.currentColor = AppColors.red100Color;
        } else {
          this.currentColor = AppColors.gray40Color;
        }
      });
      if (this.errorText != null) return this.errorText;
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      key: formKey,
      readOnly: this.widget.readOnly,
      controller: this.widget.textEditingController,
      keyboardType: this.widget.textInputType,
      obscureText: this.widget.obscureText,
      inputFormatters: [
        if (this.widget.textInputType == TextInputType.number)
          FilteringTextInputFormatter.digitsOnly
      ],
      style: AppFonts.labelTextLight(
          color: this.currentColor, fontFamily: 'Roboto'),
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            width: 1,
            color: this.currentColor,
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: BorderSide(
            width: 2,
            color: this.currentColor,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            width: 2,
            color: this.currentColor,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(
            width: 2,
            color: this.currentColor,
          ),
        ),
        hintStyle: AppFonts.labelTextLight(
            color: this.currentColor, fontFamily: 'Roboto'),
        hoverColor: Colors.red,
        floatingLabelStyle: AppFonts.labelTextLight(
            color: this.currentColor, fontFamily: 'Roboto'),
        labelStyle: AppFonts.labelTextLight(
            color: this.currentColor, fontFamily: 'Roboto'),
        errorStyle: AppFonts.captionTextLight(
            color: this.currentColor, fontFamily: 'Roboto'),
        labelText: this.widget.labelText,
        errorText: this.errorText,
      ),
      validator: (String? value) {
        return this.onCheckValidators(value);
      },
      onChanged: (String value) => {this.onChanges(value)},
    );
  }
}
