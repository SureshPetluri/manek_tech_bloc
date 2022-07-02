import '../model/product_listing_model.dart';
import 'package:dio/dio.dart';

class ApiProvider {
  final String getURL =
      "http://205.134.254.135/~mobile/MtProject/public/api/product_list.php";

  Future<ProductListingModel> getProductsData(int pageNumber) async {
    final queryParams = {
      'page': pageNumber,
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
      ProductListingModel productList = dashBoardModelFromJson(res.data);

      return productList;
    } catch (e) {
      throw Exception('Failed to load medicine');
    }
  }
}

class NetworkError extends Error {}
