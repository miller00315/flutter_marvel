part of 'characters_bloc.dart';

abstract class CharactersEvent extends Equatable {
  const CharactersEvent();

  @override
  List<Object> get props => [];
}

class FetchCharactersEvent extends CharactersEvent {
  final Filter? filter;

  const FetchCharactersEvent([this.filter]);
}
