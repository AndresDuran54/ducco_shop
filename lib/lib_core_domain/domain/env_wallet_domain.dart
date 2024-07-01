// ignore_for_file: non_constant_identifier_names

class IEnvDomainMicrosWalletVarsParameters {
  final String ORDERS_DEFAULT_DELIVERY_PRICE;

  const IEnvDomainMicrosWalletVarsParameters(
      {required this.ORDERS_DEFAULT_DELIVERY_PRICE});
}

class IEnvDomainMicrosWalletVars {
  final IEnvDomainMicrosWalletVarsParameters PARAMETERS;

  const IEnvDomainMicrosWalletVars({required this.PARAMETERS});
}

class IEnvDomainMicrosWallet {
  final String HOST;
  final IEnvDomainMicrosWalletVars VARS;

  const IEnvDomainMicrosWallet({required this.HOST, required this.VARS});
}
