// ignore_for_file: non_constant_identifier_names, prefer_initializing_formals

class SDKCustomersNewItem {
  late dynamic item;

  SDKCustomersNewItem({
    required this.item,
  });
}

class SDKCustomersNewItemError {
  late String messageId;

  SDKCustomersNewItemError(String messageId) {
    this.messageId = messageId;
  }
}
