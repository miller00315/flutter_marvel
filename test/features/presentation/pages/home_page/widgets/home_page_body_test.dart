import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:marvel/core/status/status.dart';
import 'package:marvel/features/domain/entities/character.dart';
import 'package:marvel/features/presentation/bloc/characters_bloc/characters_bloc.dart';
import 'package:marvel/features/presentation/pages/home_page/widgets/character_list_tile.dart';
import 'package:marvel/features/presentation/pages/home_page/widgets/home_page_body.dart';
import 'package:mockito/mockito.dart';
import 'package:network_image_mock/network_image_mock.dart';

import '../../../../../test_resources/entities/random_entities.dart';

class MockCharacterBloc extends MockBloc<CharactersEvent, CharactersState>
    implements CharactersBloc {}

abstract class OnTapHandler {
  void call(Character character);
}

class MockOnTapHandler extends Mock implements OnTapHandler {}

main() {
  final mockCharacterBloc = MockCharacterBloc();

  Widget createWidgetForTesting(child) => MaterialApp(
        home: Material(
          child: BlocProvider<CharactersBloc>(
            create: (_) => mockCharacterBloc,
            child: child,
          ),
        ),
      );

  final mockOnTapHandler = MockOnTapHandler();

  group('HomePageBody group =>', () {
    tearDown(() {
      reset(mockOnTapHandler);
    });

    tearDownAll(() {
      mockCharacterBloc.close();
    });

    testWidgets(
        'should render home page body with a list of characters and when press a CharacterListTile should call mockOnTapHandler',
        (tester) async {
      mockNetworkImagesFor(() async {
        whenListen(
          mockCharacterBloc,
          Stream.fromIterable(
            [
              CharactersState(
                characters: const [],
                fetchStatus: InProgress(),
              ),
              CharactersState(
                characters: randomCharacters,
                fetchStatus: Done(),
              ),
            ],
          ),
          initialState: CharactersState.initial(),
        );

        await tester.pumpWidget(
          createWidgetForTesting(
            HomePageBody(
              handleCharacterListTileTap: mockOnTapHandler,
            ),
          ),
        );

        await tester.pump();

        final characterListTile = find.byType(CharacterListTile);

        expect(characterListTile, findsNWidgets(2));
      });
    });
  });
}
