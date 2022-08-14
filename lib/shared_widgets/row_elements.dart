import 'package:flutter/material.dart';
import 'package:technical_take_home/helper/app_scale.dart';
import 'package:technical_take_home/helper/constant.dart';
import 'package:technical_take_home/helper/locator.dart';
import 'package:technical_take_home/helper/navigator_service.dart';
import 'package:technical_take_home/model/movie.dart';
import 'package:technical_take_home/shared_widgets/common_shimmer.dart';
import 'package:technical_take_home/theme/colors.dart';

class LoadingRow extends StatelessWidget {
  const LoadingRow({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: context.deviceWidth / 4,
      child: AspectRatio(
        aspectRatio: 9 / 22,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            AspectRatio(
              aspectRatio: 9 / 16,
              child: CommonShimmer(
                isLoading: true,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: sampleAppBlack,
                  ),
                  width: double.maxFinite,
                  height: double.maxFinite,
                ),
              ),
            ),
            const SizedBox(
              height: 4,
            ),
            Expanded(
              child: CommonShimmer(
                isLoading: true,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    color: sampleAppBlack,
                  ),
                  width: double.maxFinite,
                ),
              ),
            ),
            const SizedBox(
              height: 4,
            ),
            Expanded(
              child: LayoutBuilder(
                builder: (ctx, ctn) {
                  return CommonShimmer(
                    isLoading: true,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        color: sampleAppBlack,
                      ),
                      width: ctn.maxWidth * 0.75,
                      // height:,
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SeeMoreRow extends StatelessWidget {
  final Function()? onTap;
  const SeeMoreRow({this.onTap, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: context.deviceWidth / 4,
      child: AspectRatio(
        aspectRatio: 9 / 22,
        child: Column(
          children: [
            AspectRatio(
              aspectRatio: 9 / 16,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: InkWell(
                  onTap: () {
                    if (onTap != null) {
                      onTap!();
                    }
                  },
                  child: ColoredBox(
                    color: sampleAppLightBlue,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          decoration: const BoxDecoration(shape: BoxShape.circle, color: sampleAppWhite),
                          padding: const EdgeInsets.all(8),
                          child: const Icon(
                            Icons.chevron_right_rounded,
                            size: 24,
                            color: sampleAppMenuBg,
                          ),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: Text(
                            "See More",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: context.scaleFont(16),
                              color: sampleAppMenuBg,
                              overflow: TextOverflow.clip,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ImageRow extends StatelessWidget {
  final String? title, path;
  final Movie model;
  final bool? hero;
  final BoxFit? fit;
  final TextStyle? titleStyle;
  const ImageRow({
    this.fit,
    required this.model,
    this.titleStyle,
    required this.path,
    this.hero,
    this.title,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: context.deviceWidth / 4,
      child: AspectRatio(
        aspectRatio: 9 / 22,
        child: Column(
          children: [
            AspectRatio(
              aspectRatio: 9 / 16,
              child: InkWell(
                onTap: () {
                  locator<NavigatorService>().navigateToWithArgmnt(Constant.menuDetails, model);
                },
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Builder(builder: (context) {
                    if (model.id != null && path?.isNotEmpty == true) {
                      if (hero == false) {
                        return Image.network(
                          Constant.imageUrl + path!,
                          fit: fit ?? BoxFit.fitHeight,
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
                        );
                      } else {
                        return Hero(
                          tag: model.strId ?? "0",
                          child: Image.network(
                            Constant.imageUrl + path!,
                            fit: fit ?? BoxFit.fitHeight,
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
                        );
                      }
                    } else {
                      return const Center(
                        child: Icon(
                          Icons.broken_image_rounded,
                          size: 45,
                          color: sampleAppHintText,
                        ),
                      );
                    }
                  }),
                ),
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            Builder(builder: (context) {
              if (title?.isNotEmpty == true) {
                return Text(
                  title!,
                  maxLines: 2,
                  textAlign: TextAlign.center,
                  style: titleStyle ??
                      TextStyle(
                        fontSize: context.scaleFont(14),
                        color: sampleAppBlack,
                        overflow: TextOverflow.ellipsis,
                      ),
                );
              } else {
                return const Expanded(child: SizedBox());
              }
            })
          ],
        ),
      ),
    );
  }
}
