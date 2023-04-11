import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_bloc/core/assets/app_assets.dart';
import 'package:test_bloc/core/style/app_color.dart';
import 'package:test_bloc/core/style/app_typography.dart';
import 'package:test_bloc/core/var/variable_global.dart';
import 'package:test_bloc/module/home/model/data_product.dart';
import 'package:test_bloc/module/product/bloc/detail_bloc.dart';
import 'package:test_bloc/module/product/bloc/detail_event.dart';
import 'package:test_bloc/module/product/bloc/detail_state.dart';
import 'package:test_bloc/module/product/model/detail_product.dart';
import 'package:test_bloc/widget/card_product_widget.dart';
import 'package:test_bloc/widget/disc_bookmark_widget.dart';

class DetailProductScreen extends StatelessWidget {
  String url;
  List<Product> otherProduct;
  DetailProductScreen(
      {super.key, required this.url, required this.otherProduct});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => DetailBloc(url)..add(GetDataDetail()),
        child: Scaffold(
            appBar: AppBar(
              actionsIconTheme: const IconThemeData(
                  size: 30.0, color: Colors.black, opacity: 10.0),
              backgroundColor: Colors.white.withOpacity(1),
              leading: IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.black),
                onPressed: () => Navigator.of(context).pop(),
              ),
              actions: <Widget>[
                Padding(
                    padding: const EdgeInsets.only(right: 20.0),
                    child: GestureDetector(
                        onTap: () {
                          ScaffoldMessenger.of(context)
                              .showSnackBar(const SnackBar(
                            content: Text('Cart'),
                          ));
                        },
                        child: Image.asset(
                          AppAssets.cartImg,
                          width: 20,
                          height: 20,
                        ))),
                Padding(
                    padding: const EdgeInsets.only(right: 20.0),
                    child: GestureDetector(
                      onTap: () {
                        ScaffoldMessenger.of(context)
                            .showSnackBar(const SnackBar(
                          content: Text('Profile'),
                        ));
                      },
                      child: Image.asset(
                        AppAssets.peopleImg,
                        width: 20,
                        height: 20,
                      ),
                    )),
              ],
            ),
            backgroundColor: Colors.white,
            body:
                BlocBuilder<DetailBloc, DetailState>(builder: (context, state) {
              if (state is DetailLoading) {
                return buildLoading();
              } else if (state is DetailLoaded) {
                return body(state.detailModel, context, otherProduct);
              }
              return Container();
            }),
            bottomNavigationBar: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.5,
                  height: MediaQuery.of(context).size.width / 7,
                  child: ElevatedButton(
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text('+ Keranjang'),
                      ));
                    },
                    style: ElevatedButton.styleFrom(
                        side: const BorderSide(color: AppColors.redMainColor),
                        backgroundColor: Colors.white,
                        elevation: 12.0,
                        textStyle:
                            const TextStyle(color: AppColors.redMainColor)),
                    child: Text(
                      '+ Keranjang',
                      style: AppTypography.body(color: AppColors.redMainColor),
                    ),
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.5,
                  height: MediaQuery.of(context).size.width / 7,
                  child: ElevatedButton(
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text('Beli Sekarang'),
                      ));
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.redMainColor,
                        elevation: 12.0,
                        textStyle: const TextStyle(color: Colors.white)),
                    child: const Text('Beli Sekarang'),
                  ),
                )
              ],
            )));
  }
}

Widget body(DetailProduct detailProduct, context, List<Product> otherItem) {
  double percent = (int.parse(detailProduct.data.productSellingPrice) -
          int.parse(detailProduct.data.price)) /
      int.parse(detailProduct.data.productSellingPrice) *
      100;
  return SingleChildScrollView(
    child: Column(children: [
      Image.network(detailProduct.data.defaultImageUrl),
      Container(
        padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
        child: Column(children: [
          Align(
              alignment: Alignment.centerLeft,
              child: Text(
                '${detailProduct.data.name}\n${detailProduct.data.unit}',
                style: AppTypography.headline(),
              )),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Rp ${indonesiaCurrencyFormat(int.parse(detailProduct.data.price))}',
                        style: AppTypography.headline(
                            color: AppColors.redMainColor),
                      )),
                  Visibility(
                      visible: detailProduct.data.productDiscountPrice == '0'
                          ? false
                          : true,
                      child: Align(
                          alignment: Alignment.centerLeft,
                          child: RichText(
                            text: TextSpan(
                              text:
                                  'Rp ${indonesiaCurrencyFormat(int.parse(detailProduct.data.productSellingPrice))}',
                              style: AppTypography.body(
                                  color: Colors.grey,
                                  fz: 12,
                                  td: TextDecoration.lineThrough),
                            ),
                          ))),
                ],
              ),
              DiscBookmarkWidget(
                  visible: detailProduct.data.productDiscountPrice == '0'
                      ? false
                      : true,
                  txt: percent.toStringAsFixed(0))
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          const Divider(
            height: 2,
            color: Colors.grey,
          ),
          const SizedBox(
            height: 20,
          ),
          Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'DESKRIPSI',
                style: AppTypography.headline(),
              )),
          const SizedBox(
            height: 20,
          ),
          Align(
              alignment: Alignment.centerLeft,
              child: Text(
                detailProduct.data.description,
                style: AppTypography.body(),
              )),
          const SizedBox(
            height: 20,
          ),
          const Divider(
            height: 2,
            color: Colors.grey,
          ),
          const SizedBox(
            height: 20,
          ),
          Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'PILIHAN LAINNYA',
                style: AppTypography.headline(),
              )),
          const SizedBox(
            height: 20,
          ),
          grid(otherItem, context)
        ]),
      )
    ]),
  );
}

Widget grid(
  List<Product> product,
  context,
) {
  double height = MediaQuery.of(context).size.height / 2.3;
  double width = MediaQuery.of(context).size.width / 2;
  double ratio = width / height;
  return Container(
      margin: const EdgeInsets.only(left: 10, right: 10, bottom: 80),
      child: GridView.builder(
        shrinkWrap: true,
        itemCount: product.length,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 25,
          childAspectRatio: ratio,
        ),
        itemBuilder: (context, index) {
          return InkWell(
              onTap: () {
                otherList = allList
                    .where((element) =>
                        element.detailEndpoint != product[index].detailEndpoint)
                    .toList();
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DetailProductScreen(
                      url: product[index].detailEndpoint,
                      otherProduct: otherList,
                    ),
                  ),
                );
              },
              child: Container(
                  width: MediaQuery.of(context).size.width / 5,
                  margin: const EdgeInsets.symmetric(horizontal: 5),
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      boxShadow: [
                        BoxShadow(
                            blurRadius: 6,
                            offset: Offset(0, 2),
                            color: Colors.grey)
                      ]),
                  child: CardProductWidget(
                    promoList: otherList,
                    index: index,
                    visible: otherList[index].productDiscountPrice == '0'
                        ? false
                        : true,
                    disc: otherList[index].productDiscountPrice == '0'
                        ? false
                        : true,
                  )));
        },
      ));
}

Widget buildLoading() => const Center(child: CircularProgressIndicator());
