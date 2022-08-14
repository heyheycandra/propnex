import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:technical_take_home/bloc/film_bloc/film_bloc.dart';
import 'package:technical_take_home/helper/app_scale.dart';
import 'package:technical_take_home/model/movie.dart';
import 'package:technical_take_home/shared_widgets/grid_elements.dart';
import 'package:technical_take_home/shared_widgets/nav_header.dart';
import 'package:technical_take_home/theme/colors.dart';
import 'package:technical_take_home/theme/padding.dart';

class NowShowingScreen extends StatefulWidget {
  const NowShowingScreen({Key? key}) : super(key: key);

  @override
  State<NowShowingScreen> createState() => _NowShowingScreenState();
}

class _NowShowingScreenState extends State<NowShowingScreen> {
  String searchVal = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight + 10),
        child: simpleHeader("Now Showing"),
      ),
      body: MultiBlocProvider(
        providers: [
          BlocProvider<FilmBloc>(
            create: (context) => FilmBloc(),
          ),
        ],
        child: const NowShowingBody(),
      ),
    );
  }
}

class NowShowingBody extends StatefulWidget {
  const NowShowingBody({Key? key}) : super(key: key);

  @override
  State<NowShowingBody> createState() => _NowShowingBodyState();
}

class _NowShowingBodyState extends State<NowShowingBody> {
  int pageNumber = 1;
  bool shouldLoadMore = true;
  bool initial = true;
  List<Movie> listfilms = [];
  final gridController = ScrollController();
  late FilmBloc bloc;

  @override
  Widget build(BuildContext context) {
    bloc = context.read<FilmBloc>();
    if (initial && shouldLoadMore) {
      initial = false;
      bloc.add(GetFilmNP(page: pageNumber));
    }
    gridController.addListener(() {
      if (gridController.position.pixels == gridController.position.maxScrollExtent) {
        if (shouldLoadMore) {
          pageNumber++;
          bloc.add(GetFilmNP(page: pageNumber));
        }
      }
    });
    return BlocListener<FilmBloc, FilmState>(
      listener: (context, state) {
        if (state is LoadFilmNP) {
          if (state.listFilms.isNotEmpty) {
            listfilms.addAll(state.listFilms);
          } else {
            shouldLoadMore = false;
          }
        }
      },
      child: BlocBuilder<FilmBloc, FilmState>(
        builder: (context, state) {
          return GridView.count(
            crossAxisCount: 2,
            childAspectRatio: 9 / 19,
            mainAxisSpacing: 12,
            crossAxisSpacing: 12,
            controller: gridController,
            padding: sampleAppOutterPadding,
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            children: List.generate((listfilms.length + 2), (index) {
              if (index >= listfilms.length) {
                if (state is FilmLoading) {
                  return const SizedBox(
                    width: double.maxFinite,
                    height: double.maxFinite,
                    child: LoadingGrid(),
                  );
                } else {
                  return const SizedBox();
                }
              } else {
                final path = listfilms[index].posterPath;
                final title = listfilms[index].title;
                final model = listfilms[index];
                return SizedBox(
                  width: double.maxFinite,
                  height: double.maxFinite,
                  child: ImageGrid(
                    model: model,
                    path: path,
                    title: title,
                    titleStyle: TextStyle(
                      fontSize: context.scaleFont(16),
                      color: sampleAppBlack,
                      fontWeight: FontWeight.bold,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                );
              }
            }),
          );
        },
      ),
    );
  }
}
