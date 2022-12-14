import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:technical_take_home/bloc/film_bloc/film_bloc.dart';
import 'package:technical_take_home/helper/app_scale.dart';
import 'package:technical_take_home/helper/constant.dart';
import 'package:technical_take_home/helper/utils.dart';
import 'package:technical_take_home/model/movie.dart';
import 'package:technical_take_home/shared_widgets/common_shimmer.dart';
import 'package:technical_take_home/shared_widgets/grid_elements.dart';
import 'package:technical_take_home/shared_widgets/info_label.dart';
import 'package:technical_take_home/shared_widgets/nav_header.dart';
import 'package:technical_take_home/theme/colors.dart';
import 'package:technical_take_home/theme/padding.dart';

class FilmDetail extends StatefulWidget {
  final Movie model;
  const FilmDetail({required this.model, Key? key}) : super(key: key);

  @override
  State<FilmDetail> createState() => _FilmDetailState();
}

class _FilmDetailState extends State<FilmDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight + 10),
        child: TransparentAppbar(),
      ),
      extendBodyBehindAppBar: true,
      body: Hero(
        tag: widget.model.id ?? 0,
        child: MultiBlocProvider(
          providers: [
            BlocProvider<FilmBloc>(
              create: (context) => FilmBloc(),
            ),
          ],
          child: FilmDetailBody(
            model: widget.model,
          ),
        ),
      ),
    );
  }
}

class FilmDetailBody extends StatefulWidget {
  final Movie model;
  const FilmDetailBody({required this.model, Key? key}) : super(key: key);

  @override
  State<FilmDetailBody> createState() => _FilmDetailBodyState();
}

class _FilmDetailBodyState extends State<FilmDetailBody> {
  late Movie model;
  bool getModel = true;
  late FilmBloc bloc;
  bool shouldLoadMore = true;
  bool initial = true;
  int pageNumber = 1;
  List<Movie> listfilms = [];
  @override
  void initState() {
    model = widget.model;
    super.initState();
  }

  @override
  void didUpdateWidget(FilmDetailBody oldWidget) {
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      setState(() {
        model = widget.model;
        getModel = true;
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
    if (getModel && model.id != null) {
      getModel = false;
      bloc.add(GetFilmDetail(model.id.toString()));
    }
    if (initial && shouldLoadMore) {
      initial = false;
      bloc.add(GetFilmRecom(model.id ?? 0, page: pageNumber));
    }

    return BlocListener<FilmBloc, FilmState>(
      listener: (context, state) {
        if (state is LoadFilmDetail) {
          model = state.film;
        }
        if (state is LoadFilmRecom) {
          if (state.listFilms.isNotEmpty) {
            listfilms.addAll(state.listFilms);
          } else {
            shouldLoadMore = false;
          }
        }
      },
      child: SizedBox(
        height: context.deviceHeight,
        width: context.deviceWidth,
        child: Stack(
          children: [
            SizedBox(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Image.network(
                      Constant.imageUrl + (model.posterPath ?? ""),
                      fit: BoxFit.fitWidth,
                      loadingBuilder: (ctx, child, progress) {
                        if (progress == null) {
                          return child;
                        } else {
                          return CommonShimmer(
                            isLoading: true,
                            child: Container(
                              height: double.maxFinite,
                              width: double.maxFinite,
                              color: sampleAppBlack,
                            ),
                          );
                        }
                      },
                      errorBuilder: (context, exception, stackTrace) {
                        return const Center(
                          child: Icon(
                            Icons.broken_image_rounded,
                            size: 45,
                            color: sampleAppHintText,
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
            DraggableScrollableSheet(
              minChildSize: 0.5,
              builder: (context, controller) {
                controller.addListener(() {
                  if (controller.position.pixels == controller.position.maxScrollExtent) {
                    if (shouldLoadMore) {
                      pageNumber++;
                      bloc.add(GetFilmRecom(model.id ?? 0, page: pageNumber));
                    }
                  }
                });
                return Container(
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(8),
                      topRight: Radius.circular(8),
                    ),
                    gradient: LinearGradient(
                      colors: [
                        sampleAppWhite.withOpacity(0),
                        // sampleAppWhite.withOpacity(0.5),
                        sampleAppWhite,
                        sampleAppWhite,
                        sampleAppWhite,
                        sampleAppWhite,
                      ],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                  ),
                  child: SizedBox(
                    height: context.deviceHeight,
                    child: SingleChildScrollView(
                      controller: controller,
                      padding: sampleAppOutterPadding,
                      physics: const ClampingScrollPhysics(),
                      child: BlocBuilder<FilmBloc, FilmState>(
                        builder: (context, state) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(
                                height: kToolbarHeight + 20,
                              ),
                              Text(
                                model.title ?? "",
                                style: TextStyle(
                                  fontSize: context.scaleFont(24),
                                  color: sampleAppMenuBg,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                              Visibility(
                                visible: model.tagline != null,
                                child: InfoLabel(
                                  label: (model.tagline ?? ""),
                                  fontSize: 18,
                                ),
                              ),
                              InfoLabel(
                                enableTitle: true,
                                title: "Genres",
                                label:
                                    (model.genres?.isNotEmpty == true) ? ((model.genres?.map((e) => e.name).toList().join(", ") ?? "") + ".") : "-",
                              ),
                              InfoLabel(
                                label: minuteToHHmm((model.runtime ?? 0).toDouble()),
                              ),
                              InfoLabel(
                                enableTitle: true,
                                title: "Languages",
                                label: (model.spokenLanguages?.isNotEmpty == true)
                                    ? ((model.spokenLanguages?.map((e) => e.name).toList().join(", ") ?? "") + ".")
                                    : "-",
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(vertical: 8),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Image.asset(
                                      "assets/star.png",
                                      width: context.scaleFont(18),
                                      height: context.scaleFont(18),
                                    ),
                                    const SizedBox(
                                      width: 8,
                                    ),
                                    Text(
                                      NumberFormat.compact().format(reduceToTwoPrecision(model.popularity ?? 0)),
                                      style: TextStyle(
                                        fontSize: context.scaleFont(16),
                                        color: sampleAppBlack,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 24,
                                    ),
                                    Image.asset(
                                      "assets/thumb.png",
                                      width: context.scaleFont(18),
                                      height: context.scaleFont(18),
                                    ),
                                    const SizedBox(
                                      width: 8,
                                    ),
                                    Text(
                                      reduceToTwoPrecision(model.voteAverage).toString() + "%",
                                      style: TextStyle(
                                        fontSize: context.scaleFont(16),
                                        color: sampleAppBlack,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              InfoLabel(
                                enableTitle: true,
                                title: "Overview",
                                label: model.overview ?? "-",
                                overflow: TextOverflow.clip,
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                              Visibility(
                                visible: listfilms.isNotEmpty,
                                child: Text(
                                  "More for you",
                                  style: TextStyle(
                                    fontSize: context.scaleFont(20),
                                    color: sampleAppMenuBg,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              GridView.count(
                                crossAxisCount: 2,
                                padding: const EdgeInsets.only(top: 16),
                                childAspectRatio: 9 / 19,
                                mainAxisSpacing: 12,
                                crossAxisSpacing: 12,
                                physics: const NeverScrollableScrollPhysics(),
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
                                        hero: false,
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
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
