import 'package:dio/dio.dart';
import 'package:test_bloc/core/var/variable_global.dart';
import 'package:test_bloc/module/home/model/data_product.dart';

class DataRepo {
  final Dio dio = Dio();
  final String url =
      'https://61ea514a7bc0550017bc66b4.mockapi.io/api/v1/products';

  Future<DataProduct> getData() async {
    Response response = await dio.get(url);
    DataProduct product = DataProduct.fromJson(response.data);
    allList = product.products;
    return product;
  }
}
