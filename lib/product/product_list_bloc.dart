import 'package:flutter_bloc/flutter_bloc.dart';
import '../api_provider/api_provider.dart';
import '../repository/repository.dart';
import 'product_list_event.dart';
import 'product_list_state.dart';

class ProductListBloc extends Bloc<ProductListEvent, ProductListState> {
  ProductListBloc() : super(ProductListInitial()) {
    final ApiRepository apiRepository = ApiRepository();

    on<GetProductList>((event, emit) async {
      try {
        emit(ProductListLoading());
        final mList = await apiRepository.fetchCartList(event.number);
        emit(ProductListLoaded(mList));
      } on NetworkError {
        emit(const ProductListError(
            "Failed to fetch data. is your device online?"));
      }
    });
  }
}
