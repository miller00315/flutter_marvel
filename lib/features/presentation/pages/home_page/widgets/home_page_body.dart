import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:marvel/core/status/status.dart';
import 'package:marvel/features/domain/entities/character.dart';
import 'package:marvel/features/presentation/bloc/characters_bloc/characters_bloc.dart';
import 'package:marvel/features/presentation/pages/home_page/widgets/character_list_tile.dart';
import 'package:marvel/features/presentation/widgets/failure_widget.dart';
import 'package:marvel/features/presentation/widgets/loading_widget.dart';

class HomePageBody extends StatefulWidget {
  final void Function(Character) handleCharacterListTileTap;

  const HomePageBody({
    Key? key,
    required this.handleCharacterListTileTap,
  }) : super(key: key);

  @override
  State<HomePageBody> createState() => _HomePageBodyState();
}

class _HomePageBodyState extends State<HomePageBody> {
  late ScrollController _controller;

  @override
  void initState() {
    _controller = ScrollController();
    _controller.addListener(_screenBottomListener);
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _requestCharacters() {
    if (BlocProvider.of<CharactersBloc>(context).state.fetchStatus
        is! InProgress) {
      BlocProvider.of<CharactersBloc>(context).add(
        const FetchCharactersEvent(),
      );
    }
  }

  void _screenBottomListener() {
    double maxScroll = _controller.position.maxScrollExtent;
    double currentScroll = _controller.position.pixels;
    double delta = 100.0;
    if (maxScroll - currentScroll <= delta) {
      _requestCharacters();
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CharactersBloc, CharactersState>(
      buildWhen: (previous, current) =>
          previous.fetchStatus != current.fetchStatus,
      builder: (context, state) {
        if (state.characters.isEmpty) {
          if (state.fetchStatus is InProgress) {
            return const LoadingWidget();
          }

          if (state.fetchStatus is Error) {
            return Center(
              child: FailureWidget(handleTryAgainPressed: _requestCharacters),
            );
          }

          return Container();
        }

        return Stack(
          children: [
            Positioned.fill(
              child: Image.asset(
                'assets/images/background2.png',
                fit: BoxFit.fill,
              ),
            ),
            SingleChildScrollView(
              controller: _controller,
              child: Column(
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 2 - 100,
                    child: Stack(
                      children: [
                        Positioned.fill(
                          child: Image.asset(
                            'assets/images/background1.png',
                            fit: BoxFit.fill,
                          ),
                        ),
                        Positioned(
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 50,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Image.asset(
                                  'assets/images/logo.png',
                                  width: 100,
                                ),
                              ],
                            ),
                          ),
                        ),
                        Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              SizedBox(
                                height: 50,
                              ),
                              Text(
                                'MARVEL CHARACTERS',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 30,
                                  letterSpacing: 0.5,
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Text(
                                'Get hooked on a hearty helping of heroes and villains\nfrom the humble House of Ideas!',
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  AnimationLimiter(
                    child: GridView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      padding: const EdgeInsets.all(16),
                      shrinkWrap: true,
                      addAutomaticKeepAlives: true,
                      itemCount: state.characters.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 30,
                        mainAxisSpacing: 30,
                        childAspectRatio: 3 / 4,
                      ),
                      itemBuilder: (context, index) {
                        final character = state.characters[index];

                        return AnimationConfiguration.staggeredGrid(
                          position: index,
                          duration: const Duration(milliseconds: 375),
                          columnCount: 2,
                          child: ScaleAnimation(
                            child: CharacterListTile(
                              character: character,
                              onTap: () =>
                                  widget.handleCharacterListTileTap(character),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  if (state.fetchStatus is InProgress)
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: CircularProgressIndicator(),
                    ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
