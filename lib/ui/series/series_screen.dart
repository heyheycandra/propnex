import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:technical_take_home/bloc/tv_bloc/serial_bloc.dart';
import 'package:technical_take_home/helper/app_scale.dart';
import 'package:technical_take_home/helper/constant.dart';
import 'package:technical_take_home/model/movie.dart';
import 'package:technical_take_home/shared_widgets/grid_elements.dart';
import 'package:technical_take_home/shared_widgets/nav_drawer.dart';
import 'package:technical_take_home/shared_widgets/nav_header.dart';
import 'package:technical_take_home/theme/colors.dart';
import 'package:technical_take_home/theme/padding.dart';
import 'package:technical_take_home/ui/series/on_air/on_air_row.dart';
import 'package:technical_take_home/ui/series/popular/popular_row.dart';

class SerialScreen extends StatefulWidget {
  const SerialScreen({Key? key}) : super(key: key);

  @override
  State<SerialScreen> createState() => _SerialScreenState();
}

class _SerialScreenState extends State<SerialScreen> {
  String searchVal = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight + 10),
        child: SearchfieldAppbar(
          title: "TV Series",
          onSearch: (val) {
            setState(() {
              searchVal = val ?? "";
            });
          },
        ),
      ),
      drawer: const NavDrawer(
        selectedMenu: Constant.menuSeries,
      ),
      body: MultiBlocProvider(
        providers: [
          BlocProvider<SerialBloc>(
            create: (context) => SerialBloc(),
          ),
        ],
        child: SerialBody(
          searchVal: searchVal,
        ),
      ),
    );
  }
}

class SerialBody extends StatefulWidget {
  final String searchVal;
  const SerialBody({required this.searchVal, Key? key}) : super(key: key);

  @override
  State<SerialBody> createState() => _SerialBodyState();
}

class _SerialBodyState extends State<SerialBody> {
  String searchVal = '';
  bool shouldLoadMore = true;
  bool initial = true;
  int pageNumber = 1;
  List<Movie> listfilms = [];
  final gridController = ScrollController();
  late SerialBloc bloc;
  @override
  void initState() {
    searchVal = widget.searchVal;
    shouldLoadMore = searchVal.isNotEmpty;

    super.initState();
  }

  @override
  void didUpdateWidget(covariant SerialBody oldWidget) {
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
    bloc = context.read<SerialBloc>();
    if (initial && shouldLoadMore) {
      initial = false;
      bloc.add(SearchSerial(query: searchVal, page: pageNumber));
    }
    gridController.addListener(() {
      if (gridController.position.pixels == gridController.position.maxScrollExtent) {
        if (shouldLoadMore) {
          pageNumber++;
          bloc.add(SearchSerial(query: searchVal, page: pageNumber));
        }
      }
    });
    return BlocListener<SerialBloc, SerialState>(
      listener: (context, state) {
        if (state is LoadSerialSearch) {
          if (state.listFilms.isNotEmpty) {
            listfilms.addAll(state.listFilms);
          } else {
            shouldLoadMore = false;
          }
        }
      },
      child: BlocBuilder<SerialBloc, SerialState>(builder: (context, state) {
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
                if (state is SerialLoading) {
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
                final title = listfilms[index].name;
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
                OnAirRow(),
                SizedBox(
                  height: 16,
                ),
                PopularSeriesRow(),
              ],
            ),
          );
        }
      }),
    );
  }
}
