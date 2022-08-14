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
import 'package:technical_take_home/shared_widgets/row_elements.dart';
import 'package:technical_take_home/theme/colors.dart';

class PopularRow extends StatelessWidget {
  const PopularRow({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => FilmBloc()..add(GetFilmPop()),
      child: const PopularRowBody(),
    );
  }
}

class PopularRowBody extends StatefulWidget {
  const PopularRowBody({Key? key}) : super(key: key);

  @override
  State<PopularRowBody> createState() => _PopularRowBodyState();
}

class _PopularRowBodyState extends State<PopularRowBody> {
  List<Movie> listfilms = [];
  @override
  Widget build(BuildContext context) {
    return BlocListener<FilmBloc, FilmState>(
      listener: (context, state) {
        if (state is LoadFilmPop) {
          listfilms = List.from(state.listFilms);
        }
        if (state is FilmError) {
          error(context, state.error);
        }
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
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
                      "Popular",
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
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: BlocBuilder<FilmBloc, FilmState>(
              builder: (context, state) {
                if (state is FilmLoading) {
                  return Row(
                    children: List.generate(5, (index) {
                      return Padding(
                          padding: (index == 0) ? const EdgeInsets.only(right: 8) : const EdgeInsets.symmetric(horizontal: 8),
                          child: const LoadingRow());
                    }),
                  );
                }
                return Row(
                  children: (listfilms.isNotEmpty)
                      ? List.generate(
                          ((listfilms.length > 5) ? 5 : listfilms.length + 1),
                          (index) {
                            if (index == listfilms.length - 1 || index == 4) {
                              return SeeMoreRow(
                                onTap: () {
                                  locator<NavigatorService>().navigateTo(Constant.menuFilmPop);
                                },
                              );
                            } else {
                              final path = listfilms[index].posterPath;
                              final title = listfilms[index].title;
                              final model = listfilms[index];
                              return Padding(
                                padding: (index == 0) ? const EdgeInsets.only(right: 8) : const EdgeInsets.symmetric(horizontal: 8),
                                child: ImageRow(
                                  path: path,
                                  title: title,
                                  model: model,
                                ),
                              );
                            }
                          },
                        )
                      : [],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
