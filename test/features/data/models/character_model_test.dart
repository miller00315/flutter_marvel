import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:marvel/features/data/models/character_model.dart';

void main() {
  final file =
      File('test/test_resources/jsons/random_character.json').readAsStringSync();

  final json = jsonDecode(file);

  group('ComicModel group =>', () {
    test('should create a [ComicModel] from a json', () {
      final character = CharacterModel.fromJson(json);

      expect(character.id, json['id'] as int);
      expect(character.name, json['name']);
      expect(character.description, json['description']);
      expect(character.thumbnail.path, json['thumbnail']['path']);
      expect(character.thumbnail.extension, json['thumbnail']['extension']);

      character.comics.asMap().forEach((index, comic) {
        expect(comic.name, json['comics']['items'][index]['name']);

        expect(
            comic.resourceURI, json['comics']['items'][index]['resourceURI']);
      });
    });
  });
}
