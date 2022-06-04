import 'package:equatable/equatable.dart';
import 'package:marvel/features/domain/entities/comic.dart';
import 'package:marvel/features/domain/entities/thumbnail.dart';

class Character extends Equatable {
  final int id;
  final String name;
  final String description;
  final Thumbnail thumbnail;
  final List<Comic> comics;

  const Character({
    required this.id,
    required this.name,
    required this.description,
    required this.thumbnail,
    required this.comics,
  });

  @override
  List<Object?> get props => [
        id,
        name,
        description,
        thumbnail,
        comics,
      ];

  @override
  String toString() => '''
  Character {
    id: $id,
    name: $name,
    description: $description,
    thumbnail: $thumbnail,
    comics: $comics,
  }
  ''';
}
