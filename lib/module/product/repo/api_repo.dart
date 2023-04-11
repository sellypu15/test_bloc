import 'package:test_bloc/module/product/api/data_repo.dart';
import 'package:test_bloc/module/product/model/detail_product.dart';

class ApiRepositoryDetail extends DetailRepo{

  Future<DetailProduct> fetchDetailDataProduct(String url) {
    return getDetailData(url);
  }

}
class NetworkError extends Error {}