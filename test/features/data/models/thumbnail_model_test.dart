import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:marvel/features/data/models/thumbnail_model.dart';

void main() {
  final file = File('test/test_resources/jsons/random_thumbnail.json')
      .readAsStringSync();

  final json = jsonDecode(file);

  group('ThumbnailModel group =>', () {
    test('should create a [ThumbnailModel] from a json', () {
      final thumbnail = ThumbnailModel.fromJson(json);

      expect(thumbnail.path, json['path']);
      expect(thumbnail.extension, json['extension']);
    });
  });
}
