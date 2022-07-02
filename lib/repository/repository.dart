

import 'package:manek_tech/model/dash_board_model.dart';

import '../api_provider/api_provider.dart';

class ApiRepository {
  final _provider = ApiProvider();

  Future<DashBoardModel> fetchCartList() {
    return _provider.getCardData();
  }
}