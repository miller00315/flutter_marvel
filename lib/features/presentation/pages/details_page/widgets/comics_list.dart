import 'package:flutter/material.dart';
import 'package:marvel/config/app_font_size.dart';
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
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Comics',
            style: TextStyle(color: Colors.grey),
          ),
          const SizedBox(
            height: 12,
          ),
          Container(
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(12),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: ListView.separated(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(
                    comics[index].name,
                    style: const TextStyle(
                      letterSpacing: 0.32,
                      fontSize: AppFontSize.small,
                    ),
                  ),
                );
              },
              separatorBuilder: (context, index) => Container(
                height: 1,
                width: double.maxFinite,
                color: Colors.white,
              ),
              itemCount: comics.length,
            ),
          ),
        ],
      ),
    );
  }
}
