// ignore_for_file: non_constant_identifier_names

//+ ++++++++++++++++++++++++++++++++++++++++++++++++++
//+ PRODUCTS
//+ ++++++++++++++++++++++++++++++++++++++++++++++++++

class Product {
  int productId;
  String name;
  String description;
  String nameFo;
  String descriptionFo;
  String cardTitleFo;
  String cardSubTitleFo;
  String cardImgUrlFo;
  String detailTitleFo;
  String detailSubTitleFo;
  String detailDescriptionFo;
  List<String> detailImagesUrlsFo;
  String detailDocIdFo;
  int inventoryStock;
  int inventorySalesQuantity;
  int inventoryPrice;
  int insTimestamp;

  Product({
    required this.productId,
    required this.name,
    required this.description,
    required this.nameFo,
    required this.descriptionFo,
    required this.cardTitleFo,
    required this.cardSubTitleFo,
    required this.cardImgUrlFo,
    required this.detailTitleFo,
    required this.detailSubTitleFo,
    required this.detailDescriptionFo,
    required this.detailImagesUrlsFo,
    required this.detailDocIdFo,
    required this.inventoryStock,
    required this.inventorySalesQuantity,
    required this.inventoryPrice,
    required this.insTimestamp,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      productId: json["productId"],
      name: json["name"],
      description: json["description"],
      nameFo: json["nameFO"],
      descriptionFo: json["descriptionFO"],
      cardTitleFo: json["cardTitleFO"],
      cardSubTitleFo: json["cardSubTitleFO"],
      cardImgUrlFo: json["cardImgUrlFO"],
      detailTitleFo: json["detailTitleFO"],
      detailSubTitleFo: json["detailSubTitleFO"],
      detailDescriptionFo: json["detailDescriptionFO"],
      detailImagesUrlsFo: List.from(json["detailImagesUrlsFO"]),
      detailDocIdFo: json["detailDocIdFO"],
      inventoryStock: json["inventoryStock"],
      inventorySalesQuantity: json["inventorySalesQuantity"],
      inventoryPrice: json["inventoryPrice"],
      insTimestamp: json["insTimestamp"],
    );
  }
}

class ProductsGetItems {
  late List<Product> items;
  late int itemsCounter;
  late int itemsCounterTotal;

  ProductsGetItems({
    required this.items,
    required this.itemsCounter,
    required this.itemsCounterTotal,
  });
}

class ProductsGetItemsError {
  late bool INTERNAL_SERVER_ERROR;

  ProductsGetItemsError(String messageId) {
    switch (messageId) {
      case "INTERNAL_SERVER_ERROR":
        INTERNAL_SERVER_ERROR = true;
        break;
      default:
        INTERNAL_SERVER_ERROR = true;
    }
  }
}
