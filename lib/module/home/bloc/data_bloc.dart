import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_bloc/module/home/repo/api_repo.dart';

import 'data_event.dart';
import 'data_state.dart';

class DataBloc extends Bloc<DataEvent, DataState> {
  DataBloc() : super(DataLoading()) {
    final ApiRepository apiRepository = ApiRepository();
    on<GetDataList>((event, emit) async {
      try {
        final mData = await apiRepository.fetchData();
        emit(DataLoaded(mData));
      } on NetworkError {
        emit(const DataError("Failed to fetch data. is your device online?"));
      }
    });
  }
}
