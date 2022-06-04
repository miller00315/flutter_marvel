import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:marvel/features/data/models/comic_model.dart';

void main() {
  final file =
      File('test/test_resources/jsons/random_comic.json').readAsStringSync();

  final json = jsonDecode(file);

  group('ComicModel group =>', () {
    test('should create a [ComicModel] from a json', () {
      final comic = ComicModel.fromJson(json);

      expect(comic.name, json['name']);
      expect(comic.resourceURI, json['resourceURI']);
    });
  });
}
