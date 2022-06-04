import 'package:flutter/material.dart';
import 'package:marvel/config/app_font_size.dart';

class CharacterDescription extends StatelessWidget {
  final String description;

  const CharacterDescription({Key? key, required this.description})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Description',
            style: TextStyle(
              color: Colors.grey,
              fontSize: AppFontSize.medium,
            ),
          ),
          const SizedBox(
            height: 12,
          ),
          Text(description),
        ],
      ),
    );
  }
}
