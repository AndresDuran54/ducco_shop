// ignore_for_file: non_constant_identifier_names
class IEnvDomainMicrosWallet {
  final String HOST;

  const IEnvDomainMicrosWallet({required this.HOST});
}

class IEnvDomainMicrosProduts {
  final String HOST;

  const IEnvDomainMicrosProduts({required this.HOST});
}

class IEnvDomainMicros {
  final IEnvDomainMicrosProduts PRODUCTS;
  final IEnvDomainMicrosWallet WALLET;

  const IEnvDomainMicros({required this.PRODUCTS, required this.WALLET});
}

class IEnvDomain {
  final IEnvDomainMicros MICROS;

  const IEnvDomain({required this.MICROS});
}

IEnvDomain env = const IEnvDomain(
    MICROS: IEnvDomainMicros(
        PRODUCTS: IEnvDomainMicrosProduts(HOST: "http://10.0.2.2:8080"),
        WALLET: IEnvDomainMicrosWallet(HOST: "http://127.0.0.1:9001")));
