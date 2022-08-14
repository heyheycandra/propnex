import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

String? validateEmail(FocusNode focus, String value) {
  String pattern =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
  RegExp regex = RegExp(pattern);
  if (!regex.hasMatch(value)) {
    focus.requestFocus();
    return 'Format e-mail salah';
  } else {
    return null;
  }
}

bool validateEmailBool(String value) {
  String pattern =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
  RegExp regex = RegExp(pattern);
  return (!regex.hasMatch(value));
}

String convertDateToStringFormat(DateTime date, String format, {bool? utcOffset, String? utcOffsetFormat}) {
  var formatter = DateFormat(format);
  Duration offset = date.timeZoneOffset;
  String hoursOffset = offset.inHours.toString().padLeft(2, '0');
  String minutesOffset = (offset.inMinutes - (offset.inHours * 60)).toString().padLeft(2, '0');

  if (utcOffset != null && utcOffset) {
    if (utcOffsetFormat != null) {
      if (offset.isNegative) {
        return formatter.format(date) + utcOffsetFormat.replaceAll('HH', hoursOffset).replaceAll('mm', minutesOffset).replaceAll('p', '-');
      } else if (!offset.isNegative) {
        return formatter.format(date) + '+${utcOffsetFormat.replaceAll('HH', hoursOffset).replaceAll('mm', minutesOffset).replaceAll('p', '+')}';
      }
    } else {
      if (offset.isNegative) {
        return formatter.format(date) + '-$hoursOffset$minutesOffset';
      } else if (!offset.isNegative) {
        return formatter.format(date) + '+$hoursOffset$minutesOffset';
      }
    }
  }
  return formatter.format(date);
}

String convertDateToString(DateTime date) {
  var formatter = DateFormat('dd-MM-yyyy');

  return formatter.format(date);
}

/// * Returns Format of [HH:mm] time
String convertTimeToString(TimeOfDay timeOfDay) {
  var formatter = DateFormat('HH:mm');
  final now = DateTime.now();
  final dt = DateTime(now.year, now.month, now.day, timeOfDay.hour, timeOfDay.minute);
  return formatter.format(dt);
}

extension StringExtension on String {
  String get capitalize {
    String getString = this;
    return getString[0].toUpperCase() + getString.substring(1);
  }
}

DateTime? convertStringToDateFormat(String? sDate, String format) {
  var formatter = DateFormat(format);

  if (sDate != null) {
    try {
      int index = format.indexOf('MMM');
      if (index >= 0) {
        String mon = sDate.substring(index, (index + 3));
        String monC = (mon.toLowerCase()).capitalize;
        sDate = sDate.replaceAll(mon, monC);
      }
      int i = format.indexOf('MMMM');

      if (i >= 0) {
        String mon = sDate.substring(i, (i + 4));
        String monC = mon.capitalize;
        sDate = sDate.replaceAll(mon, monC);
      }

      return formatter.parse(sDate);
    } catch (e) {
      return null;
    }
  } else {
    return null;
  }
}

TimeOfDay? convertStringToTimeFormat(String? tod, String format) {
  TimeOfDay? time;
  final date = convertStringToDateFormat(tod, format); //"6:00 AM"
  if (date != null) TimeOfDay.fromDateTime(date);
  return time;
}

/// returns DateTime
/// * from strict ['dd-MM-yyyy'] String date format.
DateTime? convertStringToDate(String sDate) {
  var formatter = DateFormat('dd-MM-yyyy');
  try {
    return formatter.parse(sDate);
  } catch (e) {
    return null;
  }
}

showSnackbar(BuildContext context, message) {
  ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(SnackBar(
      duration: const Duration(seconds: 1),
      behavior: SnackBarBehavior.floating,
      content: Text(
        message ?? 'Ooops, Something wrong. Try again',
        style: const TextStyle(color: Colors.white, fontSize: 16),
      ),
    ));
}

String toCamelCase(String val) {
  String x = val.split(" ").map((str) => toBeginningOfSentenceCase(str)).join(" ");
  return x.replaceAll(" ", '');
}

String getLink(String content) {
  String link = content;
  String url = '';
  RegExp exp = RegExp(r'(?:(?:https?|ftp):\/\/)?[\w/\-?=%.]+\.[\w/\-?=%.]+');
  final text = content;
  String? parse1;
  String? parse2;
  String? parsedLink;
  Iterable<RegExpMatch> matches = exp.allMatches(text);
  for (var match in matches) {
    url = text.substring(match.start, match.end);
    if (url.isNotEmpty && url.contains('.com')) {
      parse1 = link.replaceAll(url, '<a href= "https://' + url + '" target="_blank">' + url + '</a>');
      parse2 = link.replaceAll(url, '<a href= "' + url + '" target="_blank">' + url + '</a>');
      parsedLink = (!url.contains('https://') ? parse1 : parse2);
    }
    if (parsedLink != null && !content.contains('</a>')) {
      link = parsedLink;
      if (link.isNotEmpty && !link.startsWith("http")) {
        link = "https://" + link;
      }
    } else {
      link = content;
    }
  }
  return link;
}

String convertToTitleCase(String? text) {
  if (text == null) {
    return "";
  }

  if (text.length <= 1) {
    return text.toUpperCase();
  }

  // Split string into multiple words
  final List<String> words = text.split(' ');

  // Capitalize first letter of each words
  final capitalizedWords = words.map((word) {
    if (word.trim().isNotEmpty) {
      final String firstLetter = word.trim().substring(0, 1).toUpperCase();
      final String remainingLetters = word.trim().substring(1).toLowerCase();

      return '$firstLetter$remainingLetters';
    }
    return '';
  });

  // Join/Merge all words back to one String
  return capitalizedWords.join(' ');
}

void onLoading(BuildContext context) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return Dialog(
        child: Container(
          padding: const EdgeInsets.all(20),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: const [
              CircularProgressIndicator(),
              SizedBox(
                width: 15,
              ),
              Text("Loading"),
            ],
          ),
        ),
      );
    },
  );
}

extension NumberExtract on String? {
  String get number {
    String number = "0";
    if (this == null || this!.isEmpty) {
      return number;
    } else {
      number = this!.replaceAll(RegExp(r'[^0-9]'), '');
      return number.isEmpty ? "0" : number;
    }
  }

  String get numberFilter {
    String number = "";
    if (this == null || this!.isEmpty) {
      return number;
    } else {
      number = this!.replaceAll(RegExp(r'[^0-9]'), '');
      return number;
    }
  }
}

hideKeyboard(BuildContext context) {
  FocusScope.of(context).requestFocus(FocusNode());
}

String minuteToHHmm(double? minute) {
  if (minute == null) {
    return "0h 0m";
  } else {
    final hours = (minute / 60).floor();
    final mod = (minute % 60);
    return ((hours > 0) ? hours.toString() + "h " : "") +
        ((mod > 0) ? ((mod < 10) ? ("0" + (mod.floor()).toString()) : (mod.floor()).toString() + "m") : "");
  }
}

num reduceToTwoPrecision(double? number) {
  if (number == null) {
    return 0;
  } else {
    final prec = number * 100;
    final redc = prec.floor();
    final disp = redc / 100;
    if (disp % 1 == 0) {
      return disp.toInt();
    } else {
      return disp;
    }
  }
}
