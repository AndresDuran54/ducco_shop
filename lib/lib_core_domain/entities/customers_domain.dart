// ignore_for_file: non_constant_identifier_names

class Customer {
  String firstName;
  String lastName;
  String identId;
  String identification;
  String email;
  String password;
  String phoneNumber;
  int birthdayTimestamp;
  int insTimestamp;

  Customer({
    required this.firstName,
    required this.lastName,
    required this.identId,
    required this.identification,
    required this.email,
    required this.password,
    required this.phoneNumber,
    required this.birthdayTimestamp,
    required this.insTimestamp,
  });

  factory Customer.fromJson(Map<String, dynamic> json) => Customer(
        firstName: json["firstName"],
        lastName: json["lastName"],
        identId: json["identId"],
        identification: json["identification"],
        email: json["email"],
        password: json["password"],
        phoneNumber: json["phoneNumber"],
        birthdayTimestamp: json["birthdayTimestamp"],
        insTimestamp: json["insTimestamp"],
      );

  Map<String, dynamic> toJson() => {
        "firstName": firstName,
        "lastName": lastName,
        "identId": identId,
        "identification": identification,
        "email": email,
        "password": password,
        "phoneNumber": phoneNumber,
        "birthdayTimestamp": birthdayTimestamp,
        "insTimestamp": insTimestamp,
      };
}

class CustomersNewItem {
  late Customer item;

  CustomersNewItem({
    required this.item,
  });
}

class CustomersNewItemError {
  late bool INTERNAL_SERVER_ERROR;

  CustomersNewItemError(String messageId) {
    switch (messageId) {
      case "INTERNAL_SERVER_ERROR":
        INTERNAL_SERVER_ERROR = true;
        break;
      default:
        INTERNAL_SERVER_ERROR = true;
    }
  }
}
