import 'package:marvel/features/domain/entities/thumbnail.dart';

class ThumbnailModel extends Thumbnail {
  const ThumbnailModel({
    required super.extension,
    required super.path,
  });

  factory ThumbnailModel.fromJson(Map<String, dynamic> json) {
    return ThumbnailModel(
      extension: json['extension'],
      path: json['path'],
    );
  }
}
