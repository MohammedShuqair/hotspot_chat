import 'package:intl/intl.dart';

class DateFormater {
  static String messageDate(DateTime inputTime) {
    final d = inputTime;
    final now = DateTime.now();
    final diff = now.difference(d);
    final diffInYear = (diff.inDays / 365).floor();
    final diffInMonth = (diff.inDays / 30).floor();
    final diffInWeeks = (diff.inDays / 7).floor();
    if (diffInYear >= 1) {
      return DateFormat('yyyy').format(d);
    } else if (diffInMonth >= 1) {
      return DateFormat('MMM d').format(d);
    } else if (diffInWeeks >= 1) {
      return DateFormat('d MMM yyyy').format(d);
    } else if (diff.inDays > 1) {
      return DateFormat('E').format(d);
    } else if (diff.inDays == 1) {
      return 'yesterday';
    } else if (diff.inHours >= 1) {
      return '${diff.inHours} hour';
    } else if (diff.inMinutes >= 1) {
      return '${diff.inMinutes} minute';
    } else if (diff.inSeconds >= 3) {
      return '${diff.inSeconds} second';
    } else {
      return 'now';
    }
  }
}
