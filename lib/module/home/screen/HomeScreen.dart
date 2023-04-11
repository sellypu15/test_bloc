import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_bloc/core/assets/app_assets.dart';
import 'package:test_bloc/core/style/app_color.dart';
import 'package:test_bloc/core/style/app_typography.dart';
import 'package:test_bloc/module/home/bloc/data_bloc.dart';
import 'package:test_bloc/module/home/bloc/data_event.dart';
import 'package:test_bloc/module/home/bloc/data_state.dart';
import 'package:test_bloc/module/home/model/data_product.dart';
import 'package:test_bloc/core/var/variable_global.dart';
import 'package:test_bloc/module/product/screen/detail_screen.dart';
import 'package:test_bloc/widget/card_product_widget.dart';
import 'package:test_bloc/widget/disc_bookmark_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => DataBloc()..add(GetDataList()),
        child: Scaffold(
            backgroundColor: Colors.white,
            body: BlocBuilder<DataBloc, DataState>(builder: (context, state) {
              if (state is DataLoading) {
                return buildLoading();
              } else if (state is DataLoaded) {
                return body(state.dataModel);
              }
              return Container();
            })));
  }

  Widget body(DataProduct product) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(color: AppColors.redMainColor, child: search()),
        Expanded(
          child: SingleChildScrollView(
              child: Column(
            children: [
              Container(
                  color: AppColors.redMainColor, child: hotPromo(product)),
              grid(product)
            ],
          )),
        )
      ],
    );
  }

  Widget search() {
    return Container(
      margin: const EdgeInsets.fromLTRB(20, 50, 20, 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: const TextField(
        textAlignVertical: TextAlignVertical.center,
        keyboardType: TextInputType.multiline,
        decoration: InputDecoration(
            border: InputBorder.none,
            hintText: 'Search ..',
            prefixIcon: Icon(Icons.search)),
      ),
    );
  }

  Widget hotPromo(DataProduct product) {
    promoList = product.products
        .where((element) => element.productDiscountPrice != '0')
        .toList();

    return Container(
        height: MediaQuery.of(context).size.height / 2.5,
        margin: const EdgeInsets.all(10),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          children: [
            Row(
              children: [
                Text(
                  'Hot Promo',
                  style: AppTypography.headline(color: AppColors.redMainColor),
                ),
                const SizedBox(
                  width: 8,
                ),
                Image.asset(
                  AppAssets.fireImg,
                  height: MediaQuery.of(context).size.height / 25,
                )
              ],
            ),
            Expanded(
                child: ListView.builder(
                    padding: const EdgeInsets.all(5),
                    shrinkWrap: true,
                    physics: const ScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    itemCount: promoList.length,
                    itemBuilder: (BuildContext context, int index) {
                      return InkWell(
                          onTap: () {
                            otherList = product.products
                                .where((element) =>
                                    element.detailEndpoint !=
                                    promoList[index].detailEndpoint)
                                .toList();
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => DetailProductScreen(
                                  url: promoList[index].detailEndpoint,
                                  otherProduct: otherList,
                                ),
                              ),
                            );
                          },
                          child: Container(
                              width: MediaQuery.of(context).size.width / 3,
                              decoration: const BoxDecoration(
                                  color: Colors.white,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                  boxShadow: [
                                    BoxShadow(
                                        blurRadius: 6,
                                        offset: Offset(0, 2),
                                        color: Colors.grey)
                                  ]),
                              margin: const EdgeInsets.only(right: 15),
                              child: CardProductWidget(
                                  promoList: promoList,
                                  index: index,
                                  visible: true,
                                  disc: true)));
                    }))
          ],
        ));
  }

  Widget grid(DataProduct product) {
    normalList = product.products
        .where((element) => element.productDiscountPrice == '0')
        .toList();
    double height = MediaQuery.of(context).size.height / 2.5;
    double width = MediaQuery.of(context).size.width / 2;
    double ratio = width / height;
    return Container(
        margin: const EdgeInsets.only(left: 10, right: 10, bottom: 80, top: 20),
        child: GridView.builder(
          padding: EdgeInsets.zero,
          shrinkWrap: true,
          itemCount: normalList.length,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 25,
            childAspectRatio: ratio,
          ),
          itemBuilder: (context, index) {
            return InkWell(
                onTap: () {
                  otherList = product.products
                      .where((element) =>
                          element.detailEndpoint !=
                          normalList[index].detailEndpoint)
                      .toList();
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => DetailProductScreen(
                              url: normalList[index].detailEndpoint,
                              otherProduct: otherList,
                            )),
                  );
                },
                child: Container(
                    width: MediaQuery.of(context).size.width / 5,
                    margin: const EdgeInsets.only(right: 5, left: 5),
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
                      promoList: normalList,
                      index: index,
                      visible: false,
                      disc: false,
                    )
                    // card(normalList, index, false, false),
                    ));
          },
        ));
  }

  Widget buildLoading() => const Center(child: CircularProgressIndicator());
}
