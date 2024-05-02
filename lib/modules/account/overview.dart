import 'package:ducco_shop/lib_bloc/bloc/customer_bloc.dart';
import 'package:ducco_shop/lib_bloc/state/customer_state.dart';
import 'package:ducco_shop/lib_core_domain/module.dart';
import 'package:ducco_shop/lib_core_ui/ui_buttons/module.dart';
import 'package:ducco_shop/lib_core_ui/ui_inputs/module.dart';
import 'package:ducco_shop/utils/colors/colors.dart';
import 'package:ducco_shop/utils/fonts/fonts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AccountOverview extends StatelessWidget {
  //+ Lista de tipos de documentos de identidad
  List<DropdownMenuItem<String>> get documentOptions {
    return const [
      DropdownMenuItem(value: "DNI", child: Text("DNI")),
      DropdownMenuItem(value: "CTX", child: Text("CTX")),
    ];
  }

  const AccountOverview({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: BlocBuilder<CustomerBloc, CustomerState>(
          builder: (BuildContext context, CustomerState state) {
        if (!state.loggedIn) {
          return ListView(
            children: <Widget>[
              const NewProfileInformationCard(),
              const SizedBox(
                height: 20,
              ),
              UIButton(
                onPressedFunc: () {
                  Navigator.pushNamed(context, '/auth/login');
                },
                enabledColor: AppColors.secondary80Color,
                disabledColor: AppColors.secondary20Color,
                splashColor: AppColors.gray70Color,
                width: double.infinity,
                text: 'Iniciar sesión',
                textStyle: AppFonts.subTitle2Heavy(
                    color: AppColors.gray100Color, fontFamily: 'Ubuntu'),
              ),
              const SizedBox(
                height: 20,
              ),
              NewProfileInformationDataForm(documentOptions: documentOptions),
            ],
          );
        }
        return ListView(
          children: <Widget>[
            const MyProfileInformationCard(),
            const SizedBox(
              height: 20,
            ),
            MyProfileInformationDataForm(documentOptions: documentOptions),
            const SizedBox(
              height: 20,
            ),
            MyProfileInformationPasswordForm(documentOptions: documentOptions),
          ],
        );
      }),
    );
  }
}

class NewProfileInformationDataForm extends StatelessWidget {
  NewProfileInformationDataForm({
    super.key,
    required this.documentOptions,
  });

  final List<DropdownMenuItem<String>> documentOptions;

  final GlobalKey<FormState> keyForm = new GlobalKey();
  final TextEditingController identCtrl = new TextEditingController();
  final TextEditingController identificationCtrl = new TextEditingController();
  final TextEditingController emailCtrl = new TextEditingController();
  final TextEditingController firstNameCtrl = new TextEditingController();
  final TextEditingController lastNameCtrl = new TextEditingController();
  final TextEditingController phoneCtrl = new TextEditingController();
  final TextEditingController passwordCtrl = new TextEditingController();
  final TextEditingController passwordConfirmCtrl = new TextEditingController();
  final TextEditingController birthdayCtrl = new TextEditingController();

  //+ Servicio para la gestión de clientes
  final CustomersDomainService customersService =
      CustomersDomainService.customersDomainService;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: const BoxDecoration(
          color: AppColors.gray100Color,
          borderRadius: BorderRadius.all(Radius.circular(8))),
      child: Form(
        key: keyForm,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Crea tu cuenta',
              textAlign: TextAlign.start,
              style: AppFonts.subTitle2Heavy(
                  color: AppColors.black20Color, fontFamily: 'Ubuntu'),
            ),
            const SizedBox(height: 8),
            //+ Tipo de identificación
            SizedBox(
                height: 60,
                child: CoreUIInputSelect(
                  optionsList: this.documentOptions,
                  value: "DNI",
                  labelText: 'Tipo de documento',
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
            //+ Nueva contraseña
            CoreUIInputText(
              labelText: 'Contraseña',
              validators: [
                AppInputTextValidators.checkRequired(
                    errorMsg: 'La contraseña actual es requerida'),
                AppInputTextValidators.maxLength(
                    errorMsg:
                        'La contraseña debe de tener 12 caracteres como máximo',
                    maxLength: 12),
                AppInputTextValidators.minLength(
                    errorMsg:
                        'La contraseña debe de tener 8 caracteres como mínimo',
                    minLength: 8),
              ],
              obscureText: true,
              textEditingController: passwordCtrl,
            ),
            const SizedBox(height: 16),
            //+ Confirmar contraseña
            CoreUIInputText(
              labelText: 'Confirmar contraseña',
              validators: [
                AppInputTextValidators.checkRequired(
                    errorMsg: 'La contraseña actual es requerida'),
                AppInputTextValidators.maxLength(
                    errorMsg:
                        'La contraseña debe de tener 12 caracteres como máximo',
                    maxLength: 12),
                AppInputTextValidators.minLength(
                    errorMsg:
                        'La contraseña debe de tener 8 caracteres como mínimo',
                    minLength: 8),
              ],
              obscureText: true,
              textEditingController: passwordConfirmCtrl,
            ),
            const SizedBox(height: 16),
            CoreUIInputCalendar(
              labelText: 'Fecha de cumpleaños',
              textEditingController: birthdayCtrl,
              validators: [
                AppInputTextValidators.checkRequired(
                    errorMsg: 'La fecha de cumpleaños es requerida'),
              ],
            ),
            const SizedBox(height: 16),
            UIButton(
              onPressedFunc: () {
                if (keyForm.currentState != null &&
                    keyForm.currentState!.validate()) {
                  customersService.customersNewItem(body: {
                    "ident": identCtrl.text,
                    "identification": identificationCtrl.text,
                    "email": emailCtrl.text,
                    "firstName": firstNameCtrl.text,
                    "lastName": lastNameCtrl.text,
                    "phone": phoneCtrl.text,
                    "password": passwordCtrl.text,
                    "birthdayTimestamp": birthdayCtrl.text,
                  });
                } else {}
              },
              enabledColor: AppColors.secondary80Color,
              disabledColor: AppColors.secondary20Color,
              splashColor: AppColors.gray70Color,
              width: double.infinity,
              text: 'Crear',
              textStyle: AppFonts.subTitle2Heavy(
                  color: AppColors.gray100Color, fontFamily: 'Ubuntu'),
            )
          ],
        ),
      ),
    );
  }
}

class NewProfileInformationCard extends StatelessWidget {
  const NewProfileInformationCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: const BoxDecoration(
          color: AppColors.gray100Color,
          borderRadius: BorderRadius.all(Radius.circular(8))),
      child:
          Row(crossAxisAlignment: CrossAxisAlignment.center, children: <Widget>[
        Container(
          height: 100,
          width: 100,
          decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(100))),
          child: const Center(
            child: Image(
              image: AssetImage(
                  'assets/images/modules/customers/customers_not_logged.png'),
              width: 120,
            ),
          ),
        ),
        const SizedBox(
          width: 16,
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Crea una nueva cuenta',
              textAlign: TextAlign.start,
              style: AppFonts.subTitle2Heavy(
                  color: AppColors.black20Color, fontFamily: 'Ubuntu'),
            ),
            const SizedBox(
              height: 8,
            ),
            Text(
              'Si ya tienes una, inicia sesión',
              textAlign: TextAlign.start,
              style: AppFonts.labelTextLight(
                  color: AppColors.black20Color, fontFamily: 'Ubuntu'),
            )
          ],
        ),
      ]),
    );
  }
}

class MyProfileInformationDataForm extends StatelessWidget {
  const MyProfileInformationDataForm({
    super.key,
    required this.documentOptions,
  });

  final List<DropdownMenuItem<String>> documentOptions;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: const BoxDecoration(
          color: AppColors.gray100Color,
          borderRadius: BorderRadius.all(Radius.circular(8))),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'Completa tu perfil',
            textAlign: TextAlign.start,
            style: AppFonts.subTitle2Heavy(
                color: AppColors.black20Color, fontFamily: 'Ubuntu'),
          ),
          const SizedBox(height: 8),
          //+ Tipo de identificación
          SizedBox(
              height: 60,
              child: CoreUIInputSelect(
                optionsList: this.documentOptions,
                value: "DNI",
                labelText: 'Tipo de documento',
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
          ),
          const SizedBox(height: 14),
          //+ Correo electrónico
          CoreUIInputText(labelText: 'Correo electrónico', validators: [
            AppInputTextValidators.checkRequired(
                errorMsg: 'El correo electrónico es requerido'),
            AppInputTextValidators.checkEmail(
                errorMsg: 'Ingrese un formato de correo correcto'),
          ]),
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
          ),
          const SizedBox(height: 16),
          UIButton(
            onPressedFunc: () {},
            enabledColor: AppColors.secondary80Color,
            disabledColor: AppColors.secondary20Color,
            splashColor: AppColors.gray70Color,
            width: double.infinity,
            text: 'Editar',
            textStyle: AppFonts.subTitle2Heavy(
                color: AppColors.gray100Color, fontFamily: 'Ubuntu'),
          )
        ],
      ),
    );
  }
}

class MyProfileInformationPasswordForm extends StatelessWidget {
  const MyProfileInformationPasswordForm({
    super.key,
    required this.documentOptions,
  });

  final List<DropdownMenuItem<String>> documentOptions;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: const BoxDecoration(
          color: AppColors.gray100Color,
          borderRadius: BorderRadius.all(Radius.circular(8))),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'Cambiar contraseña',
            textAlign: TextAlign.start,
            style: AppFonts.subTitle2Heavy(
                color: AppColors.black20Color, fontFamily: 'Ubuntu'),
          ),
          const SizedBox(height: 8),
          //+ Contraseña actual
          CoreUIInputText(
            labelText: 'Contraseña actual',
            validators: [
              AppInputTextValidators.checkRequired(
                  errorMsg: 'La contraseña actual es requerida'),
            ],
          ),
          const SizedBox(height: 14),
          //+ Contraseña nueva
          CoreUIInputText(
            labelText: 'Contraseña nueva',
            validators: [
              AppInputTextValidators.checkRequired(
                  errorMsg: 'La contraseña nueva es requerida'),
            ],
          ),
          const SizedBox(height: 16),
          UIButton(
            onPressedFunc: () {},
            enabledColor: AppColors.secondary80Color,
            disabledColor: AppColors.secondary20Color,
            splashColor: AppColors.gray100Color,
            width: double.infinity,
            text: 'Cambiar contraseña',
            textStyle: AppFonts.subTitle2Heavy(
                color: AppColors.gray100Color, fontFamily: 'Ubuntu'),
          )
        ],
      ),
    );
  }
}

class MyProfileInformationCard extends StatelessWidget {
  const MyProfileInformationCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: const BoxDecoration(
          color: AppColors.gray100Color,
          borderRadius: BorderRadius.all(Radius.circular(8))),
      child:
          Row(crossAxisAlignment: CrossAxisAlignment.center, children: <Widget>[
        Container(
          height: 100,
          width: 100,
          decoration: const BoxDecoration(
              color: AppColors.blue100Color,
              borderRadius: BorderRadius.all(Radius.circular(100))),
          child: Center(
            child: Text(
              'AD',
              textAlign: TextAlign.start,
              style: AppFonts.bigTitleHeavy(
                  color: AppColors.gray100Color, fontFamily: 'Roboto'),
            ),
          ),
        ),
        const SizedBox(
          width: 16,
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Andrés Ángel Duran Ccota',
              textAlign: TextAlign.start,
              style: AppFonts.subTitle2Heavy(
                  color: AppColors.black20Color, fontFamily: 'Ubuntu'),
            ),
            Text(
              'andres_angeles@hotmail.es',
              textAlign: TextAlign.start,
              style: AppFonts.labelTextLight(
                  color: AppColors.black20Color, fontFamily: 'Ubuntu'),
            )
          ],
        ),
      ]),
    );
  }
}
