import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
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
  });
}
