import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:marvel/features/presentation/pages/details_page/widgets/character_description.dart';
import 'package:network_image_mock/network_image_mock.dart';

import '../../../../../test_resources/entities/random_entities.dart';

main() {
  Widget createWidgetForTesting(child) => MaterialApp(
        home: Material(
          child: child,
        ),
      );

  final character = randomCharacters[0];

  group('ComicsList group =>', () {
    testWidgets('Should render [CharacterDescription] widget', (tester) async {
      mockNetworkImagesFor(() async {
        await tester.pumpWidget(
          createWidgetForTesting(
            CharacterDescription(
              description: character.description,
            ),
          ),
        );

        expect(find.text(character.description), findsOneWidget);
      });
    });
  });
}
