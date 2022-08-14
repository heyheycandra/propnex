import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:technical_take_home/bloc/film_bloc/film_bloc.dart';
import 'package:technical_take_home/helper/app_scale.dart';
import 'package:technical_take_home/helper/constant.dart';
import 'package:technical_take_home/model/movie.dart';
import 'package:technical_take_home/shared_widgets/grid_elements.dart';
import 'package:technical_take_home/shared_widgets/nav_drawer.dart';
import 'package:technical_take_home/shared_widgets/nav_header.dart';
import 'package:technical_take_home/theme/colors.dart';
import 'package:technical_take_home/theme/padding.dart';
import 'package:technical_take_home/ui/flms/now_showing/now_showing_row.dart';
import 'package:technical_take_home/ui/flms/popular/popular_row.dart';

class FilmScreen extends StatefulWidget {
  const FilmScreen({Key? key}) : super(key: key);

  @override
  State<FilmScreen> createState() => _FilmScreenState();
}

class _FilmScreenState extends State<FilmScreen> {
  String searchVal = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight + 10),
        child: SearchfieldAppbar(
          title: "Movies",
          onSearch: (val) {
            setState(() {
              searchVal = val ?? "";
            });
          },
        ),
      ),
      drawer: const NavDrawer(
        selectedMenu: Constant.menuFilm,
      ),
      body: MultiBlocProvider(
        providers: [
          BlocProvider<FilmBloc>(
            create: (context) => FilmBloc(),
          ),
        ],
        child: FilmBody(
          searchVal: searchVal,
        ),
      ),
    );
  }
}

class FilmBody extends StatefulWidget {
  final String searchVal;
  const FilmBody({required this.searchVal, Key? key}) : super(key: key);

  @override
  State<FilmBody> createState() => _FilmBodyState();
}

class _FilmBodyState extends State<FilmBody> {
  String searchVal = '';
  bool shouldLoadMore = true;
  bool initial = true;
  int pageNumber = 1;
  List<Movie> listfilms = [];
  final gridController = ScrollController();
  late FilmBloc bloc;
  @override
  void initState() {
    searchVal = widget.searchVal;
    shouldLoadMore = searchVal.isNotEmpty;

    super.initState();
  }

  @override
  void didUpdateWidget(covariant FilmBody oldWidget) {
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      setState(() {
        searchVal = widget.searchVal;
        shouldLoadMore = searchVal.isNotEmpty;
        initial = true;
        pageNumber = 1;
        listfilms.clear();
      });
    });
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    bloc = context.read<FilmBloc>();
    if (initial && shouldLoadMore) {
      initial = false;
      bloc.add(SearchFilms(query: searchVal, page: pageNumber));
    }
    gridController.addListener(() {
      if (gridController.position.pixels == gridController.position.maxScrollExtent) {
        if (shouldLoadMore) {
          pageNumber++;
          bloc.add(SearchFilms(query: searchVal, page: pageNumber));
        }
      }
    });
    return BlocListener<FilmBloc, FilmState>(
      listener: (context, state) {
        if (state is LoadFilmSearch) {
          if (state.listFilms.isNotEmpty) {
            listfilms.addAll(state.listFilms);
          } else {
            shouldLoadMore = false;
          }
        }
      },
      child: BlocBuilder<FilmBloc, FilmState>(builder: (context, state) {
        if (searchVal.isNotEmpty) {
          return GridView.count(
            crossAxisCount: 2,
            childAspectRatio: 9 / 19,
            mainAxisSpacing: 12,
            crossAxisSpacing: 12,
            controller: gridController,
            padding: sampleAppOutterPadding,
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            children: List.generate((listfilms.length + 1), (index) {
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
        } else {
          return SingleChildScrollView(
            padding: sampleAppOutterPadding,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: const [
                NowShowingRow(),
                SizedBox(
                  height: 16,
                ),
                PopularRow(),
              ],
            ),
          );
        }
      }),
    );
  }
}
