
import 'package:coloring/model_view/data_provider.dart';
import 'package:coloring/utils/colors_utils.dart';
import 'package:flutter/material.dart';

Row indicatorItems(DataProvider value, int currentPage) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: List.generate(
      3,
      (index) => Padding(
        padding: const EdgeInsets.only(left: 8),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
          height: 6,
          width: (index == currentPage) ? 30.95 : 6,
          decoration: BoxDecoration(
            color: (index == currentPage)
                ? hexToColor(value.data.mainColor.toString())
                : const Color(0xffB8B8B8),
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    ),
  );
}
