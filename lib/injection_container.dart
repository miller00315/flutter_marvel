import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:marvel/features/data/data_sources/characters_data_source.dart';
import 'package:marvel/features/data/repositories/characters_repository_impl.dart';
import 'package:marvel/features/domain/repositories/characters_repository.dart';
import 'package:marvel/features/domain/usecases/fetch_characters_usecase.dart';
import 'package:marvel/features/presentation/bloc/characters_bloc/characters_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

final serviceLocator = GetIt.instance;

Future<void> init() async {
  serviceLocator.registerLazySingleton(
    () => dotenv,
  );

  serviceLocator.registerLazySingleton(
    () => Dio(),
  );

  serviceLocator.registerFactory(
    () => CharactersBloc(
      serviceLocator(),
    ),
  );

  serviceLocator.registerLazySingleton<FetchCharactersUsecase>(
    () => FetchCharactersUsecaseImpl(
      serviceLocator(),
    ),
  );

  serviceLocator.registerLazySingleton<CharactersRepository>(
    () => CharactersRepositoryImpl(
      serviceLocator(),
    ),
  );

  serviceLocator.registerLazySingleton<CharactersDataSource>(
    () => CharactersDataSourceImpl(
      serviceLocator(),
    ),
  );
}
