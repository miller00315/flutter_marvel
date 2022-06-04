import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:marvel/core/error/failures.dart';
import 'package:marvel/features/data/data_sources/characters_data_source.dart';
import 'package:marvel/features/data/repositories/characters_repository_impl.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../test_resources/entities/random_entities.dart';
import 'character_repository_test.mocks.dart';

@GenerateMocks([CharactersDataSource])
main() {
  final mockedCharacterDataSource = MockCharactersDataSource();

  group('CharacterRepository group =>', () {
    tearDownAll(() {
      reset(mockedCharacterDataSource);
    });

    test('should return a [List<Charcater>] on the right when request success',
        () async {
      when(
        mockedCharacterDataSource.fetchCharacters(
          randomFilter,
        ),
      ).thenAnswer(
        (realInvocation) => Future.value(randomCharacterModels),
      );

      final characterRepository =
          CharactersRepositoryImpl(mockedCharacterDataSource);

      final data = await characterRepository.fetchCharacters(randomFilter);

      data.fold(
        (l) => fail('should not return left side'),
        (r) => expect(r, randomCharacterModels),
      );

      verify(mockedCharacterDataSource.fetchCharacters(
        randomFilter,
      )).called(1);

      verifyNoMoreInteractions(mockedCharacterDataSource);
    });

    test('should return a [ServerFailure] on the left side when request fail',
        () async {
      when(
        mockedCharacterDataSource.fetchCharacters(
          randomFilter,
        ),
      ).thenThrow(
        DioError(
          requestOptions: RequestOptions(path: 'https://test.com'),
        ),
      );

      final characterRepository =
          CharactersRepositoryImpl(mockedCharacterDataSource);

      final data = await characterRepository.fetchCharacters(randomFilter);

      data.fold(
        (l) => expect(l, isInstanceOf<ServerFailure>()),
        (r) => fail('should not return right side'),
      );

      verify(mockedCharacterDataSource.fetchCharacters(
        randomFilter,
      )).called(1);

      verifyNoMoreInteractions(mockedCharacterDataSource);
    });

    test(
        'should return a [UnexpectedFailure] on the left side when a unknown fail happen',
        () async {
      when(
        mockedCharacterDataSource.fetchCharacters(
          randomFilter,
        ),
      ).thenThrow(Exception('error'));

      final characterRepository =
          CharactersRepositoryImpl(mockedCharacterDataSource);

      final data = await characterRepository.fetchCharacters(randomFilter);

      data.fold(
        (l) => expect(l, isInstanceOf<UnexpectedFailure>()),
        (r) => fail('should not return right side'),
      );

      verify(mockedCharacterDataSource.fetchCharacters(
        randomFilter,
      )).called(1);

      verifyNoMoreInteractions(mockedCharacterDataSource);
    });
  });
}
