// final String date =
import 'package:intl/intl.dart';

final DateTime today = DateTime.now();
final DateTime before7Days = today.subtract(Duration(days: 7));
final DateFormat formatter = DateFormat('yyyy-MM-dd');
final String todayFormat = formatter.format(today);
final String before7DaysFormat = formatter.format(before7Days);
