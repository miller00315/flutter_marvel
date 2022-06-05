import 'package:flutter_test/flutter_test.dart';
import 'package:marvel/features/domain/entities/thumbnail.dart';

void main() {
  group('Thumbnail group => ', () {
    test('should build a Comic', () {
      const comic = Thumbnail(extension: '.test', path: 'http://test.com');

      expect(comic.extension, '.test');
      expect(comic.path, 'http://test.com');
    });
  });
}
