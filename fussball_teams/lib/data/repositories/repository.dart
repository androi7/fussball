// Modelle
import '../models/models.dart';

abstract class Repository {
  Future<List<Team>> erhalteFussballTeams();

  List<Team> sortieren({
    List<Team> teams = const [],
    bool nachName = true,
  }) {
    // für das Sortieren einer Liste benötigt es mindestens zwei Einheiten
    if (teams.length > 1) {
      if (nachName) {
        teams.sort((a, b) => a.name.compareTo(b.name));
      } else {
        teams.sort((a, b) {
          final vorherigerWert = a.value ?? 0;
          final naechsterWert = b.value ?? 0;
          return vorherigerWert.compareTo(naechsterWert);
        });
      }
    }
    return teams;
  }
}
