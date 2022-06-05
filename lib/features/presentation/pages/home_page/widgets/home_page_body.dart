import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:marvel/config/app_font_size.dart';
import 'package:marvel/config/app_padding.dart';
import 'package:marvel/config/app_images.dart';
import 'package:marvel/config/app_texts.dart';
import 'package:marvel/config/app_spacing.dart';
import 'package:marvel/core/status/status.dart';
import 'package:marvel/features/domain/entities/character.dart';
import 'package:marvel/features/presentation/bloc/characters_bloc/characters_bloc.dart';
import 'package:marvel/features/presentation/pages/home_page/widgets/character_list_tile.dart';
import 'package:marvel/features/presentation/widgets/bottom_loading_widget.dart';
import 'package:marvel/features/presentation/widgets/empty_list_widget.dart';
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
            return FailureWidget(handleTryAgainPressed: _requestCharacters);
          }

          if (state.fetchStatus is Done) {
            return EmptyListWidget(handleTryAgainPressed: _requestCharacters);
          }
        }

        return Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage(AppImages.lightBackgroundImage),
              fit: BoxFit.cover,
            ),
          ),
          child: SingleChildScrollView(
            controller: _controller,
            child: Column(
              children: [
                Container(
                  width: double.maxFinite,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(AppImages.darkBackgroundImage),
                      fit: BoxFit.cover,
                    ),
                  ),
                  height: MediaQuery.of(context).size.height / 2 - 100,
                  child: SafeArea(
                    child: Stack(
                      children: [
                        Positioned(
                          top: AppSpacing.medium,
                          left: AppSpacing.medium,
                          child: Image.asset(
                            AppImages.logo,
                            width: 100,
                          ),
                        ),
                        Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              SizedBox(
                                height: AppSpacing.ultraLarge,
                              ),
                              Text(
                                AppTexts.homePageTitle,
                                style: TextStyle(
                                  fontSize: AppFontSize.large,
                                ),
                              ),
                              SizedBox(
                                height: AppSpacing.large,
                              ),
                              Text(
                                AppTexts.homePageSubtitle,
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                AnimationLimiter(
                  child: GridView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    padding: AppPadding.large,
                    shrinkWrap: true,
                    addAutomaticKeepAlives: true,
                    itemCount: state.characters.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: AppSpacing.extraLarge,
                      mainAxisSpacing: AppSpacing.extraLarge,
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
                  const BottomLoadingWidget(),
              ],
            ),
          ),
        );
      },
    );
  }
}
