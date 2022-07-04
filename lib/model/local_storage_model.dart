import 'dart:convert';

LocalStorageCartModel localStorageCartModelFromJson(String str) =>
    LocalStorageCartModel.fromJson(json.decode(str));

String localStorageCartModelToJson(LocalStorageCartModel data) =>
    json.encode(data.toJson());

class LocalStorageCartModel {
  LocalStorageCartModel({
    this.productId,
    this.productName,
    this.productImage,
    this.price,
    this.quantity,
  });
  int? productId;
  String? productName;
  String? productImage;
  int? price;
  int? quantity;

  factory LocalStorageCartModel.fromJson(Map<String, dynamic> json) =>
      LocalStorageCartModel(
        productId: json["productId"],
        productName: json["productName"],
        productImage: json["productImage"],
        price: json["price"],
        quantity: json["quantity"],
      );

  Map<String, dynamic> toJson() => {
        "productId": productId,
        "productName": productName,
        "productImage": productImage,
        "price": price,
        "quantity": quantity,
      };
}
