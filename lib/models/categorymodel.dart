// To parse this JSON data, do
//
//     final categorymodel = categorymodelFromJson(jsonString);

import 'dart:convert';

Categorymodel categorymodelFromJson(String str) => Categorymodel.fromJson(json.decode(str));

String categorymodelToJson(Categorymodel data) => json.encode(data.toJson());

class Categorymodel {
  Categorymodel({
    this.data,
    this.message,
    this.success,
    this.authorized,
  });

  List<Datum>? data;
  String? message;
  bool ?success;
  bool ?authorized;

  factory Categorymodel.fromJson(Map<String, dynamic> json) => Categorymodel(
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
    this.id,
    this.mainItemCategory,
    this.companyBranch,
    this.code,
    this.nameArabic,
    this.nameEnglish,
    this.isFavourite,
    this.itemCategories,
    this.items,
    this.cards,
    this.image,
    this.itemsCount,
    this.name,
  });

  int? id;
  dynamic mainItemCategory;
  dynamic companyBranch;
  String? code;
  String ?nameArabic;
  String ?nameEnglish;
  bool ?isFavourite;
  dynamic itemCategories;
  dynamic items;
  dynamic cards;
  String? image;
  int ?itemsCount;
  String ?name;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["ID"],
    mainItemCategory: json["MainItemCategory"],
    companyBranch: json["CompanyBranch"],
    code: json["Code"],
    nameArabic: json["NameArabic"],
    nameEnglish: json["NameEnglish"],
    isFavourite: json["IsFavourite"],
    itemCategories: json["ItemCategories"],
    items: json["Items"],
    cards: json["Cards"],
    image: json["Image"],
    itemsCount: json["ItemsCount"],
    name: json["Name"],
  );

  Map<String, dynamic> toJson() => {
    "ID": id,
    "MainItemCategory": mainItemCategory,
    "CompanyBranch": companyBranch,
    "Code": code,
    "NameArabic": nameArabic,
    "NameEnglish": nameEnglish,
    "IsFavourite": isFavourite,
    "ItemCategories": itemCategories,
    "Items": items,
    "Cards": cards,
    "Image": image,
    "ItemsCount": itemsCount,
    "Name": name,
  };
}
