import 'package:equatable/equatable.dart';
import 'package:manek_tech/model/dash_board_model.dart';

abstract class CartState extends Equatable {
  const CartState();

  @override
  List<Object?> get props => [];
}

class CartInitial extends CartState {}

class CartLoading extends CartState {}

class CartLoaded extends CartState {
  final DashBoardModel dashBoardModel;
  const CartLoaded(this.dashBoardModel);
}

class CartError extends CartState {
  final String? message;
  const CartError(this.message);
}