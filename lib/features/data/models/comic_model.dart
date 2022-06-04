import 'package:marvel/features/domain/entities/comic.dart';

class ComicModel extends Comic {
  const ComicModel({
    required super.resourceURI,
    required super.name,
  });

  factory ComicModel.fromJson(Map<String, dynamic> json) => ComicModel(
        resourceURI: json['resourceURI'],
        name: json['name'],
      );
}
