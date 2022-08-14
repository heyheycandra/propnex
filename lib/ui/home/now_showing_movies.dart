import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:technical_take_home/bloc/film_bloc/film_bloc.dart';
import 'package:technical_take_home/helper/app_scale.dart';
import 'package:technical_take_home/helper/constant.dart';
import 'package:technical_take_home/helper/locator.dart';
import 'package:technical_take_home/helper/navigator_service.dart';
import 'package:technical_take_home/model/movie.dart';
import 'package:technical_take_home/shared_widgets/common_shimmer.dart';
import 'package:technical_take_home/shared_widgets/custom_snack_bar.dart';
import 'package:technical_take_home/shared_widgets/grid_elements.dart';
import 'package:technical_take_home/theme/colors.dart';

class NowShowingMovies extends StatefulWidget {
  const NowShowingMovies({Key? key}) : super(key: key);

  @override
  State<NowShowingMovies> createState() => _NowShowingMoviesState();
}

class _NowShowingMoviesState extends State<NowShowingMovies> {
  List<Movie> listfilms = [];
  bool loaded = false;
  @override
  Widget build(BuildContext context) {
    return BlocListener<FilmBloc, FilmState>(
      listener: (context, state) {
        if (state is LoadFilmNP) {
          listfilms = List.from(state.listFilms);
          loaded = true;
        }
        if (state is FilmError) {
          error(context, state.error);
          loaded = true;
        }
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          BlocBuilder<FilmBloc, FilmState>(
            builder: (context, state) {
              return Visibility(
                visible: (state is FilmLoading) || listfilms.isNotEmpty,
                child: CommonShimmer(
                  isLoading: state is FilmLoading,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: sampleAppWhite,
                    ),
                    padding: const EdgeInsets.only(top: 8, bottom: 8, right: 8),
                    margin: const EdgeInsets.only(bottom: 8),
                    child: Text(
                      "Films",
                      style: TextStyle(
                        fontSize: context.scaleFont(18),
                        color: sampleAppMenuBg,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
          BlocBuilder<FilmBloc, FilmState>(
            builder: (context, state) {
              if (state is FilmLoading) {
                return GridView.count(
                  crossAxisCount: 4,
                  childAspectRatio: 9 / 22,
                  mainAxisSpacing: 12,
                  crossAxisSpacing: 12,
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  children: List.generate(8, (index) {
                    return const LoadingGrid();
                  }),
                );
              } else {
                if (listfilms.isEmpty) {
                  return const SizedBox();
                } else {
                  return GridView.count(
                    crossAxisCount: 4,
                    childAspectRatio: 9 / 22,
                    mainAxisSpacing: 12,
                    crossAxisSpacing: 12,
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    children: List.generate(((listfilms.length > 7) ? 8 : listfilms.length), (index) {
                      return SizedBox(
                        width: double.maxFinite,
                        height: double.maxFinite,
                        child: Builder(builder: (context) {
                          if (index == 7 || index == listfilms.length) {
                            return SeeMoreGrid(
                              onTap: () {
                                locator<NavigatorService>().navigateTo(Constant.menuFilm);
                              },
                            );
                          } else {
                            final path = listfilms[index].posterPath;
                            final title = listfilms[index].title;
                            final model = listfilms[index];
                            return ImageGrid(
                              path: path,
                              title: title,
                              model: model,
                            );
                          }
                        }),
                      );
                    }),
                  );
                }
              }
            },
          ),
        ],
      ),
    );
  }
}

  // return Row(
                //   children: [
                //     //! Item
                //     AspectRatio(
                //       aspectRatio: 9 / 16,
                //       child: ClipRRect(
                //         borderRadius: BorderRadius.circular(12),
                //         child: const ColoredBox(
                //           color: Colors.red,
                //         ),
                //       ),
                //     )
                //   ],
                // );