// ignore_for_file: non_constant_identifier_names

class SDKCategoriesGetItems {
  late List<dynamic> items;
  late int itemsCounter;
  late int itemsCounterTotal;

  SDKCategoriesGetItems({
    required this.items,
    required this.itemsCounter,
    required this.itemsCounterTotal,
  });
}

class SDKCategoriesGetItemsError {
  late String messageId;

  SDKCategoriesGetItemsError(String messageId) {
    messageId = messageId;
  }
}
