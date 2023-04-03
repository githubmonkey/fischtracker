import 'package:intl/intl.dart';

class Format {
  static String duration(Duration duration) {
    var minutes = duration.inMinutes;
    final sign = (minutes < 0) ? "-" : "";
    minutes = minutes.abs();

    var hours = minutes ~/ Duration.minutesPerHour;
    minutes = minutes.remainder(Duration.minutesPerHour);
    final minutesPadding = minutes < 10 ? "0" : "";

    return '$sign${hours.abs()}h:$minutesPadding$minutes';
  }

  static String date(DateTime date) {
    return DateFormat.yMMMd().format(date);
  }

  static String dayOfWeek(DateTime date) {
    return DateFormat.E().format(date);
  }

  static String longdate(DateTime date) {
    return DateFormat.yMMMEd().format(date);
  }

  static String currency(double pay) {
    if (pay != 0.0) {
      final formatter = NumberFormat.simpleCurrency(decimalDigits: 0);
      return formatter.format(pay);
    }
    return '';
  }
}
