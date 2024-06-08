// ignore_for_file: non_constant_identifier_names

//+ PAYMENT METHODS

class PaymentMethod {
  int paymentMethodId;
  String cardTitleFo;
  String cardImgUrlFo;
  int cardOrderFo;
  int insTimestamp;

  PaymentMethod({
    required this.paymentMethodId,
    required this.cardTitleFo,
    required this.cardImgUrlFo,
    required this.cardOrderFo,
    required this.insTimestamp,
  });

  factory PaymentMethod.fromJson(Map<String, dynamic> json) => PaymentMethod(
        paymentMethodId: json["paymentMethodId"],
        cardTitleFo: json["cardTitleFO"],
        cardImgUrlFo: json["cardImgUrlFO"],
        cardOrderFo: json["cardOrderFO"],
        insTimestamp: json["insTimestamp"],
      );

  Map<String, dynamic> toJson() => {
        "paymentMethodId": paymentMethodId,
        "cardTitleFO": cardTitleFo,
        "cardImgUrlFO": cardImgUrlFo,
        "cardOrderFO": cardOrderFo,
        "insTimestamp": insTimestamp,
      };
}

class PaymentMethodsItems {
  late List<PaymentMethod> items;

  PaymentMethodsItems({
    required this.items,
  });
}

class PaymentMethodsItemsError {
  late bool INTERNAL_SERVER_ERROR;

  PaymentMethodsItemsError(String messageId) {
    switch (messageId) {
      case "INTERNAL_SERVER_ERROR":
        INTERNAL_SERVER_ERROR = true;
        break;
      default:
        INTERNAL_SERVER_ERROR = true;
    }
  }
}

//+ ORDERS

class OrderNewItem {
  late Order item;

  OrderNewItem({
    required this.item,
  });
}

class OrderNewItemError {
  late bool INTERNAL_SERVER_ERROR;

  PaymentMethodsItemsError(String messageId) {
    switch (messageId) {
      case "INTERNAL_SERVER_ERROR":
        INTERNAL_SERVER_ERROR = true;
        break;
      default:
        INTERNAL_SERVER_ERROR = true;
    }
  }
}

class Order {
  int orderId;
  int customerId;
  OrderAddressCustomer addressCustomer;
  int amount;
  int partialAmount;
  int deliveryAmount;
  int status;
  int paymentMethodId;
  dynamic deliveryTimestamp;
  int insTimestamp;
  dynamic cancelTimestamp;

  Order({
    required this.orderId,
    required this.customerId,
    required this.addressCustomer,
    required this.amount,
    required this.partialAmount,
    required this.deliveryAmount,
    required this.status,
    required this.paymentMethodId,
    required this.deliveryTimestamp,
    required this.insTimestamp,
    required this.cancelTimestamp,
  });

  factory Order.fromJson(Map<String, dynamic> json) => Order(
        orderId: json["orderId"],
        customerId: json["customerId"],
        addressCustomer: OrderAddressCustomer.fromJson(json["addressCustomer"]),
        amount: json["amount"],
        partialAmount: json["partialAmount"],
        deliveryAmount: json["deliveryAmount"],
        status: json["status"],
        paymentMethodId: json["paymentMethodId"],
        deliveryTimestamp: json["deliveryTimestamp"],
        insTimestamp: json["insTimestamp"],
        cancelTimestamp: json["cancelTimestamp"],
      );

  Map<String, dynamic> toJson() => {
        "orderId": orderId,
        "customerId": customerId,
        "addressCustomer": addressCustomer.toJson(),
        "amount": amount,
        "partialAmount": partialAmount,
        "deliveryAmount": deliveryAmount,
        "status": status,
        "paymentMethodId": paymentMethodId,
        "deliveryTimestamp": deliveryTimestamp,
        "insTimestamp": insTimestamp,
        "cancelTimestamp": cancelTimestamp,
      };
}

class OrderAddressCustomer {
  String address;
  String district;
  String floorApartment;
  String reference;

  OrderAddressCustomer({
    required this.address,
    required this.district,
    required this.floorApartment,
    required this.reference,
  });

  factory OrderAddressCustomer.fromJson(Map<String, dynamic> json) =>
      OrderAddressCustomer(
        address: json["address"],
        district: json["district"],
        floorApartment: json["floorApartment"],
        reference: json["reference"],
      );

  Map<String, dynamic> toJson() => {
        "address": address,
        "district": district,
        "floorApartment": floorApartment,
        "reference": reference,
      };
}

//+ PARAMETERS
class Parameter {
  String paramId;
  int value;
  String description;
  int type;
  int insTimestamp;

  Parameter({
    required this.paramId,
    required this.value,
    required this.description,
    required this.type,
    required this.insTimestamp,
  });

  factory Parameter.fromJson(Map<String, dynamic> json) => Parameter(
        paramId: json["paramId"],
        value: json["value"],
        description: json["description"],
        type: json["type"],
        insTimestamp: json["insTimestamp"],
      );

  Map<String, dynamic> toJson() => {
        "paramId": paramId,
        "value": value,
        "description": description,
        "type": type,
        "insTimestamp": insTimestamp,
      };
}

class ParameterItem {
  late Parameter item;

  ParameterItem({
    required this.item,
  });
}

class ParameterItemError {
  late bool ERR_PARAMETER_NOT_FOUND;
  late bool INTERNAL_SERVER_ERROR;

  PaymentMethodsItemsError(String messageId) {
    switch (messageId) {
      case "ERR_PARAMETER_NOT_FOUND":
        INTERNAL_SERVER_ERROR = true;
        break;
      default:
        INTERNAL_SERVER_ERROR = true;
    }
  }
}
