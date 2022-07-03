import 'package:equatable/equatable.dart';
import 'package:ecommerce_app/model/product_listing_model.dart';

abstract class ProductListState extends Equatable {
  const ProductListState();

  @override
  List<Object?> get props => [];
}

class ProductListInitial extends ProductListState {}

class ProductListLoading extends ProductListState {}

class ProductListLoaded extends ProductListState {
  final ProductListingModel dashBoardModel;
  const ProductListLoaded(this.dashBoardModel);
}

class ProductListError extends ProductListState {
  final String? message;
  const ProductListError(this.message);
}
