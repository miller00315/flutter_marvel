part of 'characters_bloc.dart';

class CharactersState extends Equatable {
  final List<Character> characters;
  final Status fetchStatus;

  const CharactersState({
    required this.characters,
    required this.fetchStatus,
  });

  factory CharactersState.initial() => CharactersState(
        characters: const [],
        fetchStatus: Idle(),
      );

  @override
  List<Object> get props => [
        characters,
        fetchStatus,
      ];

  CharactersState copyWith({
    List<Character>? characters,
    Status? fetchStatus,
  }) {

    return CharactersState(
      characters: characters ?? this.characters,
      fetchStatus: fetchStatus ?? this.fetchStatus,
    );
  }

  @override
  String toString() => '''
  CharactersState {
    fetchStatus: $fetchStatus,
    characters: $characters,
  }
  ''';
}
