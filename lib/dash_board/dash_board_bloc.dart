import 'package:flutter_bloc/flutter_bloc.dart';
import '../api_provider/api_provider.dart';
import '../repository/repository.dart';
import 'dash_board_event.dart';
import 'dash_board_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc() : super(CartInitial()) {
    final ApiRepository apiRepository = ApiRepository();

    on<GetCartList>((event, emit) async {
      try {
        emit(CartLoading());
        final mList = await apiRepository.fetchCartList();
        emit(CartLoaded(mList));
      } on NetworkError {
        emit(const CartError("Failed to fetch data. is your device online?"));
      }
    });
  }
}
