

import 'package:manek_tech/model/product_listing_model.dart';

import '../api_provider/api_provider.dart';

class ApiRepository {
  final _provider = ApiProvider();

  Future<ProductListingModel> fetchCartList() {
    return _provider.getCardData();
  }
}