import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_bloc/module/product/repo/api_repo.dart';

import 'detail_event.dart';
import 'detail_state.dart';

class DetailBloc extends Bloc<DetailEvent, DetailState> {
  DetailBloc(String url) : super(DetailLoading()) {
    final ApiRepositoryDetail apiRepository = ApiRepositoryDetail();
    on<GetDataDetail>((event, emit) async {
      try {
        final mData = await apiRepository.fetchDetailDataProduct(url);
        emit(DetailLoaded(mData));
      } on NetworkError {
        emit(const DataError("Failed to fetch data. is your device online?"));
      }
    });
  }
}
