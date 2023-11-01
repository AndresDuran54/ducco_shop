class AppInputTextValidators {
  /// Esta función comprueba si un string es un email o no
  ///
  /// [value] Valor a verificar.
  /// [errorMsg] Mensaje de error en caso no sea un email.
  ///
  /// Devuelve null si value es un email y errorMsg si no.
  static String? Function({required String value}) checkEmail(
      {required String errorMsg}) {
    return ({required String value}) {
      RegExp emailRegExp =
          RegExp(r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)*(\.[a-z]{2,4})$');
      return emailRegExp.hasMatch(value) ? null : errorMsg;
    };
  }

  /// Esta función comprueba si un string está vació o no
  ///
  /// [value] Valor a verificar.
  /// [errorMsg] Mensaje de error en caso no sea un email.
  ///
  /// Devuelve null si value no está vació y errorMsg si lo está.
  static String? Function({required String value}) checkRequired(
      {required String errorMsg}) {
    return ({required String value}) {
      return value.isNotEmpty ? null : errorMsg;
    };
  }

  /// Esta función comprueba si un string es un número o no
  ///
  /// [value] Valor a verificar.
  /// [errorMsg] Mensaje de error en caso no sea un número.
  ///
  /// Devuelve null si value es un número y errorMsg si no.
  static String? Function({required String value}) checkNumber(
      {required String errorMsg}) {
    return ({required String value}) {
      RegExp numberRegExp = RegExp(r'^[0-9]+$');
      return numberRegExp.hasMatch(value) ? null : errorMsg;
    };
  }

  /// Esta función comprueba si un string es un texto o no
  ///
  /// [value] Valor a verificar.
  /// [errorMsg] Mensaje de error en caso no sea un texto.
  ///
  /// Devuelve null si value es un texto y errorMsg si no.
  static String? Function({required String value}) checkText(
      {required String errorMsg}) {
    return ({required String value}) {
      RegExp textRegExp = RegExp(r'^[a-zA-Z\sÀ-ÖØ-öø-ÿ]+$');
      return textRegExp.hasMatch(value) ? null : errorMsg;
    };
  }
}
