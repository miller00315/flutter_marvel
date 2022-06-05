import 'dart:math';

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:marvel/core/status/status.dart';
import 'package:marvel/features/domain/entities/character.dart';
import 'package:marvel/features/presentation/bloc/characters_bloc/characters_bloc.dart';
import 'package:marvel/features/presentation/pages/home_page/widgets/character_list_tile.dart';
import 'package:marvel/features/presentation/pages/home_page/widgets/home_page_body.dart';
import 'package:marvel/features/presentation/widgets/bottom_loading_widget.dart';
import 'package:marvel/features/presentation/widgets/empty_list_widget.dart';
import 'package:marvel/features/presentation/widgets/failure_widget.dart';
import 'package:marvel/features/presentation/widgets/loading_widget.dart';
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

    testWidgets('should render home [HomePageBody[BottomLoadingWidget]]',
        (tester) async {
      mockNetworkImagesFor(() async {
        whenListen(
          mockCharacterBloc,
          Stream.fromIterable([
            CharactersState(
              characters: const [],
              fetchStatus: InProgress(),
            ),
          ]),
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

        expect(find.byType(LoadingWidget), findsOneWidget);

        expect(find.byType(CharacterListTile), findsNothing);

        expect(find.byType(FailureWidget), findsNothing);

        expect(find.byType(EmptyListWidget), findsNothing);
      });
    });

    testWidgets('should render home [HomePageBody] with error widget',
        (tester) async {
      mockNetworkImagesFor(() async {
        whenListen(
          mockCharacterBloc,
          Stream.fromIterable([
            CharactersState(
              characters: const [],
              fetchStatus: Error(),
            ),
          ]),
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

        expect(find.byType(LoadingWidget), findsNothing);

        expect(find.byType(CharacterListTile), findsNothing);

        expect(find.byType(FailureWidget), findsOneWidget);

        expect(find.byType(EmptyListWidget), findsNothing);
      });
    });

    testWidgets('should render home [HomePageBody] with empty list widget',
        (tester) async {
      mockNetworkImagesFor(() async {
        whenListen(
          mockCharacterBloc,
          Stream.fromIterable([
            CharactersState(
              characters: const [],
              fetchStatus: Done(),
            ),
          ]),
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

        expect(find.byType(LoadingWidget), findsNothing);

        expect(find.byType(CharacterListTile), findsNothing);

        expect(find.byType(FailureWidget), findsNothing);

        expect(find.byType(EmptyListWidget), findsOneWidget);
      });
    });

    testWidgets('should render home [HomePageBody] with a list of [Character]',
        (tester) async {
      mockNetworkImagesFor(() async {
        whenListen(
          mockCharacterBloc,
          Stream.fromIterable(
            [
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

        expect(find.byType(LoadingWidget), findsNothing);

        expect(
          find.byType(CharacterListTile),
          findsNWidgets(randomCharacters.length),
        );

        expect(find.byType(FailureWidget), findsNothing);

        expect(find.byType(EmptyListWidget), findsNothing);

        expect(find.byType(LoadingWidget), findsNothing);

        expect(find.byType(BottomLoadingWidget), findsNothing);
      });
    });

    testWidgets(
        'should render home [HomePageBody] with a list of characters and a [BottomLoadingWidget]]',
        (tester) async {
      mockNetworkImagesFor(() async {
        whenListen(
          mockCharacterBloc,
          Stream.fromIterable(
            [
              CharactersState(
                characters: randomCharacters,
                fetchStatus: InProgress(),
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

        expect(find.byType(LoadingWidget), findsNothing);

        expect(
          find.byType(CharacterListTile),
          findsNWidgets(randomCharacters.length),
        );

        expect(find.byType(FailureWidget), findsNothing);

        expect(find.byType(EmptyListWidget), findsNothing);

        expect(find.byType(LoadingWidget), findsNothing);

        expect(find.byType(BottomLoadingWidget), findsOneWidget);
      });
    });
  });
}
