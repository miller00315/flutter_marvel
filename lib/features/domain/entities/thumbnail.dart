import 'package:equatable/equatable.dart';

class Thumbnail extends Equatable {
  final String path;
  final String extension;

  const Thumbnail({
    required this.path,
    required this.extension,
  });

  @override
  List<Object?> get props => [
        path,
        extension,
      ];

  @override
  String toString() => '''
  Thumbnail {
    path: $path,
    extension: $extension,
  }
  ''';
}
