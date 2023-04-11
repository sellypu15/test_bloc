import 'package:intl/intl.dart';
import 'package:test_bloc/module/home/model/data_product.dart';

List<Product> promoList = [];
List<Product> normalList = [];
List<Product> otherList = [];
List<Product> allList = [];

String indonesiaCurrencyFormat(int value) {
  final formatter = NumberFormat("#,##0", "pt_BR");
  return formatter.format(value);
}