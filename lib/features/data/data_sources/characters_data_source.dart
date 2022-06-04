import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:marvel/core/util/hash_helper.dart';
import 'package:marvel/core/util/uri_helper.dart';
import 'package:marvel/features/data/models/character_model.dart';
import 'package:marvel/core/filter/filter.dart';

abstract class CharactersDataSource {
  Future<List<CharacterModel>> fetchCharacters(Filter filter);
}

class CharactersDataSourceImpl implements CharactersDataSource {
  final Dio _dio;

  CharactersDataSourceImpl(
    this._dio,
  );

  @override
  Future<List<CharacterModel>> fetchCharacters(Filter filter) async {
    final apiKey = dotenv.get('API_PUBLIC_KEY');

    final hash = generateHash([
      filter.timestamp,
      dotenv.get('API_PRIVATE_KEY'),
      apiKey,
    ]);

    final uri = generateHttpsUri(
      dotenv.get('AUTHORITY'),
      dotenv.get('CHARACTERS_PATH'),
      {
        ...filter.toJson(),
        'hash': hash,
        'apikey': apiKey,
      },
    );

    final response = await _dio.getUri(uri);

    final data = (response.data['data']['results'] as List);

    return data.map((json) => CharacterModel.fromJson(json)).toList();
  }
}
