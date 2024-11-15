import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:intl/intl.dart';


extension date_ex on DateTime{
  String get toFormattedDate=> '${day} / ${month} / ${year}';
  String get getDayName{
    DateFormat formatter=DateFormat('E');
    return formatter.format(this);
  }
}