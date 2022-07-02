import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import '../model/local_storage_model.dart';

class LocalStorage {
  static var box = GetStorage();
  static List<LocalStorageCartModel> getListDeviceFromStorage() {
    if (box.read("localCartData") is List<LocalStorageCartModel>) {
      return box.read("localCartData");
    } else {
      List<dynamic>? lst = box.read("localCartData");

      List<LocalStorageCartModel>? tempListElse =
          lst?.map((e) => LocalStorageCartModel.fromJson(e)).toList();
      return tempListElse ?? [];
    }
  }

  static TextStyle buildTextStyle({String? appBar}) => TextStyle(
      fontWeight: appBar == "appBar" ? FontWeight.w700 : FontWeight.w500,
      fontSize: appBar == "appBar" ? 20 : 13);
}
