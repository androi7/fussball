import 'package:intl/intl.dart';

import 'sprache_provider.dart';

// enum Sprache {
//   deutsch,
//   englisch,
//   polnisch,
// }

enum Bereich {
  fehler,
  club,
}

class TextBibliothek {
  static String erhalteText({
    required Sprache sprache,
    required Bereich bereich,
    required int position,
    String? ersterWert,
    String? zweiterWert,
  }) {
    return _bibliothek(ersterWert, zweiterWert)[sprache][bereich][position]
        as String;
  }

  static Map<Sprache, dynamic> _bibliothek(
    String? ersterWert,
    String? zweiterWert,
  ) =>
      {
        Sprache.deutsch: {
          Bereich.club: [
            'Der Club ',
            ' aus $ersterWert hat einen Wert von $zweiterWert.',
          ],
        },
        Sprache.englisch: {
          Bereich.club: [
            'The Club ',
            ' from $ersterWert is worth $zweiterWert.',
          ]
        }
      };
}
