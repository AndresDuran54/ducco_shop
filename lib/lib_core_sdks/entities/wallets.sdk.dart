// ignore_for_file: non_constant_identifier_names, prefer_initializing_formals

//+ PAYMENT METHODS
class SDKPaymentMethodsGetItems {
  late List<dynamic> items;

  SDKPaymentMethodsGetItems({
    required this.items,
  });
}

//+ ORDERS
class SDKOrdersNewItem {
  late dynamic item;

  SDKOrdersNewItem({
    required this.item,
  });
}

//+ PARAMETERS
class SDKParametersItem {
  late dynamic item;

  SDKParametersItem({
    required this.item,
  });
}

//+ ERRORS
class SDKDataError {
  DataError data;

  SDKDataError({
    required this.data,
  });

  factory SDKDataError.fromJson(Map<String, dynamic> json) => SDKDataError(
        data: DataError.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "data": data.toJson(),
      };
}

class DataError {
  String messageId;
  String message;

  DataError({
    required this.messageId,
    required this.message,
  });

  factory DataError.fromJson(Map<String, dynamic> json) => DataError(
        messageId: json["messageId"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "messageId": messageId,
        "message": message,
      };
}
