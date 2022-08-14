import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DateUtil {
  String ddMMMyyyy(DateTime dateTime) {
    String formattedDate = DateFormat('dd MMM yyyy').format(dateTime);
    return formattedDate;
  }

  String mMMddyyyy(DateTime dateTime) {
    String formattedDate = DateFormat('MMM dd, yyyy').format(dateTime);
    return formattedDate;
  }

  DateTime? ddMMMyyy(String sDate) {
    DateFormat dateFormat = DateFormat('dd MMM yyyy');
    DateTime? dateTime;
    try {
      dateTime = dateFormat.parse(sDate);
    } catch (e) {
      debugPrint(e.toString());
      // e.printStackTrace();
    }
    return dateTime;
  }

  DateTime? ddMMMyyyHHmm(String sDate) {
    DateFormat dateFormat = DateFormat('dd MMM yyyy HH:mm');
    DateTime? dateTime;
    try {
      dateTime = dateFormat.parse(sDate);
    } catch (e) {
      debugPrint(e.toString());
    }
    return dateTime;
  }

  String millisToShortDHM(int duration) {
    Duration dur = Duration(milliseconds: duration);
    int days = dur.inDays;
    int hours = dur.inHours - Duration(days: days).inHours;
    int minuts = dur.inMinutes - Duration(hours: hours).inMinutes;
    String res = "";

    if (duration == 0) {
      res = "Closed";
    } else if (days == 0 && hours == 0) {
      res = minuts.toString() + " minutes";
    } else if (days == 0) {
      res = hours.toString() + " hours " + minuts.toString() + " minutes";
    } else {
      res = days.toString() + " days " + hours.toString() + " hours";
    }
    return res;
  }

  String? dateStartValid(String start, String end) {
    String? res = "";
    DateTime startDt;
    DateTime endDt;
    DateFormat dateFormat = DateFormat('dd MMM yyyy HH:mm');
    try {
      endDt = dateFormat.parse(end);
      startDt = dateFormat.parse(start);
      int diff = endDt.millisecondsSinceEpoch - DateTime.now().millisecondsSinceEpoch;
      if (startDt.millisecondsSinceEpoch > DateTime.now().millisecondsSinceEpoch) {
        res = null;
      } else {
        res = millisToShortDHM(diff);
      }
    } catch (e) {
      return res;
    }
    return res;
  }

  String dateTimeddMmmYyyyHhmm(DateTime dateTime) {
    String formattedDate = DateFormat('dd MMM yyyy HH:mm').format(dateTime);
    return formattedDate;
  }

  String dateTimeddMmmYyyy(DateTime dateTime) {
    String formattedDate = DateFormat('dd MMM yyyy').format(dateTime);
    return formattedDate;
  }

  String dateTimeHhmm(DateTime dateTime) {
    String formattedDate = DateFormat('HH:mm').format(dateTime);
    return formattedDate;
  }

  String timeOfDayHHmm(TimeOfDay tod) {
    final now = DateTime.now();
    final dt = DateTime(now.year, now.month, now.day, tod.hour, tod.minute);
    return dateTimeHhmm(dt);
  }
}
