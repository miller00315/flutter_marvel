import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:marvel/core/error/failures.dart';
import 'package:marvel/core/status/status.dart';
import 'package:marvel/features/domain/usecases/fetch_characters_usecase.dart';
import 'package:marvel/features/presentation/bloc/characters_bloc/characters_bloc.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../test_resources/entities/random_entities.dart';
import 'characters_bloc_test.mocks.dart';

@GenerateMocks([FetchCharactersUsecase])
main() {
  final fetchCharactersUsecase = MockFetchCharactersUsecase();

  group('CharactersBloc group =>', () {
    tearDown(() {
      reset(fetchCharactersUsecase);
    });

    blocTest<CharactersBloc, CharactersState>(
      'should emit [DoneStatus] and a [List<Character>] when request success',
      build: () => CharactersBloc(fetchCharactersUsecase),
      setUp: () {
        when(fetchCharactersUsecase(randomFilter)).thenAnswer(
          (_) => Future.value(
            right(randomCharacters),
          ),
        );
      },
      act: (bloc) => bloc.add(FetchCharactersEvent(randomFilter)),
      verify: (_) {
        verify(fetchCharactersUsecase(randomFilter)).called(1);
        verifyNoMoreInteractions(fetchCharactersUsecase);
      },
      expect: () => [
        CharactersState(characters: [], fetchStatus: InProgress()),
        CharactersState(characters: randomCharacters, fetchStatus: Done()),
      ],
    );

    blocTest<CharactersBloc, CharactersState>(
      'should emit [Error] when request fail',
      build: () => CharactersBloc(fetchCharactersUsecase),
      setUp: () {
        when(fetchCharactersUsecase(randomFilter)).thenAnswer(
          (_) => Future.value(
            left(ServerFailure()),
          ),
        );
      },
      act: (bloc) => bloc.add(FetchCharactersEvent(randomFilter)),
      verify: (_) {
        verify(fetchCharactersUsecase(randomFilter)).called(1);
        verifyNoMoreInteractions(fetchCharactersUsecase);
      },
      expect: () => [
        CharactersState(characters: [], fetchStatus: InProgress()),
        CharactersState(characters: [], fetchStatus: Error()),
      ],
    );
  });
}
