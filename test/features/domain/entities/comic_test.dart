import 'package:flutter_test/flutter_test.dart';
import 'package:marvel/features/domain/entities/comic.dart';

void main() {
  group('Comic group =>', () {
    test('should build a Comic', () {
      const comic = Comic(name: 'test', resourceURI: 'http://test');

      expect(comic.name, 'test');
      expect(comic.resourceURI, 'http://test');
    });
  });
}
