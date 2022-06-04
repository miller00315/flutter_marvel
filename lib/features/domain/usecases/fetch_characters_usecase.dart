import 'package:dartz/dartz.dart';
import 'package:marvel/core/error/failures.dart';
import 'package:marvel/core/filter/filter.dart';
import 'package:marvel/features/domain/entities/character.dart';
import 'package:marvel/features/domain/repositories/characters_repository.dart';

abstract class FetchCharactersUsecase {
  Future<Either<Failure, List<Character>>> call(Filter filter);
}

class FetchCharactersUsecaseImpl implements FetchCharactersUsecase {
  final CharactersRepository repository;

  FetchCharactersUsecaseImpl(this.repository);

  @override
  Future<Either<Failure, List<Character>>> call(Filter filter) async {
    return await repository.fetchCharacters(filter);
  }
}
