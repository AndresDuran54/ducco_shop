// ignore_for_file: non_constant_identifier_names

class SDKProductsGetItems {
  late List<dynamic> items;
  late int itemsCounter;
  late int itemsCounterTotal;

  SDKProductsGetItems({
    required this.items,
    required this.itemsCounter,
    required this.itemsCounterTotal,
  });
}

class SDKProductsGetItemsError {
  late String messageId;

  SDKProductsGetItemsError(String messageId) {
    messageId = messageId;
  }
}
