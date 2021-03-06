import 'package:flutter/material.dart';
import 'package:marvel/config/app_images.dart';
import 'package:marvel/config/app_spacing.dart';
import 'package:marvel/theme/app_colors.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: Image.asset(
            AppImages.darkBackgroundImage,
            fit: BoxFit.fill,
          ),
        ),
        Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(
                AppImages.logo,
                width: 100,
              ),
              const SizedBox(
                height: AppSpacing.extraSmall,
              ),
              const CircularProgressIndicator(
                color: AppColors.white,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
