import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';
import 'package:marvel/core/util/hash_helper.dart';
import 'package:marvel/core/util/uri_helper.dart';
import 'package:marvel/features/data/data_sources/characters_data_source.dart';
import 'package:marvel/features/data/models/character_model.dart';

import '../../../test_resources/entities/random_entities.dart';

main() {
  final dio = Dio();

  final dioAdapter = DioAdapter(dio: dio);

  String? testUri;

  dotenv.testLoad(fileInput: '''
    API_PUBLIC_KEY=1234
    API_PRIVATE_KEY=4567
    AUTHORITY=test.com
    CHARACTERS_PATH=/v1/public/characters
  ''');

  final file = File('test/test_resources/jsons/random_character_list.json')
      .readAsStringSync();

  final json = jsonDecode(file);

  group('CharacterDataSource group =>', () {
    setUpAll(() {
      final hash = generateHash([
        randomFilter.timestamp,
        dotenv.get('API_PRIVATE_KEY'),
        dotenv.get('API_PUBLIC_KEY'),
      ]);

      final queryParams = {
        ...randomFilter.toJson(),
        'hash': hash,
        'apikey': dotenv.get('API_PUBLIC_KEY'),
      };

      testUri = generateHttpsUri(
        dotenv.get('AUTHORITY'),
        dotenv.get('CHARACTERS_PATH'),
        queryParams,
      ).toString();
    });

    test('should return list when request is success', () async {
      dioAdapter.onGet(
        testUri!,
        (server) => server.reply(
          200,
          {
            'data': {
              'results': json,
            }
          },
        ),
      );

      final characterDataSource = CharactersDataSourceImpl(dio);

      final res = await characterDataSource.fetchCharacters(randomFilter);

      expect(
        res,
        (json as List).map((e) => CharacterModel.fromJson(e)).toList(),
      );
    });

    test('should thrown a error when request failed', () async {
      dioAdapter.onGet(
        testUri!,
        (server) => server.reply(
          409,
          {
            'code': 'error',
            'message': 'test error',
          },
        ),
      );

      final characterDataSource = CharactersDataSourceImpl(dio);

      try {
        await characterDataSource.fetchCharacters(randomFilter);

        fail('method don\'t throw');
      } catch (e) {
        expect(e, isInstanceOf<DioError>());
      }
    });
  });
}
