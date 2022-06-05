import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:marvel/config/app_font_size.dart';
import 'package:marvel/config/app_letter_spacing.dart';
import 'package:marvel/config/app_images.dart';
import 'package:marvel/config/app_spacing.dart';
import 'package:marvel/features/domain/entities/character.dart';
import 'package:marvel/features/presentation/pages/details_page/widgets/character_description.dart';
import 'package:marvel/features/presentation/pages/details_page/widgets/comics_list.dart';

class DetailsPage extends StatelessWidget {
  static const routeName = '/details';
  final Character character;

  const DetailsPage({
    Key? key,
    required this.character,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          character.name,
          style: const TextStyle(
            letterSpacing: AppLetterSpacing.small,
            fontSize: AppFontSize.big,
          ),
        ),
        centerTitle: true,
      ),
      body: SizedBox.expand(
        child: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage(AppImages.darkBackgroundImage),
              fit: BoxFit.fill,
            ),
          ),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height / 2 - 100,
                  width: double.maxFinite,
                  child: CachedNetworkImage(
                    imageUrl:
                        '${character.thumbnail.path}.${character.thumbnail.extension}',
                    fit: BoxFit.fitWidth,
                    progressIndicatorBuilder: (context, url, progress) =>
                        Center(
                      child: CircularProgressIndicator(
                        value: progress.progress,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: AppSpacing.medium,
                ),
                if (character.description.isNotEmpty)
                  CharacterDescription(
                    description: character.description,
                  ),
                const SizedBox(
                  height: AppSpacing.medium,
                ),
                ComicsList(comics: character.comics),
                const SizedBox(
                  height: AppSpacing.medium,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
