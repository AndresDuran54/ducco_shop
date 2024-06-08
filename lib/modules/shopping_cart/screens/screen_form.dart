//+ FLUTTER
import 'package:ducco_shop/lib_bloc/module.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

//+ DEPENDENCIES
import 'package:provider/provider.dart';

//+ UTILS
import 'package:ducco_shop/utils/fonts/fonts.dart';
import 'package:ducco_shop/utils/colors/colors.dart';

//+ LIB CORE SDKS
import 'package:ducco_shop/lib_shares/services/providers/module.dart';

//+ LIB CORE UI
import 'package:ducco_shop/lib_core_ui/ui_buttons/module.dart';
import 'package:ducco_shop/lib_core_ui/ui_inputs/module.dart';

class ScreenForm extends StatefulWidget {
  const ScreenForm({super.key});

  @override
  State<ScreenForm> createState() => ScreenFormState();
}

class ScreenFormState extends State<ScreenForm> {
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
  int formKeyPaymentMethod = 1;

  @override
  void initState() {
    super.initState();
    //+
  }

  @override
  Widget build(BuildContext context) {
    //+ Inyectamos el navigationModel
    final navigationModel = Provider.of<NavigationModel>(context);

    //+ Customer Bloc
    final CustomerBloc customerBloc = BlocProvider.of<CustomerBloc>(context);

    //+ Controladores para el formulario de información personal
    final GlobalKey<FormState> formKeyUserData = new GlobalKey();
    final TextEditingController identCtrl =
        new TextEditingController(text: customerBloc.state.customer!.identId);
    final TextEditingController identificationCtrl = new TextEditingController(
        text: customerBloc.state.customer!.identification);
    final TextEditingController emailCtrl =
        new TextEditingController(text: customerBloc.state.customer!.email);
    final TextEditingController firstNameCtrl =
        new TextEditingController(text: customerBloc.state.customer!.firstName);
    final TextEditingController lastNameCtrl =
        new TextEditingController(text: customerBloc.state.customer!.lastName);
    final TextEditingController phoneCtrl = new TextEditingController(
        text: customerBloc.state.customer!.phoneNumber);

    //+ Controladores para el formulario de dirección de entrega
    final GlobalKey<FormState> formKeyDeliveryData = new GlobalKey();
    final TextEditingController deliveryAddressCtrl =
        new TextEditingController();
    final TextEditingController districtAddressCtrl =
        new TextEditingController();
    final TextEditingController floorOrApartmentAddressCtrl =
        new TextEditingController();
    final TextEditingController referenceAddressCtrl =
        new TextEditingController();

    return Theme(
      data: ThemeData(
        colorScheme:
            const ColorScheme.light(primary: AppColors.secondary80Color),
      ),
      child: Stepper(
        type: stepperType,
        physics: const BouncingScrollPhysics(),
        currentStep: this.currentStep,
        steps: <Step>[
          buildStepUserData(
            formKeyUserData,
            identCtrl,
            identificationCtrl,
            emailCtrl,
            firstNameCtrl,
            lastNameCtrl,
            phoneCtrl,
          ),
          buildStepDeliveryData(
              formKeyDeliveryData,
              deliveryAddressCtrl,
              districtAddressCtrl,
              floorOrApartmentAddressCtrl,
              referenceAddressCtrl),
          buildStepPayInMethods(),
        ],
        controlsBuilder:
            (BuildContext context, ControlsDetails controlsDetails) {
          return Row(
            children: <Widget>[
              if (this.currentStep == 0) ...[
                UIButton(
                    onPressedFunc: () {
                      navigationModel.actualPage = 0;
                    },
                    enabledColor: AppColors.gray50Color,
                    disabledColor: AppColors.gray50Color,
                    splashColor: AppColors.gray70Color,
                    text: 'Anterior'),
                const SizedBox(width: 16),
                UIButton(
                    onPressedFunc: () {
                      if (formKeyUserData.currentState != null &&
                          formKeyUserData.currentState!.validate()) {
                        setState(() {
                          this.currentStep = 1;
                        });
                      }
                    },
                    enabledColor: AppColors.secondary80Color,
                    disabledColor: AppColors.secondary20Color,
                    splashColor: AppColors.gray70Color,
                    text: 'Siguiente')
              ],
              if (this.currentStep == 1) ...[
                UIButton(
                    onPressedFunc: () {
                      setState(() {
                        this.currentStep = 0;
                      });
                    },
                    enabledColor: AppColors.gray50Color,
                    disabledColor: AppColors.gray50Color,
                    splashColor: AppColors.gray70Color,
                    text: 'Anterior'),
                const SizedBox(width: 16),
                UIButton(
                    onPressedFunc:
                        (formKeyDeliveryData.currentState?.validate() ?? false)
                            ? () {
                                setState(() {
                                  this.currentStep = 2;
                                });
                              }
                            : null,
                    enabledColor: AppColors.secondary80Color,
                    disabledColor: AppColors.secondary20Color,
                    splashColor: AppColors.gray70Color,
                    text: 'Siguiente'),
              ],
              if (this.currentStep == 2) ...[
                UIButton(
                    onPressedFunc: () {
                      setState(() {
                        // this.currentStep = 1;
                        navigationModel.actualPage = 2;
                      });
                    },
                    enabledColor: AppColors.gray50Color,
                    disabledColor: AppColors.gray50Color,
                    splashColor: AppColors.gray70Color,
                    text: 'Anterior'),
                const SizedBox(width: 16),
                UIButton(
                    onPressedFunc:
                        (formKeyDeliveryData.currentState?.validate() ?? false)
                            ? () {
                                navigationModel.actualPage = 2;
                              }
                            : null,
                    enabledColor: AppColors.secondary80Color,
                    disabledColor: AppColors.secondary20Color,
                    splashColor: AppColors.gray70Color,
                    text: 'Siguiente'),
              ],
            ],
          );
        },
      ),
    );
  }

  Step buildStepUserData(
    GlobalKey<FormState> keyForm,
    TextEditingController identCtrl,
    TextEditingController identificationCtrl,
    TextEditingController emailCtrl,
    TextEditingController firstNameCtrl,
    TextEditingController lastNameCtrl,
    TextEditingController phoneCtrl,
  ) {
    return new Step(
      title: Text('Información personal',
          style: AppFonts.subTitleHeavy(
              color: (this.currentStep == 0)
                  ? AppColors.gray20Color
                  : AppColors.gray60Color,
              fontFamily: 'Roboto')),
      content: Form(
        key: keyForm,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const SizedBox(height: 8),
            //+ Tipo de identificación
            SizedBox(
                height: 60,
                child: CoreUIInputSelect(
                  optionsList: this.documentOptions,
                  value: "DNI",
                  textEditingController: identCtrl,
                )),
            const SizedBox(height: 14),
            //+ Identificación
            CoreUIInputText(
              labelText: 'Identificación',
              textInputType: TextInputType.number,
              validators: [
                AppInputTextValidators.checkRequired(
                    errorMsg: 'La identificación es requerida')
              ],
              textEditingController: identificationCtrl,
            ),
            const SizedBox(height: 14),
            //+ Correo electrónico
            CoreUIInputText(
                labelText: 'Correo electrónico',
                validators: [
                  AppInputTextValidators.checkRequired(
                      errorMsg: 'El correo electrónico es requerido'),
                  AppInputTextValidators.checkEmail(
                      errorMsg: 'Ingrese un formato de correo correcto'),
                ],
                textEditingController: emailCtrl),
            const SizedBox(height: 14),
            //+ Nombres
            CoreUIInputText(
              labelText: 'Nombres',
              validators: [
                AppInputTextValidators.checkRequired(
                    errorMsg: 'Los nombres son requeridos'),
                AppInputTextValidators.checkText(
                    errorMsg: 'Los nombres solo deben contener letras')
              ],
              textEditingController: firstNameCtrl,
            ),
            const SizedBox(height: 14),
            //+ Apellidos
            CoreUIInputText(
              labelText: 'Apellidos',
              validators: [
                AppInputTextValidators.checkRequired(
                    errorMsg: 'Los apellidos son requeridos'),
                AppInputTextValidators.checkText(
                    errorMsg: 'Los apellidos solo deben contener letras')
              ],
              textEditingController: lastNameCtrl,
            ),
            const SizedBox(height: 14),
            //+ Número celular
            CoreUIInputText(
              labelText: 'Número celular',
              textInputType: TextInputType.number,
              validators: [
                AppInputTextValidators.checkRequired(
                    errorMsg: 'El número celular es requerido')
              ],
              textEditingController: phoneCtrl,
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
      isActive: currentStep == 0,
      state: currentStep > 1 ? StepState.complete : StepState.disabled,
    );
  }

  Step buildStepDeliveryData(
      GlobalKey<FormState> keyForm,
      TextEditingController deliveryAddressCtrl,
      TextEditingController districtAddressCtrl,
      TextEditingController floorOrApartmentAddressCtrl,
      TextEditingController referenceAddressCtrl) {
    return new Step(
      title: Text('Información de entrega',
          style: AppFonts.subTitleHeavy(
              color: (this.currentStep == 1)
                  ? AppColors.gray90Color
                  : AppColors.gray60Color,
              fontFamily: 'Roboto')),
      content: Form(
        key: keyForm,
        onChanged: () {
          setState(() {});
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const SizedBox(height: 8),
            //+ Dirección de entrega
            CoreUIInputText(
              labelText: 'Dirección de entrega',
              validators: [
                AppInputTextValidators.checkRequired(
                    errorMsg: 'La dirección de entrega es requerida')
              ],
              textEditingController: deliveryAddressCtrl,
            ),
            const SizedBox(height: 14),
            //+ Distrito
            CoreUIInputText(
                labelText: 'Distrito',
                validators: [
                  AppInputTextValidators.checkRequired(
                      errorMsg: 'El distrito es requerido'),
                ],
                textEditingController: districtAddressCtrl),
            const SizedBox(height: 14),
            //+ Nombres
            CoreUIInputText(
              labelText: 'Piso o departamento (Opcional)',
              textEditingController: floorOrApartmentAddressCtrl,
            ),
            const SizedBox(height: 14),
            //+ Nombres
            CoreUIInputText(
              labelText: 'Referencia (Opcional)',
              textEditingController: referenceAddressCtrl,
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
      isActive: currentStep == 1,
      state: StepState.complete,
    );
  }

  Step buildStepPayInMethods() {
    return Step(
      title: Text('Método de pago',
          style: AppFonts.subTitleHeavy(
              color: (this.currentStep == 2)
                  ? AppColors.gray90Color
                  : AppColors.gray60Color,
              fontFamily: 'Roboto')),
      content: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          ListTile(
            title: Text('Yape QR',
                style: AppFonts.subTitleHeavy(
                    color: AppColors.gray80Color, fontFamily: 'Roboto')),
            leading: Radio<int>(
              value: 1,
              activeColor: AppColors.secondary60Color,
              groupValue: this.formKeyPaymentMethod,
              onChanged: (int? value) {
                setState(() {
                  if (value != null) {
                    this.formKeyPaymentMethod = value;
                  }
                });
              },
            ),
          ),
          ListTile(
            title: Text('Pago contra entrega',
                style: AppFonts.subTitleHeavy(
                    color: AppColors.gray80Color, fontFamily: 'Roboto')),
            leading: Radio<int>(
              value: 2,
              activeColor: AppColors.secondary60Color,
              groupValue: this.formKeyPaymentMethod,
              onChanged: (int? value) {
                setState(() {
                  if (value != null) {
                    this.formKeyPaymentMethod = value;
                  }
                });
              },
            ),
          ),
        ],
      ),
      isActive: currentStep == 2,
      state: StepState.complete,
    );
  }
}
