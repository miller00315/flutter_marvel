import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:marvel/config/app_font_size.dart';
import 'package:marvel/features/domain/entities/character.dart';

class CharacterListTile extends StatelessWidget {
  final Character character;
  final VoidCallback onTap;

  const CharacterListTile(
      {Key? key, required this.character, required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: ClipRRect(
        key: Key(character.id.toString()),
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
          bottomRight: Radius.circular(20),
        ),
        child: Column(
          children: [
            Expanded(
              child: AspectRatio(
                aspectRatio: 2 / 1,
                child: CachedNetworkImage(
                  imageUrl:
                      '${character.thumbnail.path}.${character.thumbnail.extension}',
                  fit: BoxFit.fitWidth,
                  progressIndicatorBuilder: (context, url, progress) => Center(
                    child: CircularProgressIndicator(
                      value: progress.progress,
                    ),
                  ),
                ),
              ),
            ),
            Container(
              color: Colors.red,
              width: double.maxFinite,
              height: 2,
            ),
            Expanded(
              child: Container(
                color: Colors.black,
                width: double.maxFinite,
                padding: const EdgeInsets.all(5),
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        character.name,
                        style: const TextStyle(
                          color: Colors.white,
                          letterSpacing: 0.32,
                          fontSize: AppFontSize.big,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
