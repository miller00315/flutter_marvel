import 'package:flutter/material.dart';
import 'package:marvel/config/app_border_radius.dart';
import 'package:marvel/config/app_font_size.dart';
import 'package:marvel/config/app_padding.dart';
import 'package:marvel/config/app_texts.dart';
import 'package:marvel/config/app_spacing.dart';
import 'package:marvel/theme/app_colors.dart';
import 'package:marvel/features/domain/entities/comic.dart';

class ComicsList extends StatelessWidget {
  final List<Comic> comics;

  const ComicsList({
    Key? key,
    required this.comics,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: AppPadding.large,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            AppTexts.comics,
            style: TextStyle(color: AppColors.grey),
          ),
          const SizedBox(
            height: AppSpacing.small,
          ),
          Container(
            decoration: const BoxDecoration(
              color: AppColors.black,
              borderRadius: BorderRadius.all(AppBorderRadius.small),
            ),
            padding: AppPadding.medium,
            child: ListView.separated(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(
                    comics[index].name,
                    style: const TextStyle(
                      fontSize: AppFontSize.small,
                    ),
                  ),
                );
              },
              separatorBuilder: (context, index) => Container(
                height: 1,
                width: double.maxFinite,
                color: AppColors.white,
              ),
              itemCount: comics.length,
            ),
          ),
        ],
      ),
    );
  }
}
