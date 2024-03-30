// ignore_for_file: non_constant_identifier_names

//+ ++++++++++++++++++++++++++++++++++++++++++++++++++
//+ CATEGORIES
//+ ++++++++++++++++++++++++++++++++++++++++++++++++++

class CategoryFilter {
  String title;
  String filter;
  String type;
  List<CategoryFilterOption> options;
  String pattern;
  bool expanded;

  CategoryFilter(
      {required this.title,
      required this.filter,
      required this.type,
      required this.options,
      required this.pattern,
      this.expanded = false});

  factory CategoryFilter.fromJson(Map<String, dynamic> json) => CategoryFilter(
        title: json["title"],
        filter: json["filter"],
        type: json["type"],
        options: json["options"] == null
            ? []
            : List<CategoryFilterOption>.from(
                json["options"]!.map((x) => CategoryFilterOption.fromJson(x))),
        pattern: json["pattern"],
      );
}

class CategoryFilterOption {
  String id;
  String label;
  bool selected;

  CategoryFilterOption(
      {required this.id, required this.label, this.selected = false});

  factory CategoryFilterOption.fromJson(Map<String, dynamic> json) =>
      CategoryFilterOption(
        id: json["id"],
        label: json["label"],
      );
}

class Category {
  int categoryId;
  String nameFo;
  String cardTitleFo;
  String cardSubTitleFo;
  String cardImgUrlFo;
  int cardShowFo;
  int cardOrderFo;
  List<CategoryFilter> cardFiltersFo;
  int insTimestamp;

  Category({
    required this.categoryId,
    required this.nameFo,
    required this.cardTitleFo,
    required this.cardSubTitleFo,
    required this.cardImgUrlFo,
    required this.cardShowFo,
    required this.cardOrderFo,
    required this.cardFiltersFo,
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
        cardFiltersFo: List<CategoryFilter>.from(json["cardFiltersFO"]
            .map((filter) => CategoryFilter.fromJson(filter))),
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
