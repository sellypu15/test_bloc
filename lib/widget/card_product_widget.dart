import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:test_bloc/core/style/app_color.dart';
import 'package:test_bloc/core/style/app_typography.dart';
import 'package:test_bloc/core/var/variable_global.dart';
import 'package:test_bloc/module/home/model/data_product.dart';
import 'package:test_bloc/widget/disc_bookmark_widget.dart';

class CardProductWidget extends StatelessWidget {
  List<Product> promoList;
  int index;
  bool visible;
  bool disc;
  CardProductWidget(
      {super.key,
      required this.promoList,
      required this.disc,
      required this.index,
      required this.visible});

  @override
  Widget build(BuildContext context) {
    double percent = (int.parse(promoList[index].productSellingPrice) -
            int.parse(promoList[index].price)) /
        int.parse(promoList[index].productSellingPrice) *
        100;
    return Column(
      children: [
        Stack(
          alignment: Alignment.topRight,
          children: [
            Image.network(
              promoList[index].defaultImageUrl,
              fit: BoxFit.fill,
            ),
            DiscBookmarkWidget(visible: disc, txt: percent.toStringAsFixed(0))
          ],
        ),
        Container(
          margin: const EdgeInsets.only(left: 10, right: 10),
          child: Column(children: [
            Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  promoList[index].name,
                  style: AppTypography.body(color: Colors.black, fz: 12),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                )),
            Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  promoList[index].unit,
                  style: AppTypography.body(color: Colors.black, fz: 12),
                )),
            Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Rp ${indonesiaCurrencyFormat(int.parse(promoList[index].price))}',
                  style: AppTypography.headline(color: AppColors.redMainColor),
                )),
            Visibility(
                visible: visible,
                child: Align(
                    alignment: Alignment.centerLeft,
                    child: RichText(
                      text: TextSpan(
                        text:
                            'Rp ${indonesiaCurrencyFormat(int.parse(promoList[index].productSellingPrice))}',
                        style: AppTypography.body(
                            color: Colors.grey,
                            fz: 12,
                            td: TextDecoration.lineThrough),
                      ),
                    )))
          ]),
        )
      ],
    );
  }
}
