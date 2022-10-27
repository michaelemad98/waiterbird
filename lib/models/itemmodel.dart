// To parse this JSON data, do
//
//     final itemModel = itemModelFromMap(jsonString);

import 'dart:convert';

class ItemModel {
  ItemModel({
    this.data,
    this.message,
    this.success,
    this.authorized,
  });

  List<Datum>? data;
  String? message;
  bool ?success;
  bool ?authorized;

  factory ItemModel.fromJson(String str) => ItemModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ItemModel.fromMap(Map<String, dynamic> json) => ItemModel(
    data: List<Datum>.from(json["Data"].map((x) => Datum.fromMap(x))),
    message: json["Message"],
    success: json["Success"],
    authorized: json["Authorized"],
  );

  Map<String, dynamic> toMap() => {
    "Data": List<dynamic>.from(data!.map((x) => x.toMap())),
    "Message": message,
    "Success": success,
    "Authorized": authorized,
  };
}



class Datum {
  Datum({
    this.id,
    this.nameArabic,
    this.nameEnglish,
    this.name,
    this.image,
    this.imageUrl,
    this.description,
    this.price,
    this.displayOrder,
    this.isBuffetMeal,
    this.isPreSetMeal,
    this.apperInBuffet,
    this.apperInFeast,
    this.apperInCashier,
    this.items,
    this.images,
    this.products,
    this.categoryId,
    this.cardSizes,
  });

  int ?id;
  String? nameArabic;
  String ?nameEnglish;
  String ?name;
  String ?image;
  dynamic imageUrl;
  String ?description;
  int? price;
  dynamic displayOrder;
  bool? isBuffetMeal;
  bool ?isPreSetMeal;
  bool ?apperInBuffet;
  bool ?apperInFeast;
  bool ?apperInCashier;
  dynamic ?items;
  List<dynamic> ?images;
  dynamic ?products;
  int ?categoryId;
  List<CardSize>? cardSizes;

  factory Datum.fromJson(String str) => Datum.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Datum.fromMap(Map<String, dynamic> json) => Datum(
    id: json["ID"],
    nameArabic: json["NameArabic"],
    nameEnglish: json["NameEnglish"],
    name: json["Name"],
    image: json["Image"],
    imageUrl: json["ImageUrl"],
    description: json["Description"],
    price: json["Price"],
    displayOrder: json["DisplayOrder"],
    isBuffetMeal: json["IsBuffetMeal"],
    isPreSetMeal: json["IsPreSetMeal"],
    apperInBuffet: json["ApperInBuffet"],
    apperInFeast: json["ApperInFeast"],
    apperInCashier: json["ApperInCashier"],
    items: json["Items"],
    images: json["Images"] == null ? null : List<dynamic>.from(json["Images"].map((x) => x)),
    products: json["Products"],
    categoryId: json["CategoryID"],

    cardSizes: json["CardSizes"] == null ? null : List<CardSize>.from(json["CardSizes"].map((x) => CardSize.fromMap(x))),
  );

  Map<String, dynamic> toMap() => {
    "ID": id,
    "NameArabic": nameArabic,
    "NameEnglish": nameEnglish,
    "Name": name,
    "Image": image,
    "ImageUrl": imageUrl,
    "Description": description,
    "Price": price,
    "DisplayOrder": displayOrder,
    "IsBuffetMeal": isBuffetMeal,
    "IsPreSetMeal": isPreSetMeal,
    "ApperInBuffet": apperInBuffet,
    "ApperInFeast": apperInFeast,
    "ApperInCashier": apperInCashier,
    "Items": items,
    "Images": images == null ? null : List<dynamic>.from(images!.map((x) => x)),
    "Products": products,
    "CategoryID": categoryId,
    "CardSizes": cardSizes == null ? null : List<dynamic>.from(cardSizes!.map((x) => x.toMap())),
  };
}
class CardSize {
  CardSize({
    this.id,
    this.size,
    this.price,
    this.availableAmount,
    this.cardSizeItems,
  });

  int? id;
  Size? size;
  int? price;
  int ?availableAmount;
  dynamic? cardSizeItems;

  factory CardSize.fromJson(String str) => CardSize.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory CardSize.fromMap(Map<String, dynamic> json) => CardSize(
    id: json["ID"],
    size: Size.fromMap(json["Size"]),
    price: json["Price"],
    availableAmount: json["AvailableAmount"],
    cardSizeItems: json["CardSizeItems"],
  );

  Map<String, dynamic> toMap() => {
    "ID": id,
    "Size": size!.toMap(),
    "Price": price,
    "AvailableAmount": availableAmount,
    "CardSizeItems": cardSizeItems,
  };
}

class Size {
  Size({
    this.id,
    this.nameArabic,
    this.nameEnglish,
    this.stores,
    this.code,
    this.name,
  });

  int? id;
  String ?nameArabic;
  String ?nameEnglish;
  dynamic ?stores;
  String ?code;
  String ?name;

  factory Size.fromJson(String str) => Size.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Size.fromMap(Map<String, dynamic> json) => Size(
    id: json["ID"],
    nameArabic: json["NameArabic"],
    nameEnglish: json["NameEnglish"],
    stores: json["Stores"],
    code: json["Code"] == null ? null : json["Code"],
    name: json["Name"],
  );

  Map<String, dynamic> toMap() => {
    "ID": id,
    "NameArabic": nameArabic,
    "NameEnglish": nameEnglish,
    "Stores": stores,
    "Code": code == null ? null : code,
    "Name": name,
  };
}
