// Packages
import 'package:http/http.dart';

// Modelle
import '../models/models.dart';

// Repositories
import 'repository.dart';

// Services
import '../services/api.dart';
import '../services/api_service.dart';

/// Diese Klasse enthält alle HTTP Requests, sowie eine
/// zusätzliche Funktion [sortieren], um Fussball Clubs
/// entweder aufsteigend nach deren Namen oder dessen
/// Vereinswerts zu sortieren.
class DataRepository extends Repository {
  DataRepository({required this.apiService});
  final APIService apiService;

  @override
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
    } on Response catch (_) {
      rethrow;
    }
  }
}
