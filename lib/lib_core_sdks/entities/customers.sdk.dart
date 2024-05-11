// ignore_for_file: non_constant_identifier_names, prefer_initializing_formals

//+ CUSTOMERS
class SDKCustomersNewItem {
  late dynamic item;
  late dynamic session;

  SDKCustomersNewItem({
    required this.item,
    required this.session,
  });
}

class SDKCustomersNewItemError extends Error {
  SDKCustomersNewItemError();
}

//+ SESSIONS
class SDKSessionsLogin {
  late dynamic item;
  late dynamic customer;

  SDKSessionsLogin({
    required this.item,
    required this.customer,
  });
}

class SDKSessionsLoginError extends Error {
  SDKSessionsLoginError();
}

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
