import 'package:flutter/material.dart';
import 'package:technical_take_home/theme/colors.dart';
import 'package:technical_take_home/helper/app_scale.dart';

class ButtonConfirm extends StatefulWidget {
  final Function()? onTap;
  final String? text;
  final double? width;

  const ButtonConfirm({this.text, this.onTap, this.width, Key? key}) : super(key: key);

  @override
  _ButtonConfirmState createState() => _ButtonConfirmState();
}

class _ButtonConfirmState extends State<ButtonConfirm> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width ?? MediaQuery.of(context).size.width,
      child: ButtonTheme(
        disabledColor: sampleAppUnselect,
        // buttonColor: sampleAppPrimary,
        child: TextButton(
          onPressed: widget.onTap,
          child: Container(
            margin: const EdgeInsets.only(top: 8, bottom: 8),
            // child: FittedBox(
            child: Text(
              widget.text ?? "",
              style: TextStyle(
                  fontSize: context.scaleFont(14), color: widget.onTap != null ? sampleAppWhite : sampleAppBlack, fontWeight: FontWeight.bold),
              maxLines: 1,
            ),
            // ),
          ),
          style: TextButton.styleFrom(
            shape: RoundedRectangleBorder(
                side: BorderSide(color: widget.onTap != null ? sampleAppPrimary : sampleAppDarkGray, width: 1.8),
                borderRadius: BorderRadius.circular(8)),
            backgroundColor: widget.onTap != null ? sampleAppPrimary : sampleAppDarkGray,
            // primary: sampleAppPrimary,
          ),
        ),
      ),
    );
  }
}

class ButtonCancel extends StatefulWidget {
  final Function()? onTap;
  final String? text;
  final double? width;

  const ButtonCancel({Key? key, this.text, this.onTap, this.width}) : super(key: key);
  @override
  _ButtonCancelState createState() => _ButtonCancelState();
}

class _ButtonCancelState extends State<ButtonCancel> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width ?? MediaQuery.of(context).size.width,
      child: ButtonTheme(
        disabledColor: sampleAppUnselect,
        // buttonColor: sampleAppWhite,
        child: TextButton(
          onPressed: widget.onTap,
          child: Container(
            margin: const EdgeInsets.only(top: 8, bottom: 8),
            child: FittedBox(
              child: Text(
                widget.text ?? "",
                style: TextStyle(
                    fontSize: context.scaleFont(14), color: widget.onTap != null ? sampleAppPrimary : sampleAppBlack, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          style: TextButton.styleFrom(
            shape: RoundedRectangleBorder(
                side: BorderSide(color: widget.onTap != null ? sampleAppPrimary : sampleAppDarkGray, width: 1.8),
                borderRadius: BorderRadius.circular(8)),
            // primary: sampleAppWhite,
            backgroundColor: sampleAppWhite,
          ),
        ),
      ),
    );
  }
}

class ButtonConfirmWithIcon extends StatefulWidget {
  final Function()? onTap;
  final String? text;
  final IconData? icon;
  final double? width;

  const ButtonConfirmWithIcon({this.icon, this.text, this.onTap, this.width, Key? key})
      : assert(icon != null, text != null),
        super(key: key);

  @override
  _ButtonConfirmWithIconState createState() => _ButtonConfirmWithIconState();
}

class _ButtonConfirmWithIconState extends State<ButtonConfirmWithIcon> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width ?? MediaQuery.of(context).size.width,
      child: ButtonTheme(
        disabledColor: sampleAppUnselect,
        // buttonColor: sampleAppPrimary,
        child: TextButton.icon(
          onPressed: widget.onTap,
          icon: Container(
            margin: const EdgeInsets.only(top: 8, bottom: 8),
            child: Icon(
              widget.icon,
              color: widget.onTap != null ? sampleAppWhite : sampleAppBlack,
              size: context.scaleFont(15),
            ),
          ),
          label: Container(
            margin: const EdgeInsets.only(top: 8, bottom: 8),
            child: Text(
              widget.text ?? "",
              style: TextStyle(fontSize: 14, color: widget.onTap != null ? sampleAppWhite : sampleAppBlack, fontWeight: FontWeight.bold),
              maxLines: 1,
            ),
          ),
          style: TextButton.styleFrom(
            shape: RoundedRectangleBorder(
              side: BorderSide(color: widget.onTap != null ? sampleAppTrafficYellow : sampleAppDarkGray, width: 1.8),
              borderRadius: BorderRadius.circular(16),
            ),
            backgroundColor: widget.onTap != null ? sampleAppTrafficYellow : sampleAppDarkGray,
          ),
        ),
      ),
    );
  }
}
