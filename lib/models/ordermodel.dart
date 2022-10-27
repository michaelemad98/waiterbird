// To parse this JSON data, do
//
//     final ordermodel = ordermodelFromMap(jsonString);

import 'dart:convert';

class Ordermodel {
  Ordermodel({
    this.data,
    this.message,
    this.success,
    this.authorized,
  });

  List<Datum> ?data;
  String ?message;
  bool ?success;
  bool? authorized;

  factory Ordermodel.fromJson(String str) => Ordermodel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Ordermodel.fromMap(Map<String, dynamic> json) => Ordermodel(
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
    this.number,
    this.orders,
  });

  dynamic number;
  List<Order> ?orders;

  factory Datum.fromJson(String str) => Datum.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Datum.fromMap(Map<String, dynamic> json) => Datum(
    number: json["Number"],
    orders: List<Order>.from(json["Orders"].map((x) => Order.fromMap(x))),
  );

  Map<String, dynamic> toMap() => {
    "Number": number,
    "Orders": List<dynamic>.from(orders!.map((x) => x.toMap())),
  };
}

class Order {
  Order({
    this.id,
    this.label,
    this.code,
    this.statusId,
    this.paymentStatusId,
  });

  int ?id;
  String ?label;
  String ?code;
  int ?statusId;
  int ?paymentStatusId;

  factory Order.fromJson(String str) => Order.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Order.fromMap(Map<String, dynamic> json) => Order(
    id: json["ID"],
    label: json["Label"] == null ? null : json["Label"],
    code: json["Code"],
    statusId: json["StatusID"],
    paymentStatusId: json["PaymentStatusID"],
  );

  Map<String, dynamic> toMap() => {
    "ID": id,
    "Label": label == null ? null : label,
    "Code": code,
    "StatusID": statusId,
    "PaymentStatusID": paymentStatusId,
  };
}
