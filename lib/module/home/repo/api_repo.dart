import 'package:test_bloc/module/home/api/data_repo.dart';
import 'package:test_bloc/module/home/model/data_product.dart';

class ApiRepository extends DataRepo{

  Future<DataProduct> fetchData() {
    return getData();
  }

}
class NetworkError extends Error {}