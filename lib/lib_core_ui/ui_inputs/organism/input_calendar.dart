import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:ducco_shop/lib_core_domain/lib/pipes/pipes.date.dart';
import 'package:ducco_shop/utils/colors/colors.dart';
import 'package:ducco_shop/utils/fonts/fonts.dart';
import 'package:flutter/material.dart';

class CoreUIInputCalendar extends StatefulWidget {
  final String labelText;
  final bool obscureText;
  final List<String? Function({required String value})> validators;
  final TextEditingController textEditingController;
  static final TextEditingController defaultTextEditingController =
      TextEditingController();
  final TextEditingController textViewController = TextEditingController();

  CoreUIInputCalendar(
      {super.key,
      required this.labelText,
      this.obscureText = false,
      TextEditingController? textEditingController,
      this.validators = const []})
      : textEditingController =
            textEditingController ?? defaultTextEditingController;

  @override
  State<CoreUIInputCalendar> createState() => _CoreUIInputCalendarState();
}

class _CoreUIInputCalendarState extends State<CoreUIInputCalendar> {
  final GlobalKey<FormState> formKey = new GlobalKey<FormState>();
  Color currentColor = AppColors.gray40Color;
  String? errorText;

  @override
  void initState() {
    super.initState();

    if (this.widget.textEditingController.text != '') {
      this.widget.textViewController.text = PipesDate.epochToDateFormat(
          int.parse(widget.textEditingController.text), -5,
          format: 'dd MMM yyyy');
    }
  }

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
    return GestureDetector(
      onTap: () async {
        var showCalendarResult = await showCalendarDatePicker2Dialog(
          context: context,
          config: CalendarDatePicker2WithActionButtonsConfig(
            firstDayOfWeek: 1,
            calendarType: CalendarDatePicker2Type.single,
            selectedDayTextStyle: AppFonts.labelTextLight(
                color: AppColors.gray100Color, fontFamily: 'Roboto'),
            selectedDayHighlightColor: AppColors.secondary80Color,
            centerAlignModePicker: true,
          ),
          dialogSize: const Size(325, 400),
          value: [],
          borderRadius: BorderRadius.circular(15),
        );

        if (showCalendarResult != null &&
            showCalendarResult.isNotEmpty &&
            showCalendarResult[0] != null) {
          this.widget.textEditingController.text =
              '${showCalendarResult[0]!.toUtc().millisecondsSinceEpoch}';

          this.widget.textViewController.text = PipesDate.epochToDateFormat(
              showCalendarResult[0]!.toUtc().millisecondsSinceEpoch, -5,
              format: 'dd MMM yyyy');

          onCheckValidators(this.widget.textViewController.text);
        }
      },
      child: TextFormField(
        key: formKey,
        controller: this.widget.textViewController,
        obscureText: this.widget.obscureText,
        enabled: false,
        style: AppFonts.labelTextLight(
            color: AppColors.gray40Color, fontFamily: 'Roboto'),
        decoration: InputDecoration(
          prefixIcon: const Icon(Icons.cake, color: AppColors.gray55Color),
          disabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              width: 1,
              color: this.currentColor,
            ),
          ),
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
      ),
    );
  }
}
