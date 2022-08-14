import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:technical_take_home/bloc/film_bloc/film_bloc.dart';
import 'package:technical_take_home/helper/app_scale.dart';
import 'package:technical_take_home/model/movie.dart';
import 'package:technical_take_home/shared_widgets/grid_elements.dart';
import 'package:technical_take_home/shared_widgets/nav_header.dart';
import 'package:technical_take_home/theme/colors.dart';
import 'package:technical_take_home/theme/padding.dart';

class PopularScreen extends StatefulWidget {
  const PopularScreen({Key? key}) : super(key: key);

  @override
  State<PopularScreen> createState() => _PopularScreenState();
}

class _PopularScreenState extends State<PopularScreen> {
  String searchVal = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight + 10),
        child: simpleHeader("Popular"),
      ),
      body: MultiBlocProvider(
        providers: [
          BlocProvider<FilmBloc>(
            create: (context) => FilmBloc(),
          ),
        ],
        child: const PopularBody(),
      ),
    );
  }
}

class PopularBody extends StatefulWidget {
  const PopularBody({Key? key}) : super(key: key);

  @override
  State<PopularBody> createState() => _PopularBodyState();
}

class _PopularBodyState extends State<PopularBody> {
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
      bloc.add(GetFilmPop(page: pageNumber));
    }
    gridController.addListener(() {
      if (gridController.position.pixels == gridController.position.maxScrollExtent) {
        if (shouldLoadMore) {
          pageNumber++;
          bloc.add(GetFilmPop(page: pageNumber));
        }
      }
    });
    return BlocListener<FilmBloc, FilmState>(
      listener: (context, state) {
        if (state is LoadFilmPop) {
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
