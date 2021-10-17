import 'package:fussball_teams/models/sprache_provider.dart';
import 'package:intl/intl.dart';

class TeamHelpers {
  static erhalteMarktwert({
    required Sprache sprache,
    required int? value,
    bool withCurrency = false,
  }) {
    var f = NumberFormat('#,###');
    if (sprache == Sprache.deutsch) {
      if (value == null) {
        return 'unbekannt';
      } else if (value > 1) {
        return '${f.format(value)} Millionen${withCurrency ? ' Euro' : ''}';
      } else {
        return '$value Million${withCurrency ? ' Euro' : ''}';
      }
    } else if (sprache == Sprache.englisch) {
      if (value == null) {
        return 'unknown';
      } else if (value > 1) {
        return '${f.format(value)} millions${withCurrency ? ' Euro' : ''}';
      } else {
        return '$value million${withCurrency ? ' Euro' : ''}';
      }
    } else {
      throw Exception('Polnisch noch nicht implementiert');
    }
  }
}
