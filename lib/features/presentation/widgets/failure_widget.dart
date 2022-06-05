import 'package:flutter/material.dart';
import 'package:marvel/config/app_images.dart';
import 'package:marvel/config/app_texts.dart';
import 'package:marvel/config/app_spacing.dart';

class FailureWidget extends StatelessWidget {
  final void Function() handleTryAgainPressed;

  const FailureWidget({
    Key? key,
    required this.handleTryAgainPressed,
  }) : super(key: key);

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
              const Text(AppTexts.fetchError),
              const SizedBox(
                height: AppSpacing.extraSmall,
              ),
              IconButton(
                onPressed: handleTryAgainPressed,
                icon: const Icon(Icons.error),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
