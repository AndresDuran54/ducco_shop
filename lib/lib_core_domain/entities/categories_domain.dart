// ignore_for_file: non_constant_identifier_names

//+ ++++++++++++++++++++++++++++++++++++++++++++++++++
//+ CATEGORIES
//+ ++++++++++++++++++++++++++++++++++++++++++++++++++

class Category {
  int categoryId;
  String nameFo;
  String cardTitleFo;
  String cardSubTitleFo;
  String cardImgUrlFo;
  int cardShowFo;
  int cardOrderFo;
  int insTimestamp;

  Category({
    required this.categoryId,
    required this.nameFo,
    required this.cardTitleFo,
    required this.cardSubTitleFo,
    required this.cardImgUrlFo,
    required this.cardShowFo,
    required this.cardOrderFo,
    required this.insTimestamp,
  });

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        categoryId: json["categoryId"],
        nameFo: json["nameFO"],
        cardTitleFo: json["cardTitleFO"],
        cardSubTitleFo: json["cardSubTitleFO"],
        cardImgUrlFo: json["cardImgUrlFO"],
        cardShowFo: json["cardShowFO"],
        cardOrderFo: json["cardOrderFO"],
        insTimestamp: json["insTimestamp"],
      );
}

class CategoriesGetItems {
  late List<Category> items;
  late int itemsCounter;
  late int itemsCounterTotal;

  CategoriesGetItems({
    required this.items,
    required this.itemsCounter,
    required this.itemsCounterTotal,
  });
}

class CategoriesGetItemsError {
  late bool INTERNAL_SERVER_ERROR;

  CategoriesGetItemsError(String messageId) {
    switch (messageId) {
      case "INTERNAL_SERVER_ERROR":
        INTERNAL_SERVER_ERROR = true;
        break;
      default:
        INTERNAL_SERVER_ERROR = true;
    }
  }
}
