import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:marvel/core/filter/filter.dart';
import 'package:marvel/core/status/status.dart';
import 'package:marvel/features/domain/entities/character.dart';
import 'package:marvel/features/domain/usecases/fetch_characters_usecase.dart';

part 'characters_event.dart';
part 'characters_state.dart';

class CharactersBloc extends Bloc<CharactersEvent, CharactersState> {
  final FetchCharactersUsecase fetchCharactersUsecase;

  CharactersBloc(this.fetchCharactersUsecase)
      : super(CharactersState.initial()) {
    on<CharactersEvent>((event, emit) async {
      if (event
          is FetchCharactersEvent /*  && state.fetchStatus is! InProgress */) {
        emit(
          state.copyWith(
            fetchStatus: InProgress(),
          ),
        );

        final filter = event.filter ?? Filter.withDate(state.characters.length);

        final data = await fetchCharactersUsecase(filter);

        data.fold(
          (failure) => emit(state.copyWith(fetchStatus: Error())),
          (characters) => emit(
            state.copyWith(
              characters: [...state.characters, ...characters],
              fetchStatus: Done(),
            ),
          ),
        );
      }
    });
  }
}
