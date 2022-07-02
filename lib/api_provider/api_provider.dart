import '../model/dash_board_model.dart';
import 'package:dio/dio.dart';

class ApiProvider {
  final String getURL =
      "http://205.134.254.135/~mobile/MtProject/public/api/product_list.php";

  Future<DashBoardModel> getCardData() async {
    final queryParams = {
      'page': 1,
      'perPage': 5,
    };

    try {
      final res = await Dio().post(
        getURL,
        options: Options(headers: {
          "token":
              "eyJhdWQiOiI1IiwianRpIjoiMDg4MmFiYjlmNGU1MjIyY2MyNjc4Y2FiYTQwOGY2MjU4Yzk5YTllN2ZkYzI0NWQ4NDMxMTQ4ZWMz"
        }),
        queryParameters: queryParams,
      );
      DashBoardModel medicine = dashBoardModelFromJson(res.data);

      return medicine;
    } catch (e) {
      throw Exception('Failed to load medicine');
    }
  }
}

class NetworkError extends Error {}
