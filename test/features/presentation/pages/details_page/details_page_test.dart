import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:marvel/config/app_texts.dart';
import 'package:marvel/features/domain/entities/character.dart';
import 'package:marvel/features/presentation/pages/details_page/details_page.dart';
import 'package:network_image_mock/network_image_mock.dart';

import '../../../../test_resources/entities/random_entities.dart';

main() {
  Widget createWidgetForTesting(child) => MaterialApp(
        home: Material(
          child: child,
        ),
      );

  final character = randomCharacters[0];

  group('DetailsPage group', () {
    testWidgets('Should render [DetailsPage] widget', (tester) async {
      mockNetworkImagesFor(() async {
        await tester.pumpWidget(
          createWidgetForTesting(
            DetailsPage(
              character: randomCharacters[0],
            ),
          ),
        );

        expect(find.text(character.name), findsOneWidget);
        expect(find.text(character.description), findsOneWidget);

        for (final comic in character.comics) {
          expect(find.text(comic.name), findsOneWidget);
        }
      });
    });

    testWidgets('Should render [DetailsPage] widget without description',
        (tester) async {
      mockNetworkImagesFor(() async {
        final characterWithoutDescription = Character(
          comics: character.comics,
          description: '',
          id: character.id,
          name: character.name,
          thumbnail: character.thumbnail,
        );

        await tester.pumpWidget(
          createWidgetForTesting(
            DetailsPage(
              character: characterWithoutDescription,
            ),
          ),
        );

        expect(find.text(characterWithoutDescription.name), findsOneWidget);
        expect(find.text(AppTexts.description), findsNothing);

        for (final comic in characterWithoutDescription.comics) {
          expect(find.text(comic.name), findsOneWidget);
        }
      });
    });
  });
}
