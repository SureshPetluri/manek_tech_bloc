import 'package:equatable/equatable.dart';
import 'package:manek_tech/model/product_listing_model.dart';

abstract class productListState extends Equatable {
  const productListState();

  @override
  List<Object?> get props => [];
}

class ProductListInitial extends productListState {}

class ProductListLoading extends productListState {}

class ProductListLoaded extends productListState {
  final ProductListingModel dashBoardModel;
  const ProductListLoaded(this.dashBoardModel);
}

class ProductListError extends productListState {
  final String? message;
  const ProductListError(this.message);
}