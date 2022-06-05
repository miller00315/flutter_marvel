import 'package:flutter/material.dart';
import 'package:marvel/config/app_font_size.dart';
import 'package:marvel/config/app_letter_spacing.dart';

final ThemeData marvelTheme = _buildMarvelTheme();

ThemeData _buildMarvelTheme() {
  final ThemeData base = ThemeData.light();

  return base.copyWith(
    colorScheme: base.colorScheme.copyWith(
      primary: Colors.black,
    ),
    textTheme: _buildTextTheme(base.textTheme),
  );
}

TextTheme _buildTextTheme(TextTheme base) {
  return base
      .copyWith(
        headline5: base.headline5!.copyWith(
          fontWeight: FontWeight.w500,
        ),
        headline6: base.headline6!.copyWith(
          fontWeight: FontWeight.w400,
          fontSize: AppFontSize.small,
        ),
        caption: base.caption!.copyWith(
          fontWeight: FontWeight.w400,
          fontSize: AppFontSize.big,
        ),
        bodyText1: base.bodyText1!.copyWith(
          fontWeight: FontWeight.w500,
          fontSize: AppFontSize.medium,
          letterSpacing: AppLetterSpacing.medium,
        ),
        bodyText2: base.bodyText2!.copyWith(
          letterSpacing: AppLetterSpacing.medium,
        ),
      )
      .apply(
        fontFamily: 'Marvel',
        displayColor: Colors.white,
        bodyColor: Colors.white,
      );
}
