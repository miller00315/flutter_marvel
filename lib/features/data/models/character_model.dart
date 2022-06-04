import 'package:equatable/equatable.dart';
import 'package:marvel/features/data/models/comic_model.dart';
import 'package:marvel/features/data/models/thumbnail_model.dart';
import 'package:marvel/features/domain/entities/character.dart';

class CharacterModel extends Character {
  const CharacterModel({
    required super.id,
    required super.comics,
    required super.name,
    required super.description,
    required super.thumbnail,
  });

  factory CharacterModel.fromJson(Map<String, dynamic> json) {
   /*  print(json['comics']['items']);
 */
    final comics = (json['comics']['items'] as List);

    return CharacterModel(
      id: json['id'] as int,
      name: json['name'],
      description: json['description'],
      thumbnail: ThumbnailModel.fromJson(
        json['thumbnail'],
      ),
      comics: comics.map((comic) => ComicModel.fromJson(comic)).toList(),
    );
  }
}
