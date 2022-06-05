import 'package:flutter_test/flutter_test.dart';
import 'package:marvel/features/domain/entities/character.dart';
import 'package:marvel/features/domain/entities/comic.dart';
import 'package:marvel/features/domain/entities/thumbnail.dart';

void main() {
  group('Character group => ', () {
    test('should build a Character', () {
      const character = Character(
        id: 1,
        name: 'test',
        description: 'description',
        thumbnail: Thumbnail(
          path: 'http://test',
          extension: '.test',
        ),
        comics: [
          Comic(
            resourceURI: 'http://test',
            name: 'test',
          ),
        ],
      );

      expect(character.id, 1);
      expect(character.name, 'test');
      expect(character.description, 'description');
      expect(character.thumbnail.path, 'http://test');
      expect(character.thumbnail.extension, '.test');
      expect(character.comics.length, 1);
      expect(character.comics[0].resourceURI, 'http://test');
      expect(character.comics[0].name, 'test');
    });
  });
}
