import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:marvel/core/status/status.dart';
import 'package:marvel/features/presentation/bloc/characters_bloc/characters_bloc.dart';
import 'package:marvel/features/presentation/pages/home_page/home_page.dart';
import 'package:marvel/features/presentation/pages/home_page/widgets/home_page_body.dart';
import 'package:network_image_mock/network_image_mock.dart';

class MockCharacterBloc extends MockBloc<CharactersEvent, CharactersState>
    implements CharactersBloc {}

main() {
  final mockCharacterBloc = MockCharacterBloc();

  final serviceLocator = GetIt.instance;

  Widget createWidgetForTesting(child) => MaterialApp(
        home: Material(
          child: child,
        ),
      );

  group('HomePage group => ', () {
    setUpAll(() {
      serviceLocator
          .registerLazySingleton<CharactersBloc>(() => mockCharacterBloc);
    });

    tearDownAll(() {
      mockCharacterBloc.close();
    });

    testWidgets('Should render [HomePage] widget and inject bloc',
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
            const HomePage(),
          ),
        );

        expect(find.byType(HomePageBody), findsOneWidget);
      });
    });
  });
}
