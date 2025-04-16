import 'package:intl/intl.dart';

class DateFormatter {
  static String format(DateTime date) {
    return DateFormat('dd-MM-yyyy').format(date);
  }

  static DateTime parse(String dateString) {
    return DateFormat('dd-MM-yyyy').parse(dateString);
  }
}