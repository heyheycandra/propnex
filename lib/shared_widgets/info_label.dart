import 'package:flutter/material.dart';
import 'package:styled_text/styled_text.dart';
import 'package:technical_take_home/helper/app_scale.dart';
import 'package:technical_take_home/theme/colors.dart';

class InfoLabel extends StatelessWidget {
  final String label;
  final String? title;
  final bool? enableTitle;
  final Color? color;
  final double? fontSize;
  final TextOverflow? overflow;
  final FontWeight? fontWeight;
  const InfoLabel({
    Key? key,
    this.color,
    this.overflow,
    this.enableTitle,
    this.title,
    this.fontSize,
    this.fontWeight,
    required this.label,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Visibility(
            visible: enableTitle == true,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: double.maxFinite,
                  child: StyledText(
                    text: title ?? "",
                    style: TextStyle(
                      fontSize: context.scaleFont(fontSize ?? 18),
                      color: color ?? sampleAppMenuBg,
                      fontWeight: fontWeight ?? FontWeight.bold,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
                const SizedBox(height: 8),
              ],
            ),
          ),
          SizedBox(
            width: double.maxFinite,
            child: StyledText(
              text: label,
              style: TextStyle(
                fontSize: context.scaleFont(fontSize ?? 14),
                color: color ?? sampleAppBlack,
                fontWeight: fontWeight ?? FontWeight.normal,
                overflow: overflow ?? TextOverflow.ellipsis,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
