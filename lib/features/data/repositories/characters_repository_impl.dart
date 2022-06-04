import 'package:dio/dio.dart';
import 'package:marvel/core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:marvel/features/data/data_sources/characters_data_source.dart';
import 'package:marvel/core/filter/filter.dart';
import 'package:marvel/features/domain/entities/character.dart';
import 'package:marvel/features/domain/repositories/characters_repository.dart';

class CharactersRepositoryImpl implements CharactersRepository {
  final CharactersDataSource charactersDataSource;

  CharactersRepositoryImpl(this.charactersDataSource);

  @override
  Future<Either<Failure, List<Character>>> fetchCharacters(
      Filter filter) async {
    try {
      final characters = await charactersDataSource.fetchCharacters(filter);

      return right(characters);
    } on DioError catch (_) {
      return left(ServerFailure());
    } catch (_) {
      return left(UnexpectedFailure());
    }
  }
}
