import 'package:intl/intl.dart';

String getFormattedDate(DateTime date) {
  DateTime now = DateTime.now();
  if (date.year == now.year && date.month == now.month && date.day == now.day) {
    return 'Today ${DateFormat.jm().format(date)}';
  } else if (date.year == now.year &&
      date.month == now.month &&
      date.day == now.day - 1) {
    return 'Yesterday ${DateFormat.jm().format(date)}';
  }
  return DateFormat('dd/MM/yy hh:mm a').format(date);
}
