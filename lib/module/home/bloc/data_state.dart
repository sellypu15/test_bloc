import 'package:equatable/equatable.dart';
import 'package:test_bloc/module/home/model/data_product.dart';

abstract class DataState extends Equatable {
  const DataState();

  @override
  List<Object?> get props => [];
}

class DataLoading extends DataState {}

class DataLoaded extends DataState {
  final DataProduct dataModel;
  const DataLoaded(this.dataModel);
}

class DataError extends DataState {
  final String? message;
  const DataError(this.message);
}
