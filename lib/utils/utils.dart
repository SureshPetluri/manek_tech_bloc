import 'package:flutter/material.dart';
import '../model/local_storage_model.dart';
import '../sqflite_db/sqflite_db.dart';

class AppUtils {
  static final dbHelper = DatabaseHelper.instance;
  static Future<List<LocalStorageCartModel>> getListDeviceFromStorage() async {
    List<Map<String, dynamic>>? lst = await dbHelper.queryAllRows();

    List<LocalStorageCartModel> tempListElse =
        lst.map((e) => LocalStorageCartModel.fromJson(e)).toList();
    return tempListElse;
  }

  static TextStyle buildTextStyle({String? appBar}) => TextStyle(
      fontWeight: appBar == "appBar" ? FontWeight.w700 : FontWeight.w500,
      fontSize: appBar == "appBar" ? 20 : 13);
}
