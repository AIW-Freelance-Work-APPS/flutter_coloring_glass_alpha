import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

Widget appIcon(
    String path, bool isDark, BuildContext context, double height, double width,
    {Color color = Colors.transparent}) {
  return SvgPicture.asset(
    path,
    matchTextDirection: true,
    height: height,
    width: width,
    theme: (isDark)
        ? SvgTheme(
            currentColor: Theme.of(context).colorScheme.primaryContainer,
          )
        : const SvgTheme(
            currentColor: Colors.white,
          ),
    fit: BoxFit.fill,
    colorFilter: (isDark)
        ? ColorFilter.mode(
            Theme.of(context).colorScheme.primaryContainer, BlendMode.srcIn)
        : (color != Colors.transparent)
            ? ColorFilter.mode(color, BlendMode.srcIn)
            : null,
  );
}

String? encodeQueryParameters(Map<String, String> params) {
  return params.entries
      .map((MapEntry<String, String> e) =>
          '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}')
      .join('&');
}






