import 'package:flutter/material.dart';
import 'package:marvel/config/app_padding.dart';

class BottomLoadingWidget extends StatelessWidget {
  const BottomLoadingWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: AppPadding.medium,
      child: CircularProgressIndicator(),
    );
  }
}
