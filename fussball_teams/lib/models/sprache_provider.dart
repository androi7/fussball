import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

enum Sprache {
  deutsch,
  englisch,
  polnisch,
}

class SpracheProvider extends ChangeNotifier {
  Sprache _sprache = Sprache.deutsch;
  String _laenderLokale = 'de_DE';

  Sprache get erhalteSprache => _sprache;
  String get erhalteLaenderLokale => _laenderLokale;

  void setzeSprache(String? land) {
    _sprache = _erhalteSprache(land);
    _laenderLokale = _erhalteLaenderLokale(_sprache);
    Intl.defaultLocale = _laenderLokale;
    print('SpracheProvider: $_sprache');
    print('SpracheProvider: $_laenderLokale');

    notifyListeners();
  }

  Sprache _erhalteSprache(String? land) {
    var deutsch = ['DE', 'CH', 'AU'];
    var polnisch = 'PL';
    if (land == null) {
      return Sprache.deutsch;
    } else if (deutsch.contains(land)) {
      return Sprache.deutsch;
    } else if (polnisch == land) {
      return Sprache.polnisch;
    } else {
      return Sprache.englisch;
    }
  }

  String _erhalteLaenderLokale(Sprache _sprache) {
    switch (_sprache) {
      case Sprache.deutsch:
        return 'de_DE';
      case Sprache.polnisch:
        return 'pl';
      case Sprache.englisch:
        return 'en_US';
      default:
        return 'de_DE';
    }
  }
}
