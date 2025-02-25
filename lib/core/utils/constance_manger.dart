import 'package:intl/intl.dart';

class ConstanceManger {
  static String? token = "AJeRlOMZpzdUUTwFqztx88IQ9hb2";
  static String formatDateTime(DateTime dateTime) {
    String month = DateFormat('MMM').format(dateTime).toUpperCase();
    return "$month ${dateTime.day}, ${dateTime.year}";
  }

}
