import 'package:flutter/material.dart';
import 'package:technical_take_home/helper/app_scale.dart';

import 'buttons.dart';

class DeleteDialog extends StatelessWidget {
  final Function()? onPressYes;
  final Function()? onPressLater;
  final String? alertMessage;
  final String? yesLabel;
  final String? noLabel;

  const DeleteDialog({Key? key, this.onPressYes, this.onPressLater, this.alertMessage, this.noLabel, this.yesLabel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      content: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Container(
              margin: const EdgeInsetsDirectional.only(bottom: 16),
              child: Text(
                alertMessage ?? '-',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: context.scaleFont(14), color: const Color(0xFF232020)),
              ),
            ),
            Container(
              margin: const EdgeInsetsDirectional.only(),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ButtonCancel(
                    text: noLabel ?? 'Batal',
                    width: MediaQuery.of(context).size.width / 3.9,
                    onTap: onPressLater,
                  ),
                  ButtonConfirm(
                    text: yesLabel ?? 'Ya',
                    width: MediaQuery.of(context).size.width / 3.9,
                    onTap: onPressYes,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
