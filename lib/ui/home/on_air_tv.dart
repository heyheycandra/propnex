import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:technical_take_home/bloc/tv_bloc/serial_bloc.dart';
import 'package:technical_take_home/helper/app_scale.dart';
import 'package:technical_take_home/helper/constant.dart';
import 'package:technical_take_home/helper/locator.dart';
import 'package:technical_take_home/helper/navigator_service.dart';
import 'package:technical_take_home/model/movie.dart';
import 'package:technical_take_home/shared_widgets/common_shimmer.dart';
import 'package:technical_take_home/shared_widgets/custom_snack_bar.dart';
import 'package:technical_take_home/shared_widgets/grid_elements.dart';
import 'package:technical_take_home/theme/colors.dart';

class OnAirTv extends StatefulWidget {
  const OnAirTv({Key? key}) : super(key: key);

  @override
  State<OnAirTv> createState() => _OnAirTvState();
}

class _OnAirTvState extends State<OnAirTv> {
  List<Movie> listfilms = [];
  bool loaded = false;
  @override
  Widget build(BuildContext context) {
    return BlocListener<SerialBloc, SerialState>(
      listener: (context, state) {
        if (state is LoadSerialNP) {
          listfilms = List.from(state.listSerials);
          loaded = true;
        }
        if (state is SerialError) {
          error(context, state.error);
          loaded = true;
        }
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          BlocBuilder<SerialBloc, SerialState>(
            builder: (context, state) {
              return Visibility(
                visible: (state is SerialLoading) || listfilms.isNotEmpty,
                child: CommonShimmer(
                  isLoading: state is SerialLoading,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: sampleAppWhite,
                    ),
                    padding: const EdgeInsets.only(top: 8, bottom: 8, right: 8),
                    margin: const EdgeInsets.only(bottom: 8),
                    child: Text(
                      "Tv Series",
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
          BlocBuilder<SerialBloc, SerialState>(
            builder: (context, state) {
              if (state is SerialLoading) {
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
                                locator<NavigatorService>().navigateTo(Constant.menuSeries);
                              },
                            );
                          } else {
                            final path = listfilms[index].posterPath;
                            final title = listfilms[index].name;
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
