import 'package:flutter/material.dart';
import 'package:test_bloc/core/style/app_color.dart';
import 'package:test_bloc/core/style/app_typography.dart';

class DiscBookmarkWidget extends StatelessWidget {
  bool visible;
  String txt;
  DiscBookmarkWidget({super.key, required this.visible, required this.txt});

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: visible,
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          const Icon(
            Icons.bookmark,
            color: AppColors.redMainColor,
            size: 60,
          ),
          Text(
            ' -$txt%',
            style: AppTypography.body(color: Colors.white, fz: 12),
          ),
        ],
      ),
    );
  }
}
