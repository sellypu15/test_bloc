import 'package:dio/dio.dart';
import 'package:test_bloc/module/product/model/detail_product.dart';

class DetailRepo {
  final Dio dio = Dio();

  Future<DetailProduct> getDetailData(String url) async {
    Response response = await dio.get(url);
    return DetailProduct.fromJson(response.data);
  }
}
