import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:marvel/features/presentation/pages/home_page/widgets/character_grid_cell.dart';
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

  group('CharacterGridCell group =>', () {
    tearDown(() {
      reset(mockOnTapHandler);
    });

    final character = randomCharacters[0];

    testWidgets(
        'should render a [CharacterGridCell] widget and when tap call [onTap]',
        (tester) async {
      mockNetworkImagesFor(() async {
        await tester.pumpWidget(
          createWidgetForTesting(
            CharacterGridCell(
              character: randomCharacters[0],
              onTap: mockOnTapHandler,
            ),
          ),
        );

        await tester.pump();

        await tester.tap(find.byType(CharacterGridCell));

        expect(find.text(character.name), findsOneWidget);

        verify(mockOnTapHandler()).called(1);

        verifyNoMoreInteractions(mockOnTapHandler);
      });
    });
  });
}
