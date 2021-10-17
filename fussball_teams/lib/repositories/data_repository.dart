import 'package:fussball_teams/models/models.dart';
import 'package:fussball_teams/services/api.dart';
import 'package:fussball_teams/services/api_service.dart';
import 'package:http/http.dart';

class DataRepository {
  DataRepository({required this.apiService});
  final APIService apiService;

  Future<List<Team>> erhalteFussballTeams() async {
    try {
      final data =
          await apiService.erhalteEndpointData(endpoint: Endpoint.teams);
      List<Team> teams = [];

      for (var team in data) {
        teams.add(Team.fromJson(team));
      }
      teams = sortieren(teams: teams);
      return teams;
    } on Response catch (e, st) {
      print('Anfragefehler: $e, $st');
      rethrow;
    }
  }

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
