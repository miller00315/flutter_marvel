import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marvel/config/app_texts.dart';
import 'package:marvel/features/domain/entities/character.dart';
import 'package:marvel/features/presentation/bloc/characters_bloc/characters_bloc.dart';
import 'package:marvel/features/presentation/pages/details_page/details_page.dart';
import 'package:marvel/features/presentation/pages/home_page/widgets/home_page_body.dart';
import 'package:marvel/injection_container.dart';

class HomePage extends StatelessWidget {
  static const routeName = '/';

  const HomePage({Key? key}) : super(key: key);

  void goToDetailsPage(context, Character character) =>
      Navigator.of(context).pushNamed(
        DetailsPage.routeName,
        arguments: character,
      );

  @override
  Widget build(BuildContext context) {
    return BlocProvider<CharactersBloc>(
      create: (_) => serviceLocator<CharactersBloc>()
        ..add(
          const FetchCharactersEvent(),
        ),
      child: Scaffold(
        body: BlocListener<CharactersBloc, CharactersState>(
          listener: (BuildContext context, state) {
            if (state.fetchStatus is Error) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text(AppTexts.fetchError),
                ),
              );
            }
          },
          child: HomePageBody(
            handleCharacterGridCellTap: (character) =>
                goToDetailsPage(context, character),
          ),
        ),
      ),
    );
  }
}
