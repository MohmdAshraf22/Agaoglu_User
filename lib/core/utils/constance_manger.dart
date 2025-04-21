import 'package:intl/intl.dart';

class ConstanceManger {
  static String formatDateTime(DateTime dateTime) {
    String month = DateFormat('MMM').format(dateTime).toUpperCase();
    return "$month ${dateTime.day}, ${dateTime.year}";
  }

  static const String defaultImage =
      "https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png";
}
