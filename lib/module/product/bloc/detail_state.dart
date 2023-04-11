import 'package:equatable/equatable.dart';
import 'package:test_bloc/module/product/model/detail_product.dart';

abstract class DetailState extends Equatable {
  const DetailState();

  @override
  List<Object?> get props => [];
}

class DetailLoading extends DetailState {}

class DetailLoaded extends DetailState {
  final DetailProduct detailModel;
  const DetailLoaded(this.detailModel);
}

class DataError extends DetailState {
  final String? message;
  const DataError(this.message);
}
