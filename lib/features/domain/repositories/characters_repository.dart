import 'package:dartz/dartz.dart';
import 'package:marvel/core/error/failures.dart';
import 'package:marvel/core/filter/filter.dart';
import 'package:marvel/features/domain/entities/character.dart';

abstract class CharactersRepository {
  Future<Either<Failure, List<Character>>> fetchCharacters(Filter filter);
}
