import 'package:intl/intl.dart';

final DateTime today = DateTime.now();
final DateTime before7Days = today.subtract(Duration(days: 7));
final DateTime before30Days = today.subtract(Duration(days: 30));
final DateTime past1000Days = today.add(Duration(days: 1000));

final DateFormat formatter = DateFormat('yyyy-MM-dd');

final String todayFormat = formatter.format(today);
final String before7DaysFormat = formatter.format(before7Days);
final String before30DaysFormat = formatter.format(before30Days);
final String past1000DaysFormat = formatter.format(past1000Days);
