import 'package:http/http.dart';
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
      print("medicine in api.....${res.data}");
      DashBoardModel medicine = dashBoardModelFromJson(res.data);

      print("medicine in api.....$medicine");
      print("dfgjdkgjdkgjdkfjhdkjvb.....${medicine.data?[0]?.id}");

      return medicine;
    } catch (e) {
      throw Exception('Failed to load medicine');
    }
  }
  // Future<DashBoardModel> getCardData() async {
  //   final queryParams = {
  //     'param1': 'one',
  //     'param2': 'two',
  //   };
  //     Response res = await http.get(Uri.parse(getURL,));
  //
  //     if (res.statusCode == 200) {
  //       var medicine = dashBoardModelFromJson(res.body);
  //       print("dfgjdkgjdkgjdkfjhdkjvb.....${medicine.data?[0]?.id}");
  //       return medicine;
  //     } else {
  //       throw Exception('Failed to load medicine');
  //     }
  //
  // }

}

class NetworkError extends Error {}
