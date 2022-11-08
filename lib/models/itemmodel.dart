// To parse this JSON data, do
//
//     final itemModel = itemModelFromJson(jsonString);

import 'dart:convert';

ItemModel itemModelFromJson(String str) => ItemModel.fromJson(json.decode(str));

String itemModelToJson(ItemModel data) => json.encode(data.toJson());

class ItemModel {
  ItemModel({
    this.data,
    this.message,
    this.success,
    this.authorized,
  });

  List<Datum>? data;
  String ?message;
  bool ?success;
  bool ?authorized;

  factory ItemModel.fromJson(Map<String, dynamic> json) => ItemModel(
    data: List<Datum>.from(json["Data"].map((x) => Datum.fromJson(x))),
    message: json["Message"],
    success: json["Success"],
    authorized: json["Authorized"],
  );

  Map<String, dynamic> toJson() => {
    "Data": List<dynamic>.from(data!.map((x) => x.toJson())),
    "Message": message,
    "Success": success,
    "Authorized": authorized,
  };
}

class Datum {
  Datum({
    this.categoryId,
    this.image,
    this.name,
    this.id,
    this.nameArabic,
    this.nameEnglish,
    this.description,
    this.cardSizes,
  });

  int ?categoryId;
  String? image;
  String? name;
  int ?id;
  String? nameArabic;
  String ?nameEnglish;
  String ?description;
  List<CardSize> ?cardSizes;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    categoryId: json["CategoryID"],
    image: json["Image"],
    name: json["Name"],
    id: json["ID"],
    nameArabic: json["NameArabic"],
    nameEnglish: json["NameEnglish"],
    description: json["Description"],
    cardSizes: List<CardSize>.from(json["CardSizes"].map((x) => CardSize.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "CategoryID": categoryId,
    "Image": image,
    "Name": name,
    "ID": id,
    "NameArabic": nameArabic,
    "NameEnglish": nameEnglish,
    "Description": description,
    "CardSizes": List<dynamic>.from(cardSizes!.map((x) => x.toJson())),
  };
}

class CardSize {
  CardSize({
    this.id,
    this.price,
    this.size,
  });

  int ?id;
  double? price;
  Size ?size;

  factory CardSize.fromJson(Map<String, dynamic> json) => CardSize(
    id: json["ID"],
    price: json["Price"],
    size: Size.fromJson(json["Size"]),
  );

  Map<String, dynamic> toJson() => {
    "ID": id,
    "Price": price,
    "Size": size!.toJson(),
  };
}

class Size {
  Size({
    this.id,
    this.name,
    this.nameArabic,
    this.nameEnglish,
  });

  int ?id;
  String ?name;
  String ?nameArabic;
  String ?nameEnglish;

  factory Size.fromJson(Map<String, dynamic> json) => Size(
    id: json["ID"],
    name: json["Name"],
    nameArabic: json["NameArabic"],
    nameEnglish: json["NameEnglish"],
  );

  Map<String, dynamic> toJson() => {
    "ID": id,
    "Name": name,
    "NameArabic": nameArabic,
    "NameEnglish": nameEnglish,
  };
}
