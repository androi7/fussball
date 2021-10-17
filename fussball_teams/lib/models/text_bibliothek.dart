import 'sprache_provider.dart';

enum Bereich {
  fehler,
  club,
}

/// Die TextBibliothek enthält den Inhalt für die
/// verschiedenen Clubs. Die einzelnen Textinhalte
/// können mit den Parametern aus [Sprache], [Bereich]
/// und der Position des zurückgegebenen Arrays ausgegeben
/// werden.
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
