import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:marvel/features/presentation/pages/home_page/widgets/character_list_tile.dart';
import 'package:mockito/mockito.dart';
import 'package:network_image_mock/network_image_mock.dart';

import '../../../../../test_resources/entities/random_entities.dart';

abstract class OnTapHandler {
  void call();
}

class MockOnTapHandler extends Mock implements OnTapHandler {}

main() {
  Widget createWidgetForTesting(child) => MaterialApp(
        home: Material(
          child: child,
        ),
      );

  final mockOnTapHandler = MockOnTapHandler();

  group('CharacterListTile group =>', () {
    tearDown(() {
      reset(mockOnTapHandler);
    });

    final character = randomCharacters[0];

    testWidgets(
        'should render a [CharacterListTile] widget and when tap call [onTap]',
        (tester) async {
      mockNetworkImagesFor(() async {
        await tester.pumpWidget(
          createWidgetForTesting(
            CharacterListTile(
              character: randomCharacters[0],
              onTap: mockOnTapHandler,
            ),
          ),
        );

        await tester.pump();

        await tester.tap(find.byType(CharacterListTile));

        expect(find.text(character.name), findsOneWidget);

        verify(mockOnTapHandler()).called(1);

        verifyNoMoreInteractions(mockOnTapHandler);
      });
    });
  });
}
