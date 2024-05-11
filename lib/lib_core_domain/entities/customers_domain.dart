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
  late Session session;

  CustomersNewItem({
    required this.item,
    required this.session,
  });
}

//+ SESSIONS
class Session {
  int customerId;
  String token;
  int expTimestamp;
  int insTimestamp;

  Session({
    required this.customerId,
    required this.token,
    required this.expTimestamp,
    required this.insTimestamp,
  });

  factory Session.fromJson(Map<String, dynamic> json) => Session(
        customerId: json["customerId"],
        token: json["token"],
        expTimestamp: json["expTimestamp"],
        insTimestamp: json["insTimestamp"],
      );

  Map<String, dynamic> toJson() => {
        "customerId": customerId,
        "token": token,
        "expTimestamp": expTimestamp,
        "insTimestamp": insTimestamp,
      };
}

class SessionLogin {
  late Session item;
  late Customer customer;

  SessionLogin({
    required this.item,
    required this.customer,
  });
}
