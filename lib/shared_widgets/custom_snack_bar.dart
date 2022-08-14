import 'package:flutter/material.dart';
import 'package:technical_take_home/theme/colors.dart';

successSnackBar(String? message) {
  return SnackBar(
    duration: const Duration(seconds: 5),
    behavior: SnackBarBehavior.floating,
    content: Text(
      message ?? 'OK',
      style: const TextStyle(color: sampleAppWhite, fontSize: 16),
    ),
    backgroundColor: sampleAppSuccess,
  );
}

failSnackBar(String? message) {
  return SnackBar(
    duration: const Duration(seconds: 5),
    behavior: SnackBarBehavior.floating,
    content: Text(
      message ?? 'GAGAL',
      style: const TextStyle(color: sampleAppWhite, fontSize: 16),
    ),
    backgroundColor: sampleAppWarning,
  );
}

functionSnackbar({String? message, Color? color, required Function() onAccept}) {
  return SnackBar(
    duration: const Duration(seconds: 1),
    behavior: SnackBarBehavior.floating,
    content: Text(
      message ?? '',
      style: const TextStyle(color: sampleAppWhite, fontSize: 16),
    ),
    action: SnackBarAction(
      label: 'Oke',
      textColor: sampleAppWhite,
      onPressed: onAccept,
    ),
    backgroundColor: color,
  );
}

error(BuildContext ctx, String msg) {
  ScaffoldMessenger.of(ctx)
    ..hideCurrentSnackBar()
    ..showSnackBar(failSnackBar(msg));
}

success(BuildContext ctx, String msg) {
  ScaffoldMessenger.of(ctx)
    ..hideCurrentSnackBar()
    ..showSnackBar(successSnackBar(msg));
}
