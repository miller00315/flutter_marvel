import 'package:equatable/equatable.dart';

class Comic extends Equatable {
  final String resourceURI;
  final String name;

  const Comic({
    required this.resourceURI,
    required this.name,
  });

  @override
  List<Object?> get props => [
        name,
        resourceURI,
      ];

  @override
  String toString() => '''
  Comic {
    resourceURI: $resourceURI,
    name: $name,
  }
  ''';
}
