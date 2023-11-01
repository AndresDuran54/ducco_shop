import 'package:ducco_shop/lib_core_ui/ui_inputs/organism/input_select.dart';
import 'package:ducco_shop/lib_core_ui/ui_inputs/validators/validator.dart';
import 'package:ducco_shop/utils/colors/colors.dart';
import 'package:ducco_shop/utils/fonts/fonts.dart';
import 'package:flutter/material.dart';

//+ LIB CORE UI
import 'package:ducco_shop/lib_core_ui/ui_inputs/organism/input_text.dart';

class FormAddressResume extends StatefulWidget {
  const FormAddressResume({super.key});

  @override
  State<FormAddressResume> createState() => FormAddressResumeState();
}

class FormAddressResumeState extends State<FormAddressResume> {
  //+ Estado inicial del formulario
  int currentStep = 0;
  //+ Tipo de Steeper
  StepperType stepperType = StepperType.vertical;
  //+ Lista de tipos de documentos de identidad
  List<DropdownMenuItem<String>> get documentOptions {
    return const [
      DropdownMenuItem(value: "DNI", child: Text("DNI")),
      DropdownMenuItem(value: "CTX", child: Text("CTX")),
    ];
  }

  //+ Forms Global Keys
  final GlobalKey<FormState> formKeyUserData = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
        colorScheme:
            const ColorScheme.light(primary: AppColors.secondary80Color),
      ),
      child: Stepper(
        type: stepperType,
        physics: const BouncingScrollPhysics(),
        currentStep: this.currentStep,
        onStepTapped: (int step) {
          this.setState(() => currentStep = step);
        },
        onStepContinue: () {
          this.currentStep < 2 ? setState(() => this.currentStep += 1) : null;
        },
        onStepCancel: () {
          this.currentStep > 0 ? setState(() => this.currentStep -= 1) : null;
        },
        steps: <Step>[
          buildStepUserData(),
          buildStepDeliveryData(),
          buildStepPayInMethods(),
        ],
        controlsBuilder:
            (BuildContext context, ControlsDetails controlsDetails) {
          return Row(
            children: <Widget>[
              if (this.currentStep == 0) ...[
                MaterialButton(
                  height: 40,
                  minWidth: 120,
                  onPressed: () {
                    if (this.formKeyUserData.currentState?.validate() ??
                        false) {
                      print('CORRECTO');
                    } else {
                      print('INCORECTO');
                    }
                    setState(() => {});
                  },
                  animationDuration: const Duration(milliseconds: 1000),
                  color: AppColors.secondary80Color,
                  splashColor: AppColors.gray90Color,
                  disabledColor: AppColors.secondary100Color,
                  child: Text(
                    'Siguiente',
                    style: AppFonts.buttonTextHeavy(
                        color: AppColors.gray100Color, fontFamily: 'Roboto'),
                  ),
                ),
              ],
            ],
          );
        },
      ),
    );
  }

  Step buildStepUserData() {
    return new Step(
      title: Text('Información personal',
          style: AppFonts.subTitleHeavy(
              color: AppColors.gray90Color, fontFamily: 'Roboto')),
      content: Form(
        key: this.formKeyUserData,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            //+ Tipo de identificación
            SizedBox(
                height: 60,
                child: CoreUIInputSelect(
                  optionsList: this.documentOptions,
                  value: "DNI",
                )),
            const SizedBox(height: 8),
            //+ Identificación
            CoreUIInputText(
              labelText: 'Identificación',
              textInputType: TextInputType.number,
              validators: [
                AppInputTextValidators.checkRequired(
                    errorMsg: 'La identificación es requerida')
              ],
            ),
            const SizedBox(height: 8),
            //+ Correo electrónico
            CoreUIInputText(labelText: 'Correo electrónico', validators: [
              AppInputTextValidators.checkRequired(
                  errorMsg: 'El correo electrónico es requerido'),
              AppInputTextValidators.checkEmail(
                  errorMsg: 'Ingrese un formato de correo correcto'),
            ]),
            const SizedBox(height: 8),
            //+ Nombres
            CoreUIInputText(
              labelText: 'Nombres',
              validators: [
                AppInputTextValidators.checkRequired(
                    errorMsg: 'Los nombres son requeridos'),
                AppInputTextValidators.checkText(
                    errorMsg: 'Los nombres solo deben contener letras')
              ],
            ),
            const SizedBox(height: 8),
            //+ Apellidos
            CoreUIInputText(
              labelText: 'Apellidos',
              validators: [
                AppInputTextValidators.checkRequired(
                    errorMsg: 'Los apellidos son requeridos'),
                AppInputTextValidators.checkText(
                    errorMsg: 'Los apellidos solo deben contener letras')
              ],
            ),
            const SizedBox(height: 8),
            //+ Número celular
            CoreUIInputText(
              labelText: 'Número celular',
              textInputType: TextInputType.number,
              validators: [
                AppInputTextValidators.checkRequired(
                    errorMsg: 'El número celular es requerido')
              ],
            ),
            const SizedBox(height: 8),
          ],
        ),
      ),
      isActive: currentStep >= 0,
      state: currentStep >= 0 ? StepState.complete : StepState.disabled,
    );
  }

  Step buildStepDeliveryData() {
    return Step(
      title: Text('Información de entrega',
          style: AppFonts.subTitleHeavy(
              color: AppColors.gray40Color, fontFamily: 'Roboto')),
      content: Column(
        children: <Widget>[
          TextFormField(
            decoration: const InputDecoration(labelText: 'Home Address'),
          ),
          TextFormField(
            decoration: const InputDecoration(labelText: 'Postcode'),
          ),
        ],
      ),
      isActive: currentStep >= 0,
      state: currentStep >= 1 ? StepState.complete : StepState.disabled,
    );
  }

  Step buildStepPayInMethods() {
    return Step(
      title: Text('Mobile Number',
          style: AppFonts.subTitleHeavy(
              color: AppColors.gray40Color, fontFamily: 'Roboto')),
      content: Column(
        children: <Widget>[
          TextFormField(
            decoration: const InputDecoration(labelText: 'Mobile Number'),
          ),
        ],
      ),
      isActive: currentStep >= 0,
      state: currentStep >= 2 ? StepState.complete : StepState.disabled,
    );
  }
}
