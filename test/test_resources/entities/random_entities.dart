import 'package:faker/faker.dart';
import 'package:marvel/core/filter/filter.dart';
import 'package:marvel/features/data/models/character_model.dart';
import 'package:marvel/features/domain/entities/character.dart';
import 'package:marvel/features/domain/entities/comic.dart';
import 'package:marvel/features/domain/entities/thumbnail.dart';

final faker = Faker();

final randomFilter = Filter(offset: 0, date: DateTime.now());

final List<Character> randomCharacters = [
  Character(
    id: 1,
    name: faker.person.name(),
    description: faker.lorem.sentence(),
    thumbnail: Thumbnail(
      path: faker.internet.httpUrl(),
      extension: '.jpg',
    ),
    comics: [
      Comic(
        resourceURI: faker.internet.httpUrl(),
        name: faker.person.name(),
      )
    ],
  ),
  Character(
    id: 2,
    name: faker.person.name(),
    description: faker.lorem.sentence(),
    thumbnail: Thumbnail(
      path: faker.internet.httpUrl(),
      extension: '.jpg',
    ),
    comics: [
      Comic(
        resourceURI: faker.internet.httpUrl(),
        name: faker.person.name(),
      )
    ],
  ),
];

const env = '''
    API_PUBLIC_KEY=1234
    API_PRIVATE_KEY=4567
    AUTHORITY=test.com
    CHARACTERS_PATH=/v1/public/characters
  ''';

final List<CharacterModel> randomCharacterModels = [];
