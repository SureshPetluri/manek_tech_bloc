import 'package:ecommerce_app/model/product_listing_model.dart';
import '../api_provider/api_provider.dart';

class ApiRepository {
  final _provider = ApiProvider();

  Future<ProductListingModel> fetchCartList(int number) {
    return _provider.getProductsData(number);
  }
}
