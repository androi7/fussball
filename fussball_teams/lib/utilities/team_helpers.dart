import 'package:intl/intl.dart';

class TeamHelpers {
  static erhalteMarktwert({required int? value, bool withCurrency = false}) {
    var f = NumberFormat('#,###'); // , 'de_DE'
    if (value == null) {
      return 'unbekant';
    } else if (value > 1) {
      return '${f.format(value)} Millionen${withCurrency ? ' Euro' : ''}';
    } else {
      return '$value Million${withCurrency ? ' Euro' : ''}';
    }
  }
}
