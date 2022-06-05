import 'package:flutter/material.dart';
import 'package:marvel/config/app_font_size.dart';
import 'package:marvel/config/app_padding.dart';
import 'package:marvel/config/app_texts.dart';
import 'package:marvel/config/app_spacing.dart';
import 'package:marvel/theme/app_colors.dart';

class CharacterDescription extends StatelessWidget {
  final String description;

  const CharacterDescription({Key? key, required this.description})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: AppPadding.large,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            AppTexts.description,
            style: TextStyle(
              color: AppColors.grey,
              fontSize: AppFontSize.medium,
            ),
          ),
          const SizedBox(
            height: AppSpacing.small,
          ),
          Text(
            description,
          ),
        ],
      ),
    );
  }
}
