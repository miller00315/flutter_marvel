import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:marvel/core/error/failures.dart';
import 'package:marvel/features/domain/repositories/characters_repository.dart';
import 'package:marvel/features/domain/usecases/fetch_characters_usecase.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../test_resources/entities/random_entities.dart';
import 'fetch_caharacters_usecase_test.mocks.dart';

@GenerateMocks([CharactersRepository])
main() {
  final repository = MockCharactersRepository();

  group('FetchCharactersUsecase group =>', () {
    tearDown(() {
      reset(repository);
    });

    test(
      'should return a [List<Character>] on the right side when request success',
      () async {
        final fetchCharacterUsecase = FetchCharactersUsecaseImpl(repository);

        when(repository.fetchCharacters(randomFilter)).thenAnswer(
          (_) => Future.value(
            right(randomCharacters),
          ),
        );

        final data = await fetchCharacterUsecase(randomFilter);

        data.fold(
          (l) => fail('should not return left side'),
          (r) => expect(r, randomCharacters),
        );

        verify(repository.fetchCharacters(randomFilter)).called(1);

        verifyNoMoreInteractions(repository);
      },
    );

    test(
      'should return a [ServerFailure] on the left side when request fails',
      () async {
        final fetchCharacterUsecase = FetchCharactersUsecaseImpl(repository);

        when(repository.fetchCharacters(randomFilter)).thenAnswer(
          (_) => Future.value(
            left(ServerFailure()),
          ),
        );

        final data = await fetchCharacterUsecase(randomFilter);

        data.fold(
          (l) => expect(l, isInstanceOf<ServerFailure>()),
          (r) => fail('should not return right side'),
        );

        verify(repository.fetchCharacters(randomFilter)).called(1);

        verifyNoMoreInteractions(repository);
      },
    );

    test(
      'should return a [UnexpectedFailure] on the left side when a unknown failure happen',
      () async {
        final fetchCharacterUsecase = FetchCharactersUsecaseImpl(repository);

        when(repository.fetchCharacters(randomFilter)).thenAnswer(
          (_) => Future.value(
            left(UnexpectedFailure()),
          ),
        );

        final data = await fetchCharacterUsecase(randomFilter);

        data.fold(
          (l) => expect(l, isInstanceOf<UnexpectedFailure>()),
          (r) => fail('should not return right side'),
        );

        verify(repository.fetchCharacters(randomFilter)).called(1);

        verifyNoMoreInteractions(repository);
      },
    );
  });
}
