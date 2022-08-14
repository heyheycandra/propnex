import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:technical_take_home/bloc/tv_bloc/serial_bloc.dart';
import 'package:technical_take_home/helper/app_scale.dart';
import 'package:technical_take_home/model/movie.dart';
import 'package:technical_take_home/shared_widgets/grid_elements.dart';
import 'package:technical_take_home/shared_widgets/nav_header.dart';
import 'package:technical_take_home/theme/colors.dart';
import 'package:technical_take_home/theme/padding.dart';

class OnAirScreen extends StatefulWidget {
  const OnAirScreen({Key? key}) : super(key: key);

  @override
  State<OnAirScreen> createState() => _OnAirScreenState();
}

class _OnAirScreenState extends State<OnAirScreen> {
  String searchVal = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight + 10),
        child: simpleHeader("On Air"),
      ),
      body: MultiBlocProvider(
        providers: [
          BlocProvider<SerialBloc>(
            create: (context) => SerialBloc(),
          ),
        ],
        child: const OnAirBody(),
      ),
    );
  }
}

class OnAirBody extends StatefulWidget {
  const OnAirBody({Key? key}) : super(key: key);

  @override
  State<OnAirBody> createState() => _OnAirBodyState();
}

class _OnAirBodyState extends State<OnAirBody> {
  int pageNumber = 1;
  bool shouldLoadMore = true;
  bool initial = true;
  List<Movie> listfilms = [];
  final gridController = ScrollController();
  late SerialBloc bloc;

  @override
  Widget build(BuildContext context) {
    bloc = context.read<SerialBloc>();
    if (initial && shouldLoadMore) {
      initial = false;
      bloc.add(GetSerialNP(page: pageNumber));
    }
    gridController.addListener(() {
      if (gridController.position.pixels == gridController.position.maxScrollExtent) {
        if (shouldLoadMore) {
          pageNumber++;
          bloc.add(GetSerialNP(page: pageNumber));
        }
      }
    });
    return BlocListener<SerialBloc, SerialState>(
      listener: (context, state) {
        if (state is LoadSerialNP) {
          if (state.listSerials.isNotEmpty) {
            listfilms.addAll(state.listSerials);
          } else {
            shouldLoadMore = false;
          }
        }
      },
      child: BlocBuilder<SerialBloc, SerialState>(
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
        },
      ),
    );
  }
}
